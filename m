Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25291C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBAC2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550877343;
	bh=8M739NqvfrdNmX9OytCAAmuhOmhMRae1639jxa2sh8g=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=HXPMGBw2lvwzFsHW1zBwcPzKK0dAlKO2eu6tskPPZva9tjWQbXvfdpvjFOtIOvOjf
	 /u0MMJTAPMw7vjpx1L7se3fY4HLyvlXpeH9X+2U1FtIjRPTM4ZV0KkY8Tlt6qSOjzJ
	 zDJg5AiW4Xa28YUvSYlgbbR0r7YEhzKtZ18RMRhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfBVXPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:15:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:57980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfBVXPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:15:41 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 112622070D;
        Fri, 22 Feb 2019 23:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550877340;
        bh=8M739NqvfrdNmX9OytCAAmuhOmhMRae1639jxa2sh8g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HNdN1GMVS/GaJltWqNTxPPu9Pr39grGUfAQspIAVbZXRyC56SIj/FYjZPJf1a4GHi
         GI+scS9OAFT6zhxvmMGL+q0Lo2Wu9x6bnsuxam/osu+AZ8kPFkxhiNPOZHnuQlHA8h
         nTdsLet+eVsGagQ5hzdIk7e9iPsLzsjMNnPpA9NY=
Subject: Re: [PATCH 4.20 00/32] 4.20.12-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190221125250.855065214@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <48518256-b431-bea5-d654-dd41a2ad9936@kernel.org>
Date:   Fri, 22 Feb 2019 16:15:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221125250.855065214@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/19 7:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.12 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Feb 23 12:52:26 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.12-rc1.gz
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

