Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A52C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 22:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA6421906
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 22:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545346521;
	bh=svQ6ARCJ95+Wg1ORwXjwavWn5xo4lfBurI+PL7WpMEU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=KER8hJIv4JDIAcBX0zIMdQ6P2f4Via0dhLgAC2xYLRplGcHDvQ0CJGClnTlBOVh9W
	 EkKSKi3ezadW/PsG7FhKlmKqrPpbBLLZwg4oQCTTEZHVpY16GDTB8RBT66hO6C+5He
	 V9yu9Hgc/p4D7bWCgSIdFUJLup2sTjOy8KlkxYgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390263AbeLTWzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 17:55:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:44252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390244AbeLTWzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 17:55:17 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B4C021905;
        Thu, 20 Dec 2018 22:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545346517;
        bh=svQ6ARCJ95+Wg1ORwXjwavWn5xo4lfBurI+PL7WpMEU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ci9+4OImxsVq6A4PauJ6J1Xqt7rJgQNwUv7x+WjtbiwpZNArh5/dTBEPnH01qJrdZ
         gtPkbqPN64f17TGTRDWtkimc1VYbD7HN+3FE8Fsjbhy5rn37/gfh13vzLtqgpeG6Pa
         flZN45OBX9s9hAG+r+NxEi66eRFoAH6d3NlA5iNw=
Subject: Re: [PATCH 4.9 00/61] 4.9.147-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20181220085843.743900603@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <1d18f603-4932-ca62-60eb-239a58ea1cfe@kernel.org>
Date:   Thu, 20 Dec 2018 15:55:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 2:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.147 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Dec 22 08:58:31 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.147-rc1.gz
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
