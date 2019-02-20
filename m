Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D14C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240EE21773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550621778;
	bh=QQXaHrtgNbjs8E9fU7YMSCbaQs4Mg6pX1koivs0pE3Y=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=C/waW/OU9P6G/L9T6CYFpHUSjUkXAvB20CIJef06KPGnP3vRLkIxgwZE6VmB2XoMl
	 SNdIYqaOOa2LcnCM+qj6ud8gl7OcJ1tLP3nmhk5UonMpJ8Ie0gHO0owSL+VTIQA+Mb
	 5UCaL289M5gC36SXBGQADVGhM281KFc8qMuSa+Vg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbfBTAQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 19:16:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:50910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727476AbfBTAQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 19:16:16 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E4D22147A;
        Wed, 20 Feb 2019 00:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550621776;
        bh=QQXaHrtgNbjs8E9fU7YMSCbaQs4Mg6pX1koivs0pE3Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Lv3kcuAFhi7+Fj4DhUb0Y1NMj7IkD1ik0KqfxLF21nGFGWxpyXGTEVlW5cFgbMOjZ
         HAkQxTyYDrLQbB9jS00MCkr/kRrg26jReWMKIhuUL6aiASIc9/sbsjcyDFynZRsbKW
         ZJaj01Qo2pzICYe6mcR6HJnEvmERJcr64OhjApuU=
Subject: Re: [PATCH 4.20 00/92] 4.20.11-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190218133454.668268457@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <4525c1af-2b78-c4ef-a89b-b658642ccb94@kernel.org>
Date:   Tue, 19 Feb 2019 17:16:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/19 6:42 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.11 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 20 13:34:25 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.11-rc1.gz
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

