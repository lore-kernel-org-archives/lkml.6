Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64809C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B52B2184E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549986060;
	bh=zUoSpaHEmBA8qkvZ72Ob4vmX6XK3eozl8A1xhKlbKDg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=A+L5cqhDTptqrreutBtGClISSwQgALpLrlU807iEhHgtMLh+IoQJt5ZxIesDgzDYr
	 zhJ0HTAqgbH/761dP2SkRzLlxerE8uTwPrkOuhmUu21fNbKiHinYMIxfKouCXhHP71
	 u8onpkvy/pCVPx1DKgsHFxfGNKpbeI/dV9XrpR6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfBLPk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:40:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:46014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729313AbfBLPk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:40:58 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43E65217FA;
        Tue, 12 Feb 2019 15:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549986057;
        bh=zUoSpaHEmBA8qkvZ72Ob4vmX6XK3eozl8A1xhKlbKDg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JosvbjqDsX3uIHpDHNVhn75unNmBkZzAP3NLmKEsyZazT9dBwLKKiFBW67XxAN9a+
         qyG3bajzHXLsOWwSaJqb+1FGAVX0aZFDXVyrF3TH+p2xS7d8+fdlvuADEDqpIVUTrn
         F7zUvPHlIVOAhQDxh0Vi5g08z82rruIimjoeryLg=
Subject: Re: [PATCH 4.19 000/313] 4.19.21-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190211141852.749630980@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <cf84005a-1937-36e3-55e2-7decfd809f02@kernel.org>
Date:   Tue, 12 Feb 2019 08:40:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 7:14 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.21 release.
> There are 313 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 13 14:17:25 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.21-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
