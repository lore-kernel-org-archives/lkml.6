Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05F2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 01:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F63720883
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 01:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547602656;
	bh=L8HBctTuDqiuvf4RhGnmePgHmEqiXUWQYPTvRS96+I4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=tKI3MtfCbpbD19pgeqAlvhNYXu7mlJRBc2fCItF9rBcEwWFZ5Co/KJUgjiXJ08atL
	 mbf5Gyv9NSIXtJ+naft84YKeMlV+xkNWi8romIotqR7x0V83kVTZlgKz9Xr++M6esU
	 wGwqm7/MuziOUwE5ZeZhxJZ88shL/jEXhuPb2ihk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfAPBhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 20:37:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:47872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbfAPBhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 20:37:34 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0693B2086D;
        Wed, 16 Jan 2019 01:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547602653;
        bh=L8HBctTuDqiuvf4RhGnmePgHmEqiXUWQYPTvRS96+I4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mTIKrQ2mDaj8+OPS7tyZylkC8Akew6O/A3ENs1/7x46JyHFg4Kr4eoGYT1TsbkR2J
         RqVP8d3uOEIBXsi1eTIa0zd0RRuf4kLcr39pM4HzUrcvxTvzWLW08OwnXDK5LAhz18
         U1uvvzNq5duLw4HsaUWEVdwvmzK4EFJtf78nTtoU=
Subject: Re: [PATCH 4.14 00/27] 4.14.94-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190115154901.189747728@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <5154fe2d-0078-393d-77d0-272dbb848738@kernel.org>
Date:   Tue, 15 Jan 2019 18:37:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115154901.189747728@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/19 9:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.94 release.
> There are 27 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jan 17 15:48:28 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.94-rc1.gz
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
