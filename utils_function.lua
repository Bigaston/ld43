function in_array(pVal, pArray)
	exit = false
	for i=0, table.getn(pArray) do
		if pArray[i] == pVal then
			exit = true
		end
	end

	return exit
end

function toggle(pV)
	if pV == true then pV = false
	else pV = true end
	return pV
end