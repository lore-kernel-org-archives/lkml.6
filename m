Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B5DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F45720879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544818368;
	bh=vgzdFgnnBX54AI9GIodebgfTYy6mgm3NpUJXLqEL6KU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Dk9V0T8dMmTo86vUJ//hFD1qSVwK8cRhqVl4OLwnnlkWX4++Yy93uo98Fuuh0VrNB
	 YwLgCKqfRLnIcC/9LL4Z4A/BA6rPYsJwtIK/Bs1UV7fpWFL6iV/PvrMtvTu2qMHQpP
	 jwezncljPeB2GK5V+DCti6/jRUNFRJCAoz5Gw50c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbeLNUMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:12:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:34374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730493AbeLNUMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:12:46 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B9F22086D;
        Fri, 14 Dec 2018 20:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544818366;
        bh=vgzdFgnnBX54AI9GIodebgfTYy6mgm3NpUJXLqEL6KU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pm2diWe8nmVP+BMVpj92CHcvsj63fAy9rXTGxUuQrfXw+3pQwat/bYUH4eJLXVZm6
         k9oJ0amVEtWUppU3N4nkHg8Qfi888VoiPxMb78LCon22N7BleAin/+R+NHk46N3An1
         0eG7Q0m9pWxVLHwU/uy6+6lH4IDTVU94EDNTXQc0=
Subject: Re: [PATCH 4.4 00/88] 4.4.168-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20181214115702.151309521@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <2dfb612b-9448-b478-d764-34574271be21@kernel.org>
Date:   Fri, 14 Dec 2018 13:12:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/18 4:59 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.168 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Dec 16 11:56:41 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.168-rc1.gz
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


