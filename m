Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FB0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF4B2177E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550182917;
	bh=GfegrU74Dnw1sZgjzOms1caXFtYPE7VgxYHorPNl4PE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=QsX2LdBqCD+nw81TRD7BF9+8+StOx5o1ItENTHMan3qFQnWe0CqF1tdGKi0i/vcKD
	 rra+4Yg8MmpXZf7GxwRTIH59UgsYpeUiNHWj/7ZyYpRsDztEOppkmaUsj7iDNKZwgI
	 9CQ86xNw+gpSUBRWyrxRCdYBaf3lR27DScwAYKQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440470AbfBNWVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:21:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:42094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388073AbfBNWVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 17:21:55 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD14A2175B;
        Thu, 14 Feb 2019 22:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550182914;
        bh=GfegrU74Dnw1sZgjzOms1caXFtYPE7VgxYHorPNl4PE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=uvum6L12es68bNDRU23vmsBdfw5U0zk66MaOHZnQvMVbjeuQPSbojX+vIkjm0p3IA
         aL4BMxLPvkLoY0p8sItu5vzL2cjjOBLwF4+CArU3yfPnOslVAICfsCIAvAqV0K8Kvd
         A5BG7DKs3apVmTbuv13UdELyfhZrZY84H2MSbi/c=
Subject: Re: [PATCH 4.14 00/35] 4.14.100-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190213183706.176685027@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <ae5f33fc-2c88-63d6-53ee-4c1433909d04@kernel.org>
Date:   Thu, 14 Feb 2019 15:21:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213183706.176685027@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/19 11:37 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.100 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Feb 15 18:36:47 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.100-rc1.gz
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

