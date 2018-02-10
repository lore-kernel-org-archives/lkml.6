Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518278839; cv=none;
        d=google.com; s=arc-20160816;
        b=yWEuEqxKngRy+kq53mW0wD3eo62X51f9fvZ2td3LsrlUVtkPcZXIz+gpUpndT9Iakz
         dnNbzN0FFPb0wwSE4z/xP7YwGtaYn4gS1YI2CpxIpA5wKyLW3tLtTJC3p/0EqUPJF97P
         fS2X0EF87W05XhKh4hbnMPmO9fUJhlzG+7Wmwg3X88QjY940iC2OG2WXXdGUohG5NJ8d
         vg/E3n4dBknGDStWar7AA5kOp5b8nBhzZIYl/95aa580POJGAAzO8nuge6pNDnFU9CJU
         sD69g0DoEPPa2r4Gn0wyazX1mTQXx8jWcDed+pBDph2y0BaoQOOFt5M6ZU9xOqjosZLw
         FNnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:sender
         :dkim-signature:arc-authentication-results;
        bh=u68tV+P/0sAYyuLqhScjBJycNg8/gJakmBlPFnjpF6M=;
        b=eTMhEOnCpI3xJa6ltHZk/S4FUEP7HcMP5o+LQ+juohQIDBl80GTG9H/lUbI8AOlYtc
         f+V8CooVvvp9AyxH6z7EpS6xTMEt0IzL0zURS66rFCzoVBG6hsavjuxouA2y4yM9tQQP
         wDXyBbh6cH5GZBfiSALpG16nlBHuoKTAc6ZWehvhiC6OTffUDYTO1PgSrMJEng/c5y1o
         5OTvDXCX69KiA7Fv5EEJLFuL8PSKIv6uxf8Db0mlgv/n06S307iaTcIZiu3isYtbyN9U
         smHiloipX7OHRXp58vKeMEMxJntMPY13F1NSwpMaH8nA0jqTKWxmfTadE4N6HbAfBYG2
         8GxA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=USeWjMPh;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=USeWjMPh;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AH8x227tlr97h+b/okfFgVnCjEG/pxusYK+QErSmJUZ40qJ/Cwwxfts5mem84DClFsrEmjgmyjUvHw==
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 4.15 00/23] 4.15.3-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 shuahkh@osg.samsung.com, patches@kernelci.org,
 ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
 stable@vger.kernel.org
References: <20180209133938.366024920@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <cf6b8968-61ad-3670-6f5a-b00da980b811@roeck-us.net>
Date: Sat, 10 Feb 2018 08:07:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180209133938.366024920@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591931344572458017?=
X-GMAIL-MSGID: =?utf-8?q?1592030752098451596?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/09/2018 05:39 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.3 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb 11 13:39:20 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 147 pass: 146 fail: 1
Failed builds:
	mips:allmodconfig
Qemu test results:
	total: 126 pass: 126 fail: 0

The fix for the mips build problem is now upstream with commit 24f8d233074b
("watchdog: indydog: Add dependency on SGI_HAS_INDYDOG") and is confirmed
to fix the problem.

Details are available at http://kerneltests.org/builders.

Guenter
