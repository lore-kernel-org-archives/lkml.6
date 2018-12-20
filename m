Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA85DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 23:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7595221906
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 23:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545346934;
	bh=28Cp752cFmULqcE3o2R7Z++Kfd9QbvxqFDLSa7C+FoQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=fB8xHBK7SnsJpfGz/ewA9EYfXRk3po20tXjxXojl8VUKvXX1/B8Za0sP/u3t4eoYA
	 ZTVjb20HL9Zr5btLcDytk63MK1rzE+NWdEgAjeMJfeQbEvudOd5W4kDDNK44Lr1IFz
	 xAViDBSnVZOc5wA0nJ0hTBn6YVWoe9TPXU12IjJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbeLTXCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 18:02:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:45956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbeLTXCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 18:02:13 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0887A218FD;
        Thu, 20 Dec 2018 23:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545346932;
        bh=28Cp752cFmULqcE3o2R7Z++Kfd9QbvxqFDLSa7C+FoQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=p5G8mBv9a2R3Zg4J9p2Hg9gm9CkzFTd6yUfuUC+1V/EqxDHcyid6zJ/hNfWaRhYe4
         tK4BUaDMcsJCVB6HXE6YNfU4ILarhJ6s98ue6Iiz2dks63kwWFVORcjH2g3yGYue7C
         m+wYH78bZLK0REnHbsjkvNJw/BruDIYNVyZlI8UM=
Subject: Re: [PATCH 4.4 00/40] 4.4.169-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20181220085826.212663515@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <c9deac46-091f-94ad-3852-3a9ed0cc5e1d@kernel.org>
Date:   Thu, 20 Dec 2018 16:02:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 2:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.169 release.
> There are 40 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Dec 22 08:58:16 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.169-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

