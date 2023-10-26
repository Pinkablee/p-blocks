CreateThread(function()
    local url = 'https://raw.githubusercontent.com/Pinkablee/versions/main/gang-blocks.txt'
    local version = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)

    PerformHttpRequest(url, function(errorCode, resultData, resultHeaders)
        if resultData and errorCode == 200 then
            local latestVersion = resultData:match('%d%.%d+%.%d+')
            if version ~= latestVersion then
                print(('^3[ALERT]^0: A new version is available. Current Version: ^1%s^0, Latest Version: ^2%s^0'):format(version, latestVersion))
            end
        end
    end, 'GET')
end)