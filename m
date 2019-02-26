Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F0AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FA821848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551193629;
	bh=1ZumlEC+APuxfvTvOCG5H8teFL4NPMOh9LJ8S0qz+Ws=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=FMaMMq+IVIJwvn1gXpyO7bkyVIxWBZCu7ah0GiaNzqVhskEaaoFkpnUmCMAE8Tawu
	 +OKmaez5MMcw0Ha3Zu0WCkJFosFkdiHKG7vAs1mmLZDZoiZsFmiMR2jRee6DneKk2D
	 MLErFS5ibrTXz/cUf2gedkYvmulljeVySr5KqxmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfBZPHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:07:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfBZPHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:07:07 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B49FD217F9;
        Tue, 26 Feb 2019 15:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551193627;
        bh=1ZumlEC+APuxfvTvOCG5H8teFL4NPMOh9LJ8S0qz+Ws=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AeYt9q8RpbuUsEXVI1NaN63Mh+tUUWtOaQ+Ryx+NcoKpzy4cK9avCRE37VZ+1aaOX
         B4B17d9FRams4jdBELaWe1D+/7QBQRFwkygVnm+rUPj73bs/15TAlTAxnOyxp0dvHO
         vfWE+zOXvlytSA+94sglE4BBh0ifIgG7oGQoeo4M=
Subject: Re: [PATCH 4.9 00/63] 4.9.161-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190225195035.713274200@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <9dcbd669-1a9f-f1d0-d6a5-0f404f74652f@kernel.org>
Date:   Tue, 26 Feb 2019 08:06:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/19 2:11 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.161 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 27 19:50:06 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.161-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

