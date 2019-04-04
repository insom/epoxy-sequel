if string.find(query["digest_text"], "foobar") then
 return {hostgroup=1}
end
if string.find(marginalia["controller"], "foobar") then
 return {hostgroup=1}
end
