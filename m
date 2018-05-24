Return-Path: <shuah@kernel.org>
X-Google-Smtp-Source: AB8JxZo2AUIlFW777Z9shxbPLTFXbJPHFEQzRx+OXFV6Ty8JCAR0HF9C3d9gGb1/hUE66r/d1iBB
ARC-Seal: i=1; a=rsa-sha256; t=1527189690; cv=none;
        d=google.com; s=arc-20160816;
        b=bjEXeHkcFKVl1kR6K7hUtxGqMAHQOWxrisa0flqmMlPvnlrQpZGrJLCnINFM9FR2Rm
         vegHhVtEcSJ/MvXwVsiTyLkIe8AENU0mMvUBnFoewmYMbE11BkVgTfI36TqhcP7ftF3e
         3hd2q3bWeMKQkBIe7jFu+1H8AOPGVa+jCovU9lTg6e0q9zHL04mrPtELy9d4Area8kYt
         5NGovrNAxQTaPQYj6vaxKw0M5WTWZWqjAUDfr2V5f+3AhUz2QA7MHCdp+YV/dMvyWwz2
         TnoCeoe48BxUOE55qlKhJf3/ZoGFTV/jPg06S4q6/xo6LGpNLYXf03+6qK6G9Dgb9euC
         sinQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=n9p8dpq3ut85o60O64vKmdQftNG28ZY3TU+ym17wQYc=;
        b=z/4kVERo/iVMKfup6SiOZ1XLaSo+Ds5hwPZsPPgQhUDtnU3+EtY5aXq4TInOWG3EQc
         zZiBMsAv47pgzTPrteLXxNEkXyYg858GbLUAtcJ3fLlqNwqs9k1FPHfQUriokcc4EAIY
         4lpz/fglFaUk01CUXle6WyyKhR3qs0tmIiWe8HbeCMW+YL3WBAjoWz50mKw1MEfEcXLf
         XjNq7GAZWKH9G7oRDyL/W72YdnJUDn2/nX6GqkrJGrBbKL+p3LjvAK+AAGzKMjYI1AFv
         DKT3JsgyCB3GR5KlAYQ6EzAZMsrfQ4ugjioJxhyr7PEXnVESZnX1KYDQWUgpjcJK3qh7
         FoAw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Subject: Re: [PATCH 4.16 000/161] 4.16.12-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
References: <20180524093018.331893860@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <35e20edb-5817-80b9-7eb0-70779ed9b8e0@kernel.org>
Date: Thu, 24 May 2018 13:21:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601339136054826375?=
X-GMAIL-MSGID: =?utf-8?q?1601374457239327826?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/24/2018 03:37 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.12 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat May 26 09:29:22 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
