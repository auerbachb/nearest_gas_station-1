# app/controllers/concerns/response.rb
module Response
  def response_success(result, status = :'OK')
    render :json =>{result: result, status: status}
  end
  def response_error(error, status = :'INVALID_REQUEST', result = :[])
    render :json =>{'error': error, result: result, status: status}
  end
  def json_response(object, status = :ok)
    render json: object, status: status
  end
end