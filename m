Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54668C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215612183F
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548195963;
	bh=In8XDJK1mA5wWsd6/74uelxSQiG6hQahmLqutJORV7w=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ImfAhg5kyOD9wFfBk+Ylz7fs2a8fC/rIVc+EZQn+V7UdVeLSBA1UERluTER1zERrt
	 LfLJzI9mlCgygnZZAlvhlkUFzKLrCxvie6a8uVJRe/FcnAXxU1zt/sSbaZj18XT2wS
	 lcJ+jW4e0vEJFgSroEMxmUrREjqBbZgD31XdC06g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfAVW0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:26:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfAVW0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:26:00 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A75C821726;
        Tue, 22 Jan 2019 22:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548195960;
        bh=In8XDJK1mA5wWsd6/74uelxSQiG6hQahmLqutJORV7w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ro5a/bvsTOJsNcSi0icxP0ruHXOq+n4sLUDgNJig7ubtRIzXhb59SyWSPworaz2mo
         3NNRn+OTqoNJtgb1Lrpa+OmcZ5hQlgwx+X9dguM4yDD1jzdlUrvDdkMkDQIBo3QKob
         EIFUlGTemMU6lcEBQOzwwHOO6Ow1uROM2cqZISRA=
Subject: Re: [PATCH 4.20 000/111] 4.20.4-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190121122455.819406896@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <c35b105e-3473-ef59-c8d5-2dd39708474b@kernel.org>
Date:   Tue, 22 Jan 2019 15:25:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/19 6:41 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.4 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jan 23 12:23:56 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.4-rc1.gz
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

