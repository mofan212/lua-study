C = {}

(function ()
    print "---------------- "
    print "I am a function in Module C"
end)()

function C.funA()
    print "I am funC in Module C"
end

return C