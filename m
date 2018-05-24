Return-Path: <shuah@kernel.org>
X-Google-Smtp-Source: ADUXVKK+rK6acclPIz6ZxQN5g6NRMIcX8qKKdnys+KUfQv3l4gCLHtTvJh66MqJexs5WpbhWr3qs
ARC-Seal: i=1; a=rsa-sha256; t=1527190015; cv=none;
        d=google.com; s=arc-20160816;
        b=c7AmoNA+BTKQ8glL08ag+Msz3SHMzvgjpUU4uyLPu5m6L8+5Xqm/VYOVSiU49Tz0Kc
         wUOVCObP52zWbJKifA+VJ0qtBdnGtYvzlBsoFstBd5sCWW+B+PCJSfSJDwf4NvxJQE02
         3FDWikM9Jil5SE0mL5ykSbXXjxaZ/a87BdXvFDyFwizaHs74XHU8RP9SGuwV7ucJgmxd
         oZDXJnbHr1OAdvXdjbZL13HZOjBCBHzSj1GNK+IpomHSGfpAjfDZLOvSkQwTJ+GICsEW
         9nTJugKd/zbdeBoOeIvaZJcCPbhxdpgKTxzXBTH5b8khNH/i7bOiIuyIKAwVy4lvpdLq
         ANsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=bozRO5R6BLhBoHbCisMFFIHfEhh4XWBzDU/UV7dkTXk=;
        b=xVhCOE+Cno0gxn4LtmE4wZIPP3ltDiAY2gJi1IKIELWCxszGMG6gKyLyIoiq9XBBOM
         0/RIzCyGql1B1XStkBbl1IPAYFYoW6OPHLr2lcOBfGGbN5+ZWatDcj1rMWrH8wMk7E3w
         qwNsPlejOf66v24EH7j6rHA+pxugtXKLW4YxJYCwdD0dSCclwxkH62NH55O2zUMswWkR
         kGScPVf6XqgQfRwroG6P/sa07DEjD9V7kO5BtVVrbYRGfL+kozhY9FK5hXupLwPT3E+Q
         i2NivqRvj+3U5r/Sy5xoIUN+g18gnsnJ+u29f0iAn6kGK+Cfdddjbjh3Lfo6K6KlxDB8
         9y+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Subject: Re: [PATCH 4.9 00/96] 4.9.103-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
References: <20180524093605.602125311@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <e884983d-84af-efdb-eb9c-d72d4d4467ee@kernel.org>
Date: Thu, 24 May 2018 13:26:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601338380744330487?=
X-GMAIL-MSGID: =?utf-8?q?1601374797243358981?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/24/2018 03:37 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.103 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat May 26 09:35:42 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.103-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
