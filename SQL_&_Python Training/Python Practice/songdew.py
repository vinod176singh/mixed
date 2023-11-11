import requests
import json
url='https://graph.facebook.com/v15.0/101282666181996/messages'
auth_token='EAAIZCXqzNBMkBAMtQkMYgyJqqbjn8A7KqpLpHT3NshhvtY6v1th9eihmSAZBjvQAZCSEpKth52bM9wiX75SlXp6Qv3ZCcBxcM7mqdbNk8BlJx3v4jh1kRDO7FrtZAxxbZAnHgEZA55MwTwypwrPf46NVqr0gUIaYQrxlNV2YGKZBlirXnXh3SB0Fsq6Kv0dnmp53oVDF8eDKA8agukXVGnJq'
header={
    'Authorization': 'Bearer '+auth_token,
    'Content-Type': 'application/json'
}
data={
  "messaging_product": "whatsapp",
  "recipient_type": "individual",
  "to": "919004006165",
  "type": "text",
  "text": { 
    "preview_url": "true",
    "body": "need to add specific response"
  }}
msg=json.dumps(data)
response=requests.request("POST",url=url,headers=header,data=msg).text
print(response)