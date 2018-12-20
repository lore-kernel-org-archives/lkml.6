Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E863C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 22:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B21221903
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 22:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545346110;
	bh=HNfWgS4PgZunGXnxIXSUcHbX2XD9mh+0zFlm9/ZkpiI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=n8nGwd+8fvfvR0lR9Ujhbju86xNkpaihD9PR4/3Y6poBQD2YnN2100PN9SuHNwkro
	 aXuHgWloXCXM1K0pBRPADWFxHnDt3TKqx6fhGlyB8oz15LfAsW4LKDBDROFDkSwUID
	 PH+CQekZqBBxCcZmq5HH2SNsAKw0p1Hf9Da2UaRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390212AbeLTWs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 17:48:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:42854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730294AbeLTWs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 17:48:29 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EDF62186A;
        Thu, 20 Dec 2018 22:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545346108;
        bh=HNfWgS4PgZunGXnxIXSUcHbX2XD9mh+0zFlm9/ZkpiI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=wNzLq7RdVMjkcUW9W4AZUeh1jK6vZrpX2bIbCHf92n0Tzs2pAL6Aqc7Y1A0/A7pqD
         vCuuxxMSvK8xmLA5QhCSC9dau7Iptus6al49AvLtvA0TLXaXPWl2/G2upiGIbkdG2u
         W+h+8IJ0c1wJ+qVJAWsZzTS05i20FDazFA5zFHk8=
Subject: Re: [PATCH 4.19 00/67] 4.19.12-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20181220085903.562090333@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <b6ef5d5b-a8b1-fd82-cb8a-63604f7e8952@kernel.org>
Date:   Thu, 20 Dec 2018 15:48:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 2:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.12 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Dec 22 08:58:49 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.12-rc1.gz
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
