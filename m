Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E804C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B8C20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550876854;
	bh=7dhy8ElhO7ah2nW+UN38XZR9xKN4giwIyHMNyQXwzyM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=EKK91Ed0/3BXrr1El6D7bZgM+zumP1xGuGvIiddYF2K5C3I/tEg2EjtOkmFawa1A4
	 1IjZ9jHN4lOFLVEcQcV5w+Fa6yT4epN7mCeG5YDbr29V/Oc//zGtUWZB1F9xG4VidN
	 +WDFMuMsgffqRwR5lWFvgX56iggRUblh/vJoaAJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfBVXHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:07:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfBVXHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:07:32 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BAD5206C0;
        Fri, 22 Feb 2019 23:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550876851;
        bh=7dhy8ElhO7ah2nW+UN38XZR9xKN4giwIyHMNyQXwzyM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PBnH5dfqv8OL8xUMo0dD3SVsBvkqF/XhYJRxx2mhejbNZfLbv/IFIwGTqFZvczbL8
         68iXDIMPwedP+Y52tzo87JBsxBbf5oCmkkBrR9if4NrsVPCaZEWXNGHZ2oPzk4t5hq
         pD0vn831LxgZvphm1lt8ObaHOBDhuU/7Dnnq/Skc=
Subject: Re: [PATCH 4.14 00/23] 4.14.103-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190221125246.162644302@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <7efba1f0-e2a3-94f2-3293-ef909ff13383@kernel.org>
Date:   Fri, 22 Feb 2019 16:07:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221125246.162644302@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/19 7:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.103 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Feb 23 12:52:22 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.103-rc1.gz
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

