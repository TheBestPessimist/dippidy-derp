. "./Run As Admin.ps1"

# get-service *asus*      | stop-service    -ErrorAction SilentlyContinue
get-service *armoury*   | stop-service      -ErrorAction SilentlyContinue
get-service *rog*       | stop-service      -ErrorAction SilentlyContinue
# get-service *aura*      | stop-service    -ErrorAction SilentlyContinue


# get-service *asus*      | start-service   -ErrorAction SilentlyContinue
get-service *armoury*   | start-service     -ErrorAction SilentlyContinue
get-service *rog*       | start-service     -ErrorAction SilentlyContinue
# get-service *aura*      | start-service   -ErrorAction SilentlyContinue
