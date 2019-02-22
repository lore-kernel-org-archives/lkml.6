Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2F1C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CAB20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550876376;
	bh=BAXrCvJGBBqhgSwsIJ51hE3TRyjkHbY3wT0ZfdHP2xM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=fFXIjw2k4zbY0ptJlgddpndM3sciP22yP18mJ+WqfHGg+K9I5PGIVLIbjrcrgpTNO
	 /vwNfi5MMY0Iv7A/WB8XxrjftuI9bf/K4ceq/MlSt2yswlfbe2wWSorGEYwNU8MgzP
	 8NRwL/oJ3/lBeA/mO9DaHdRb5RQo7/erVDVO0Uuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfBVW7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:59:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:48536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfBVW7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:59:34 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 683E3206C0;
        Fri, 22 Feb 2019 22:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550876373;
        bh=BAXrCvJGBBqhgSwsIJ51hE3TRyjkHbY3wT0ZfdHP2xM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=N70rC8ocpgZA198FKXZiZTIL83qi1s6UbLc7vT1VNUycu8K5OhEeEGZycQSdu5pBs
         6A9oaTaSQu5KZ9iD+ToGghUMeklgqgyPwy8r08NScyet0igEoGBzY/E2TijOi4gEkq
         cBzdlspr8BPtcqOOTLnQngll9YYvk8Gh/VU2gBGc=
Subject: Re: [PATCH 4.4 00/20] 4.4.176-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190221141946.772985220@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <cb5c4771-e813-b40a-3109-6b59ede80431@kernel.org>
Date:   Fri, 22 Feb 2019 15:59:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221141946.772985220@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/19 7:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.176 release.
> There are 20 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Feb 23 14:19:37 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.176-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

