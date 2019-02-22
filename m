Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CDDC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A1720663
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550876154;
	bh=HgEBAjT75MOanI1IGD8DpcNxu0H1ID5Ct8fypZ8SmM0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=AgiER8pISoEjb4omZwPfYST396JGYWsm9LrbQj8MNQCFWDRaUJBSbdG5RzasFWhAc
	 ZmPnYBoAzGLThJXTXHlqAPMbp6Mb14rks7dlKV4uHfjMz4oZUIsARsYbS52+x2cZB7
	 0d7jEiS7ZWOP8hGHivleijHKTUyZ11W/ys7MgV2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfBVWzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:55:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:46610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfBVWzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:55:52 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 715CA20651;
        Fri, 22 Feb 2019 22:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550876152;
        bh=HgEBAjT75MOanI1IGD8DpcNxu0H1ID5Ct8fypZ8SmM0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=juRV6k3ORM9/eJi5Nwi1dQW8848lPcq80TAvHDAPJ8flfp5YI8pf9KinCe4sq60Md
         A4oBwytZK95NP+hgzX78MwoenVMM0q0xVfiol+cifpXMwnhdJGdRhyGBmqLDKDtQHn
         CwJt46O2zqo2Up8yKOsEP1uWTGoM2XH3kXUQv9Lw=
Subject: Re: [PATCH 3.18 00/13] 3.18.136-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190221125240.091472334@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <74ae01d1-e2b8-f682-d531-eb74988c5b1f@kernel.org>
Date:   Fri, 22 Feb 2019 15:55:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221125240.091472334@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/19 7:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.136 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Feb 23 12:52:12 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.136-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

