Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2034C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 01:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7F12086D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 01:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547601919;
	bh=fMDru6jR7lcETWNo/xQCAzQiecq9fEFNraYCWhBRYa0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=olEAxmZ2RYFonfFvnusuoTxS+2tGcwGN3D91qIAaAyc+jQZuvU4u+jGTtYcnEisYy
	 6CQQ96wvNK/EPOuGI5yszJ2orlm6PCbP6bFMLKYwzuUWCMVSoJ9xZzKo8hGq53abkV
	 NVHyRaNSqOySalM10XCiGkaGylPcht/33C3iHVMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfAPBY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 20:24:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbfAPBYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 20:24:55 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A068C2086D;
        Wed, 16 Jan 2019 01:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547601895;
        bh=fMDru6jR7lcETWNo/xQCAzQiecq9fEFNraYCWhBRYa0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mqxevyRbeKsIvqMJhAPo3K7GZosOeXA1yPmth0qfJsvoWatd6hZrkuzBtk6XF9tk7
         2sp9hZBs7/aDkz+F0mgQ+/6FRF8mPlDiCgKEBunkYlkM6gloOmzvZVMY+dbbFP0eSN
         OzwJeCLoNbNYwQwsufI9DiLXWZ6m7i9kzMt+apq4=
Subject: Re: [PATCH 4.4 00/51] 4.4.171-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190115154846.928796000@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <302ba6a3-b07e-5a3e-75de-97aed818c83a@kernel.org>
Date:   Tue, 15 Jan 2019 18:24:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115154846.928796000@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/19 9:34 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.171 release.
> There are 51 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jan 17 15:48:21 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.171-rc1.gz
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

