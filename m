Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA3AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091B72086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544818296;
	bh=QS6AoN0EJ2D5MvpP0tFpjqfh/MOTpr7ZwpCVar+F7wE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=CQUD3upINSUvrewhLviqlvDJz6ABAqCRa4+BdOUUuMR2RftN6B8tKXB8GSrIKQn5E
	 W3LhqXOS5MRFIvDcCmVLIDY47TJ1d09BqLh3/TuZViHEv071bW5t4MMXDih1YtGzRL
	 U6RmAQqxno55rIsZvsRVarkxAOhsXVZPzAC1YKMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbeLNULe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:11:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:33452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729808AbeLNULe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:11:34 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BBA4206DD;
        Fri, 14 Dec 2018 20:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544818294;
        bh=QS6AoN0EJ2D5MvpP0tFpjqfh/MOTpr7ZwpCVar+F7wE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JNnsIZJ9jMkwQ1YBvZWc3FM3fq84UQDvOH0O+Ywo6tGcOAlFB9D6Ex7EeqGdsdnHx
         SIq1NzaBmQL35YRzT/nEzkPoIb7O/wRqUNdQA59NvV6eLxQpZoZDE2TH5HR4gEQnFp
         ahQ0f+wlqI35Ed8gC7JTcYBT896hUgKVWyfWQU14=
Subject: Re: [PATCH 4.19 000/142] 4.19.10-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20181214115747.053633987@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <61cb35c5-d260-6bcc-2f00-99a4ff4e57b9@kernel.org>
Date:   Fri, 14 Dec 2018 13:11:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/18 4:58 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.10 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Dec 16 11:57:12 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.10-rc1.gz
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

