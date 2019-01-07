Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FBDC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8864F2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546900611;
	bh=vnMWn4WGf3oQqb5NssxiHVcBGOCfDmxJ7t6DpwjX8ek=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=P2QXZ4tRYacbeSZu6w6J0/z8J512IWPBfvZnlKuXDxzff8RMv0kByGJUZu1uZU9IB
	 uJ12/XAtZTmWhAysbXNkLFMSjxusNhHNRp53IIEAhzvVWos3F4F7cM3d/OOrjFpVaw
	 TziYSpD9YOY2slvuV2JrCjkXKWH5JegEdOjGh8jU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfAGWgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:36:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:58674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfAGWgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:36:49 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABDDB2147C;
        Mon,  7 Jan 2019 22:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546900609;
        bh=vnMWn4WGf3oQqb5NssxiHVcBGOCfDmxJ7t6DpwjX8ek=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cEHXKzgtiaWY3tYqORaxbBpjT6qvJdHF5/Mlh+IV2R/JBvfICIt5RKJYswqf5s3VQ
         PfLl1EZ/QPfpQWP0y9NLv3PvDnlx/D8mfz4fzinmmD2M/o7fsZKt37885U7CIgmHXd
         HXccfLD69r60G9lIt9UEbTnCcQRLgJCnU1LGhmQI=
Subject: Re: [PATCH 4.20 000/145] 4.20.1-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190107104437.308206189@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <27bbc7b0-2fb8-8f40-53a5-2a2d82f37f8e@kernel.org>
Date:   Mon, 7 Jan 2019 15:36:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/19 5:30 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.1 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jan  9 10:43:39 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.1-rc1.gz
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

