Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6547BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 20:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2972E21479
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 20:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546027808;
	bh=RkEBo/N5/yVTMp+M90UULlnNQVC0Q1HYTiavLFGueSs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=T84p8xTMEswC+Mc0OxfrlPKCJQotEV1jndNabx0TBVRcgXm7O1C9DVdhXafwtKSKf
	 lApfbl4z4JJ4Q47nPmONSuQ71ntuss+zuSd43Kb5EuV68QWniGyV9qA0HtcxaoXb91
	 U+nPRGfilDsiKfYWQRV6RhKiZU9GfWPBKBsVrQY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387993AbeL1UKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 15:10:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:49930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730735AbeL1UKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 15:10:07 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CE5020866;
        Fri, 28 Dec 2018 20:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546027806;
        bh=RkEBo/N5/yVTMp+M90UULlnNQVC0Q1HYTiavLFGueSs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XzE6yMHHPIxEgo01Bj+qd6CqsklMfjQ/L3643m2oS8QEE5Mao3iHFUtP8mrC9mYjr
         KPKjXX/noyOMYxqmCp8o9OkJ1eDx2yB4a+sO7QZ8cztojZTb3Uq3FgqsziD3ndnjJo
         MYEjpEM/NTJKPU5ZGByksv47LfzBSQqYp6zd4S1Y=
Subject: Re: [PATCH 4.14 00/36] 4.14.91-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah@kernel.org
References: <20181228113126.526729877@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <55452678-f55a-31ef-30fc-bfda6bb5e399@kernel.org>
Date:   Fri, 28 Dec 2018 13:10:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181228113126.526729877@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/18 4:52 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.91 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Dec 30 11:30:54 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.91-rc1.gz
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
