D = {}

(function ()
    print "---------------- "
    print "I am a function in Module D"
end)()

function D.funA()
    print "I am funA in Module D"
end

return D