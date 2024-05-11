*** Settings ***
Documentation    API tests with RF
Resource    ../../Resources/Utility/SendRequests.resource

*** Test Cases ***
Get single user data - valid id
    SendRequests.Send request to reqres    method_name=get single user    user_id=2
    SendRequests.Check response status code    exp_code=200
    SendRequests.Check model is valid

Get single user data - invalid id
    SendRequests.Send request to reqres    method_name=get single user    user_id=-250
    SendRequests.Check response status code    exp_code=404
    SendRequests.Check model is valid    is_error_model=True

Get single user data - missing id
    SendRequests.Send request to reqres    method_name=get single user    user_id=${None}
    SendRequests.Check response status code    exp_code=404
    SendRequests.Check model is valid    is_error_model=True
