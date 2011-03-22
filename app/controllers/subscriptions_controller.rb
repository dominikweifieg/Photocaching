class SubscriptionsController < ApplicationController

  # PUT /subscriptions/1
  # PUT /subscriptions/1.xml
  def update
    @user = User.find_by_identifier(params[:id])

    json_request = {'receipt-data' => params[:transaction_receipt],
      'password' => '4b129eba080b4271b45f74afef2d70b5'}.to_json

      response = HTTParty.post(params[:store], :body => json_request)

      data = JSON.parse(response)
      
      logger.info("#{data}  ||||| status is => #{data['status']}")
      
      if data['status'].to_i == 0
        logger.info("We have a receipt")
        receipt = data['receipt']
        @user.product_id = receipt['product_id']
        logger.info("Receipt product id: #{@user.product_id}")
        if @user.product_id == "com.ars_subtilior.mobile.iphone.photocaching.monthly" || @user.product_id == "com.ars_subtilior.mobile.iphone.photocaching.half_year" || @user.product_id == "com.ars_subtilior.mobile.iphone.photocaching.year"
          logger.info("a subscription")
          @user.subscription = true
          original_transaction_id = receipt['original_transaction_id']
          transaction_id = receipt['transaction_id']
          unless original_transaction_id == transaction_id
            #a restored subscription!!!
            logger.info("a restored subscription")
            expires = DateTime.parse(receipt['purchase_date'])
            if @user.product_id == "com.ars_subtilior.mobile.iphone.photocaching.monthly"
              expires = expires + 1.month
            elsif @user.product_id == "com.ars_subtilior.mobile.iphone.photocaching.half_year"
              expires = expires + 6.months
            elsif @user.product_id == "com.ars_subtilior.mobile.iphone.photocaching.year"
              expires = expires + 1.year
            end
            logger.info("restored subscription end: #{expires}")
            if expires < @user.subscription_expires
              logger.info("no, we have a longer value in the db!!!!")
              expires = @user.subscription_expires
            end
          else
            logger.info("a new subscription")
            expires = DateTime.parse(receipt['expires_date'])
            @user.latest_receipt = data['latest_receipt']
            logger.info("the new subscription expires on #{expires}")
          end
        elsif receipt.has_key? 'original_purchase_date'
          logger.info("a restored monthly package")
          logger.info(receipt['original_purchase_date'])
          expires = DateTime.parse(receipt['original_purchase_date']) + 1.month
        else
          logger.info("a new monthly package")
          logger.info(receipt['purchase_date'])
          expires = DateTime.parse(receipt['purchase_date']) + 1.month
        end
        @user.subscription_expires = expires
        @user.original_transaction_id = receipt['original_transaction_id']
        @user.original_purchase_date = receipt['original_purchase_date']
        @user.purchase_date = receipt['purchase_date']
        
        if @user.save
          respond_to do |format|
            format.json { head :ok}
          end
        else
          respond_to do |format|
            format.json { head :failure}
          end
        end
      elsif data['status'].to_i == 21006
        if @user.subscription_expires.future?
          @user.subscription_expires = DateTime.new
          @user.save
          respond_to do |format|
            format.json { render :status => 402  }
          end
        end
      else
        respond_to do |format|
          format.json { render :status => :unprocessable_entity  }
        end
      end
    end

  end
