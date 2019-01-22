Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE42C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A47D217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548196761;
	bh=1WiD4IFJ1a+3R3AUItLXO59iDRadZTOIg+7Ngydo2qo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=OMtBFQ4KAU4GjTCusmv1aalXXLaRYLS6dO0ikEeyKhIrwumlb8Akbv9yTsq3Ox/FC
	 7X6wv9QArGE14rT3cRiGcNObOCLmKiQLukj+0sxWcGLIqYV361yMhnaq6SJoZZG6eS
	 s2AFoK2RLH4JakNHP8zJp4e7ftkY+xZ0TeJn/m8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfAVWjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:39:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:43992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfAVWjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:39:19 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CCDE20866;
        Tue, 22 Jan 2019 22:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548196758;
        bh=1WiD4IFJ1a+3R3AUItLXO59iDRadZTOIg+7Ngydo2qo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KmdnRVY62GIedGLgeCn7U52jQUlZrfsqfXdttoAyejiKOmCB42j8Nhp5TfajhE5vo
         gEmx65HuWzPYbuy4fKqtEuARjgdl2m3bwkRrzoQVr4a4vG8/Bf4l9jlcKSHG5kUc2e
         U4RGbWD8V3DqzMTZ9Dt9G8sR4OWLpGbdXTQxfsmo=
Subject: Re: [PATCH 4.9 00/51] 4.9.152-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190121122453.700446926@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <596e4e88-8889-0e8f-1469-feaf5099e526@kernel.org>
Date:   Tue, 22 Jan 2019 15:39:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190121122453.700446926@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/19 6:43 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.152 release.
> There are 51 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jan 23 12:24:02 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.152-rc1.gz
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

