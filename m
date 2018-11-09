Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74715C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A16320855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZccH0ZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A16320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbeKJFag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 00:30:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbeKJFag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 00:30:36 -0500
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A46F820825;
        Fri,  9 Nov 2018 19:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541792913;
        bh=6RKO8Zbw2NqlxxNMEUxqGhZKJ07mY7x1GjcXJBYx16A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BZccH0ZR8mD5vDBvxupc1k97sZnFQGI8ucgH3Y42AOfU8lUnFKM5VEtTbAszJHUa6
         ezm8M+sdWtCXQGJdwH01rhXTDkL9yagynI/ON2mTySSpZtKTXIKIlwBTu1KSK2ObO8
         Azt7dBkgbLvQecP7or4DIZZjM4stQG4Iss88GAWA=
Subject: Re: [PATCH 4.9 000/171] 4.9.136-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20181108215127.257643509@linuxfoundation.org>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <e740c5c4-30bf-8f9c-8116-9eb7a06cc2a8@kernel.org>
Date:   Fri, 9 Nov 2018 12:48:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2018 02:49 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.136 release.
> There are 171 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Nov 10 21:50:40 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.136-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my new test system. I don't have a reference for
dmesg regressions and I haven't noticed any problems.

thanks,
-- Shuah
