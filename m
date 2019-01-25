Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461B2C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15815218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548428119;
	bh=Mat0+2zAUf5mESSbNpPa007V6v7XqcQhGsedzkc1gz0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=UwxmhWax1r83KDA2kx89sAtMoszzaBM0My0SWd8YhU2zgliSYde2j8fhZ6/X4ZfVP
	 Rc1+4Ypcbn+8/vOfjCnIFlGaI24ejje1gOcE60lp1Mj1wzXCeJ6KUQfwa/NPl7Hzeg
	 SHP1B/lyNwqLzIW+icwwHk4glPRoKw/yOKjaja5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfAYOzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:55:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfAYOzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:55:17 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3B6C218CD;
        Fri, 25 Jan 2019 14:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548428116;
        bh=Mat0+2zAUf5mESSbNpPa007V6v7XqcQhGsedzkc1gz0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=m8kfAtiwSWjF8A2IWw01yshptfhE4o2uDXlY8VIauwswvTKTGJ5VbOKoynvwaQDct
         ZMoe4Sbz3NhY/qzt+5eViJbA2CayY7rcB2r+U3ZeJTD1gKdbuVN0kAChO80iWhaILF
         UqznC8LSwD68xPJCB8V02yhMGUUDMHjDetwPYECI=
Subject: Re: [PATCH 4.20 000/127] 4.20.5-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190124190211.984305387@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <e87a0ccb-9588-d260-8bd8-4163ab1af6ab@kernel.org>
Date:   Fri, 25 Jan 2019 07:55:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/19 12:19 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.5 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Jan 26 19:01:19 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

