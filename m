Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B83C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FEE3217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548196053;
	bh=Ufy6xfrnjJ4ttq5CRmCokF+bSCUOy490Tzjr8KDKNrk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=G7qVFaUQcpoCGCVQjU1jgwNxm4LFtQgGI4oxGngfYMBfx+PpGNKq70SEZqcxvMXNM
	 Vk2bwo2gNGd7R1U1Lvz1+PZsd/SJkaiMksJztPL9SqicUde0Fn1jOahP6ghkkXQugK
	 j5e8vqnl79pFSlpnvcP46oXCKhWPWc1UizEJTSzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfAVW1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:27:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfAVW1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:27:31 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F133620866;
        Tue, 22 Jan 2019 22:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548196050;
        bh=Ufy6xfrnjJ4ttq5CRmCokF+bSCUOy490Tzjr8KDKNrk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=t00LTSwN7cDGjwej+tJxYRCSqXzgmf7SHaiGXlJ4wrtRnTaLB5CX3w2Izv8KxRu1+
         C5ZMiJPcTS+G84LbVDbmFThSsvXyxnJtyXOiGaFJ7y5Tkt5eERVJmqWxOIqMB1yhcw
         sCFtshFhNdFHXuyTWzaT29PcHo+dmNIfCeuQzdbM=
Subject: Re: [PATCH 4.19 00/99] 4.19.17-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190121134913.924726465@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <5c04c64b-deda-0e0e-1ceb-cc515412cf97@kernel.org>
Date:   Tue, 22 Jan 2019 15:27:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/19 6:47 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.17 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jan 23 13:48:56 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.17-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

