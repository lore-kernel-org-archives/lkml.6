Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392E8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83C5217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549986140;
	bh=1mmzLCuFnFqr/JevspHsTHwzgUocYNsA1ofWnUxVXzU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=vxQ2FiMNe1uVTUm61qmlXbWbxP+ijWpstZJ5Ln/3+xfQP3MPR17aklvtPGHPMa2EB
	 SaRUj6UVFjvFlT0CXN317xZtZKPLF4WrKIUFwRemFi0/oV+LuMtxPnl6r0MLT5SUB/
	 +YeRcUYZdhLGx9xNw0IuqnnRdD3Q/JKTjA/j6/oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbfBLPmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:42:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:46952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfBLPmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:42:18 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 423EF21773;
        Tue, 12 Feb 2019 15:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549986137;
        bh=1mmzLCuFnFqr/JevspHsTHwzgUocYNsA1ofWnUxVXzU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=0TlQji/YkDVsQo3Wu5iurtLHcI1gB+sqaJuyZp82xOVN4XxVrmA4X5aP05ZX2d7Vz
         zuiTMtEqQK5ukojcw9xK59VlywueWUTG9DNvWEIvvpX7jv9lCIYi5uVHUezEGD4d5O
         2Gjeu2LHwCulWeaLfWAn4WBtrHTJaeLtJq7bWvAI=
Subject: Re: [PATCH 4.9 000/137] 4.9.156-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190211141811.964925535@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <e8a55492-43a9-83b6-f1bd-bf18a28d409b@kernel.org>
Date:   Tue, 12 Feb 2019 08:42:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 7:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.156 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 13 14:17:22 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.156-rc1.gz
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

