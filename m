Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43A9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 23:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23AD21906
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 23:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545348555;
	bh=lmCiWYvSQYJiPHF+esPuidaHr2d9cRuE1sd9uALofb8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=RoO9WN3NZ77UXFe9oioY2RbK9dt9z3bdlrx9JSKbUpBhbW7BTR4EQwdZbh4sLsNJs
	 5bpoxDPzlIiXKHJFAPkwlKWvvd2mqoXQ2gKr2j+fZ/fAVtUJpP8HusWnA3/SDO+eHE
	 b+rA5lThrPHOCoQuXuO1RDz5i1OoUknGdFTxuK60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390339AbeLTX3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 18:29:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:58480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731142AbeLTX3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 18:29:11 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7008921905;
        Thu, 20 Dec 2018 23:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545348550;
        bh=lmCiWYvSQYJiPHF+esPuidaHr2d9cRuE1sd9uALofb8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VyFz9RFmCprws/08K2u190CziyA58hOZSCGpHKtqafSC6/7Aak7SrJumStKSFeVdy
         yrkTcJQ/lSgkSzoz2au3fL4TQOkDOHAS0rCTlOUaZhP/6JzZkT73vBlpHHMClW33vl
         opkst5tx94p+5ROQAHvuyz1iDZag4rJHtj3R7JDk=
Subject: Re: [PATCH 3.18 00/31] 3.18.131-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20181220085742.601260254@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <7f92c9e6-2c0e-47d2-393e-eb75b7839f88@kernel.org>
Date:   Thu, 20 Dec 2018 16:29:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220085742.601260254@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 2:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.131 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Dec 22 08:57:30 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.131-rc1.gz
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

