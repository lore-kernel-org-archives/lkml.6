Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A2BC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90685217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550621810;
	bh=1fZQ2aIL77se46xz84OVbnTJ7cD8NRuwZOcjFvJjgxU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=bb792bb6oLuxPNy8MSTL4nRAfEEOBlPLPeBmzY4Sw+ookUGMuG2Qn/W5PR0MeSuuS
	 2Q0HOsYB6vxzl3LgSeYmGE1cEM8ZbqsN3k6/GAaNFZsePxEXejNjdVJm06Ph+zOMGa
	 jaCKfiE4ykClVV6GcoHt6nKcnpiunZD8pTYRzkyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbfBTAQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 19:16:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:51098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728001AbfBTAQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 19:16:49 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D3072147A;
        Wed, 20 Feb 2019 00:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550621808;
        bh=1fZQ2aIL77se46xz84OVbnTJ7cD8NRuwZOcjFvJjgxU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FIOZ3zk0QJ7jWmoEbAPjnlINlBtfWZvG9tsxXLbZVixv76ES/M/WPupn2ztbTFbIp
         L2gVcei3+jdIvn3/1wEq8mDiiV3h70Empo1eFnMQ4/UMDbMR44PWJB0YRUIR+/Bvr/
         G473cIIzQ5lL8TyFDOVRSg/iC/L5bKip1+kyKJeI=
Subject: Re: [PATCH 4.4 000/143] 4.4.175-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190218133529.099444112@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <44ffdb09-5786-4d26-d996-f5e05719a02d@kernel.org>
Date:   Tue, 19 Feb 2019 17:16:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/19 6:42 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.175 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 20 13:34:55 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.175-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test syste. No dmesg regressions.

thanks,
-- Shuah
