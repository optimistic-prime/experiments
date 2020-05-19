######################################################################
# Variables that needs filled in
######################################################################
vault_name=""
URL="https://"
FA_URL="https://"

######################################################################
# The Vault! Comment this out if you re-run this script
######################################################################
op create vault ${vault_name}

######################################################################
# This part is jupyter; just fill in password
######################################################################
(
    PASSWORD=`echo '{
       "notesPlain": "jupyter",
       "password": "",
       "passwordHistory": [],
       "sections": []
    }' | op encode`

    op create item password $PASSWORD --title jupyter --vault ${vault_name}
)

######################################################################
# Create users; email and password have a "/" between them
######################################################################
LIST=(
  # password_username
)



######################################################################
# How the sausage is made
######################################################################
for i in ${LIST[@]}
do IFS="_"
  set -- $i
  (
    # this is to create a user, just fill in the username and password. 
    USERNM="$2"
    PASSWD="$1"
  
    USER_UUID=$(op list users | jq -r '.[] | select(.email | contains("'$USERNM'")) | .uuid')
    LOGIN=`echo '{
      "notesPlain": "webapp: '$URL' \nconsole: '$URL'/console/ \nfusionauth: '$FA_URL'",
      "sections": [],
      "passwordHistory": [],
      "fields": [
        {
          "value": "'$USERNM'",
          "name": "username",
          "type": "T",
          "designation": "username"
        },
        {
          "value": "'$PASSWD'",
          "name": "password",
          "type": "P",
          "designation": "password"
        }
      ]
    }' | op encode`
    
  	op create item login $LOGIN --title $USERNM --vault ${vault_name}
    op add user $USER_UUID ${vault_name}
  )
done
