Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591B8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CF721850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551196281;
	bh=q6GxnPunnE5cyF6M3qsBPDEQ5ZdEAVNltjz6B8R3kT4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=rLMWkv1aoSk6YGq0fJDeaOp/OEWr2QrodLJEwtOv11PCTdKj2Usr9ThLG+TOZywVQ
	 /aObCO8iNnYUH9lc4PfOx5ThD0Z8ksEJJmFpyY8cK3F7qN5AdaS/HLbBqyxYKsqpNP
	 Dw/SiWnZA1u9IvEejRls1pLsYNQ/wD4Zb8i0+poo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfBZPvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:51:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:41616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbfBZPvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:51:18 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5CD320851;
        Tue, 26 Feb 2019 15:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551196278;
        bh=q6GxnPunnE5cyF6M3qsBPDEQ5ZdEAVNltjz6B8R3kT4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VqOz6JqLl62Qna/9vVnCLkayJPv1r/Qk9z42WifAzl2qfcJdKCmUfWgvuTKqK9h/2
         WeVOChbjzm4Cbm/ekEOfRWo6UcoSg2NL5OnrhyyfgnLQlpHnl0uz8rawLuHzNfjL9n
         7in2vagOQoWKchHSzfRgm/pmLRTwULJOWaLrN62I=
Subject: Re: [PATCH 4.20 000/183] 4.20.13-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190225195054.748060397@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <552a28aa-1cee-fa0e-c6a0-ea24fd2c1626@kernel.org>
Date:   Tue, 26 Feb 2019 08:51:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/19 2:09 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.13 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 27 19:49:59 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.13-rc1.gz
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
