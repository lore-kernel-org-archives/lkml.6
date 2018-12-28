Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5851FC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 20:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B28A21479
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 20:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546027861;
	bh=Yy6OlgTtUKm52Wbv6lLHCRZ4ymBJLn1BvHta4/NupIc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=WS/PwOZrG3QMhEfN3mXES+1ug6itTRpyjQ7bAeo2+eiGEZTKvlK0WZVASeEUCEQsa
	 jO5lRsmxrDxU8TYZddsw/Sr0r8S5RruEJHa76tTsvF8jxxYZ2GeZ2gVA5Pubbh8TvP
	 CYhETvqcER3Fd0YOmJWMAl5hcjUxgcZnVBhIFvb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388010AbeL1ULA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 15:11:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:50314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730735AbeL1ULA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 15:11:00 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 830C320866;
        Fri, 28 Dec 2018 20:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546027859;
        bh=Yy6OlgTtUKm52Wbv6lLHCRZ4ymBJLn1BvHta4/NupIc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XCTl3X5yjKN3UtoByFFsFIX+/bcXQIRp14noBSKVo7SZfBu1ffauoKdZnI03U619r
         KW64reR0zabeDL/EJVAu43t5dJwTnfuP8D/wlKPv5MtzVnI7alOW/uWhLvo7hcOq1I
         R5SUYkErQ83eVExqecyb7bgm6OG7Jl9v6fFH7Iho=
Subject: Re: [PATCH 4.9 00/22] 4.9.148-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah@kernel.org
References: <20181228113126.144310132@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <f9ca67fb-868e-5af1-dba1-97e07132549b@kernel.org>
Date:   Fri, 28 Dec 2018 13:10:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181228113126.144310132@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/18 4:52 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.148 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Dec 30 11:31:00 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.148-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test systems. No dmesg regressions.

thanks,
-- Shuah

