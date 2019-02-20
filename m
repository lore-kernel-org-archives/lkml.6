Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E019EC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82F321773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550621887;
	bh=GuRN/3NdhuwNR8VuJo/s+RNZjOSiafoXEY/6aCK9tZo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=t6uzGJuGG4pza0x7kb9aeoFO+fBJSRht9otGwENkhWwgQscLK621xAlvS+MGGXG/7
	 U2HSsYU0ITZ1hLjD9S2xfHIb+L7awNU371rHVyYjNMnS8LpmIiO7b7AUfLSiyHtwQ5
	 38qOLXr6K7G52cY/GchHgyuwcUQzs0OaeZj2VvDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbfBTASG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 19:18:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729314AbfBTASG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 19:18:06 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16C2E2147A;
        Wed, 20 Feb 2019 00:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550621885;
        bh=GuRN/3NdhuwNR8VuJo/s+RNZjOSiafoXEY/6aCK9tZo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h7HsGPBiVMRC/hlbv31fj7lqBWevqyiE7iN5Ntpv/7TNF4JEuHDMaXdb3S18PZ1Np
         F4D9Ek3FE6h2AtScqj9O3CgttbLIT8V6kqGd0meV1TRXWhtxQqGYCnNcFkxa6So09Q
         nlKAM7lEq8zkCYOTbGimpLlxUN4d7JeRPBX3YjFM=
Subject: Re: [PATCH 3.18 000/108] 3.18.135-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190218133519.525507231@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <58e49f39-1868-4728-d4f9-b51362f6720f@kernel.org>
Date:   Tue, 19 Feb 2019 17:18:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/19 6:42 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.135 release.
> There are 108 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 20 13:34:47 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.135-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No demesg regressions.

thanks,
-- Shuah

