name "german_hosts"
description "This Role contains hosts, which should print out messages in german"
run_list "recipe[my_cookbook]"
default_attributes "my_cookbook" => {
"hi" => "Hola",
"world" => "Earth"
}
