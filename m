Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89E0C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8462184C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547242866;
	bh=+exKhajbowJA9/M0O5EHIbnt70njHAwAiO971o8+sp8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Zzo3Pq3uJ4Vt2JGsVBg4vVDHenZQ421cXZG2s/JIjeo67oPGAZZpY5IGhCTalUIUM
	 nuxq53QDpdnnkMvHbORXQH+X664I4s6eU37Pj8OdeVGd1pP/DD7KBK+1vZzgFrFP/h
	 lWu71bfNICteFzm0DZHysW0nu7Mgr9f75TYviYAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfAKVlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:41:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbfAKVlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:41:05 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 786B72084C;
        Fri, 11 Jan 2019 21:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547242865;
        bh=+exKhajbowJA9/M0O5EHIbnt70njHAwAiO971o8+sp8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Gvp0iqvplbuzHFxLUbmvLVK48gFOTL509TQE9sTShfZ/c2RJ90K+d53dS6e09F4xo
         wqkF1NNWr64WUeHHd8m+NVxtya3jxpJIhsNjMHzxXmey1ALXs2tKZq2kqRGemHT4QA
         DnRDJgm+dYQglUdAd0ztafyoIuZu3kXQppCxSzJw=
Subject: Re: [PATCH 4.14 000/105] 4.14.93-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190111131102.899065735@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <d933a264-fa73-7f36-540b-9322abd4c019@kernel.org>
Date:   Fri, 11 Jan 2019 14:41:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/19 7:13 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.93 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jan 13 13:10:07 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.93-rc1.gz
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

