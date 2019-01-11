Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0024BC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D6A2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547243415;
	bh=m5A3LyTYd4rG6iY+EhsL+YZsp9Q2KYk0yKq9xBjBoTk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=xY/9UaEyUB1Gl+HNz3E1ZAQ+mckQ/y8530AUUpWjMgMCBN1iZKP4ZyPqmMRteUnO5
	 EReCquGvpZwDN+N1fLCgaqnq6paJ4wRWEMOxqB/IQJwc9u39g2Pu6zlbHyv1flXa/c
	 6PeIxOWRWfqjNCsxHabXSwqGl/+7L9mh5JxusAgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfAKVuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:50:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:48204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfAKVuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:50:14 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B85622133F;
        Fri, 11 Jan 2019 21:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547243414;
        bh=m5A3LyTYd4rG6iY+EhsL+YZsp9Q2KYk0yKq9xBjBoTk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AmEDBh5zJqnQfFr9vhOm85pF6hutpRCK1Ksl7Lx+qVAnYfpqyKcxhBMwxAOIL7A51
         Gcg+/PNz6U91hP88WuvvOTK8gzUENYt6vinYAG/xQJsuNUAVAtYflTX2SqF9HijpeH
         /n8gZSHW/5BOFtI/ECWVNS3wyhfZZp+J5VB1eUNE=
Subject: Re: [PATCH 3.18 00/47] 3.18.132-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190111130956.170952125@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <176f3cdd-c534-7878-8fb3-69f627059600@kernel.org>
Date:   Fri, 11 Jan 2019 14:50:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111130956.170952125@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/19 7:07 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.132 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jan 13 13:09:31 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.132-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

