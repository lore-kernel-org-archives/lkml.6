Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9158C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA622184E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549986100;
	bh=9QRmojM4DOBHMqQJ+TMOIF4zku7hd/hsG9gd/TlbIBA=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ETSImjEOYjF5+RFnbiLU6+xycPqBbnf2HlufTscpsYQpmRrRUtu8Ivz3Okj7gQ9/6
	 KioQzv6hbQxjxJat50R2IjtgcSz3vXiFled2p6U9ipJs1xvu+AKbhBlQ0Si5Zd6Izs
	 19ITusPg7r4jTXmobYEW1sv6DSgjcXlygXmSFgRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbfBLPlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:41:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729313AbfBLPli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:41:38 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B39E217FA;
        Tue, 12 Feb 2019 15:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549986098;
        bh=9QRmojM4DOBHMqQJ+TMOIF4zku7hd/hsG9gd/TlbIBA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=wMJozKpKyP4B/VgRNOhKDiP61mJmsu9isyYhCg9lvpOB29iMegUW/ue90JxZ/B/Ub
         RzaNGl8WoUBATGWzaBBc4I2NuNhA1yg+L2faA5i3kvq6WhdV+9e1P2EFf+bVWb329C
         kcR2RHPO7LagCjq5eI22kNn0kSL/XKMPVkg1Xlis=
Subject: Re: [PATCH 4.14 000/205] 4.14.99-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190211141827.214852402@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <633e1837-e70a-0cd9-a456-391b3531209d@kernel.org>
Date:   Tue, 12 Feb 2019 08:41:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 7:16 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.99 release.
> There are 205 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 13 14:17:19 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.99-rc1.gz
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

