Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED0EC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B64218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548427915;
	bh=jeVLDdCe8wFYmSmCD6htYJqE+XYWPdH1zXbVXIRRq+M=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=LLtySYBYigswLQzPmgjcX+btTWrfKeNat5fyo+SvcrqCon9qoD9S2cyB8zVBBZvLn
	 k7t1U7mKqHOaEpR6mcnZmohczgihY5DZV3CzbS8psRQHmSU4fcWMDa7wgAof/ZZMtr
	 H2xqAMngsHv5/S9qg5Xw24CH82mgb2/FR6Nz87wI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfAYOvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:51:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:38108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfAYOvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:51:53 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7003C218CD;
        Fri, 25 Jan 2019 14:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548427912;
        bh=jeVLDdCe8wFYmSmCD6htYJqE+XYWPdH1zXbVXIRRq+M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FNepw6GJWzNatMNhTJNqtN5aQzm/IJ4tEwXDHGM1YQRLCXudMXJm7TNYFihx3XQ1h
         Gdr/nbEL+5HAcTVvIPB9faadI0/FAieHd1t7MfYkNsmWAaaqFNr28K3WGhb0adTWZn
         4LPcmlk73XuSz7koASZGKbcYqpcnGqynse2FpSQk=
Subject: Re: [PATCH 4.19 000/106] 4.19.18-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190124190206.342411005@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <4b06fa44-be84-e14c-ec09-2d570cfe2469@kernel.org>
Date:   Fri, 25 Jan 2019 07:51:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/19 12:19 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.18 release.
> There are 106 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Jan 26 19:01:18 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.18-rc1.gz
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


