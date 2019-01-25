Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E3FC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9586E218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548427574;
	bh=dZjHVpyQPaUI/rGc7IXoR0Oz6CsxrxEj/2cvMTeFnKo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=uVT+nvHZ/KSViv4t6qVesxON4pQSdZy2pKz3TnA/X1TW1uRCNGSuJpJgNNj6U32ez
	 MlKGaDdBP3RYQpi3mzBLiwRbEAdew2t+QO9VdcJCmfkuurbT91IQ0B3UlUEboimGWu
	 mPcSSiiqnwQL4/4SKj+gxM/foqj4QAqSLAiisOoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfAYOqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:46:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:36434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfAYOqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:46:12 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76BE1218CD;
        Fri, 25 Jan 2019 14:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548427572;
        bh=dZjHVpyQPaUI/rGc7IXoR0Oz6CsxrxEj/2cvMTeFnKo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jZEJAgz0/6MluLC4XoAh6ZNTATxhQWDaYm+X3nRWUnSrt+CPkSYAfAkTSDcXXcqta
         xJhJxjWD7ugH0mQSr0MLBmQrSL/sGt321hO6B5We+Ax42lJsjF0hTBcgE223wnECvP
         4D296Ff9VoxP1WvK2fWzM/EkbAaRhVMb64QBYoBk=
Subject: Re: [PATCH 4.14 00/63] 4.14.96-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190124190155.176570028@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <0b1e82d6-8535-d3f4-92ef-590c26ff66b8@kernel.org>
Date:   Fri, 25 Jan 2019 07:46:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190124190155.176570028@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/19 12:19 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.96 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Jan 26 19:01:15 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.96-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
