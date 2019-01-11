Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE7FC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712C821783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547242959;
	bh=Mqjc2Jh+2mMmoggrReOyJtXxgPkL79lgxCSVyrlGs7s=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=K4z/yHb+xdzzSodk8npQAZFgj/wNaV8H+VOsQzSG9CRWVeQhwXTtOP7DxT+Vt16n4
	 Ql8sMGCIbZXM+NO3/EWo1a+nyAV1tP707y+mD5r1eBtvhpfSL/8zYFarzfRSPY0QeQ
	 SmUBbgeIrHcmxN6Vsaxl0RZWztgRWVNQAiEOD7IY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfAKVmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:42:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbfAKVmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:42:38 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29A5F2133F;
        Fri, 11 Jan 2019 21:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547242957;
        bh=Mqjc2Jh+2mMmoggrReOyJtXxgPkL79lgxCSVyrlGs7s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kFxVZjHnbe2Xd/K2IerYiE3c6B1A25qfCEHEgBgQqNTAPMknfroPxkqMq3NhJLcMr
         QlESxzVA6ghUDMSPBNZ1qiFgsIvP/k9wB7wARh819F+DYF05rOg/8dnlpiZZj39fIp
         tlcUmPky1TEDCFBhbVgqZelYGzSiiWD+7T2cTsoA=
Subject: Re: [PATCH 4.9 00/63] 4.9.150-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190111131046.387528003@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <5b34a4f5-cd04-bfc0-a794-06f3ae0dc7b8@kernel.org>
Date:   Fri, 11 Jan 2019 14:42:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111131046.387528003@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/19 7:14 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.150 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jan 13 13:10:03 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.150-rc1.gz
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
