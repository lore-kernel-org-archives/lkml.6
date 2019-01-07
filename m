Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165F2C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0B92183F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546900433;
	bh=DNUP8qZfGhIaKVyUFI1dy4F+Si/8+THqktO7pD7Ykzo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=pI6UBGQN5C3M9F9Oa6xd4eIMg6t11kWpVqcOO13PvEo+7g3PTxotSd1I/RQiiuZgg
	 zM2JO7LoMi+fKz/E9PnzN45470dHPhH3ThVJrGX25k3J2duwZh9fYbXZ/+zqhQ9cqL
	 tSjRGHsF9n2ils7Kz3RHfepGGt3dVQV+QW2lL6OI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfAGWdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:33:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:57470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfAGWdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:33:52 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B33682147C;
        Mon,  7 Jan 2019 22:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546900432;
        bh=DNUP8qZfGhIaKVyUFI1dy4F+Si/8+THqktO7pD7Ykzo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nGhpr0yiVWAM5ds5619BuW5QkP6FKVK6jSrnEhE2vADVInWfoD+AxwkTJMbzd2QJE
         wvWtLEr+lCAIAJESH/7Og82e/65GTvBPHQw0OxcDawBQxE4yA/5rEcQiJVqGCgjlNa
         qwE/uXipZ2tfjC3sk3P91Y6cvniAohXJ/KkNbpoA=
Subject: Re: [PATCH 4.9 00/71] 4.9.149-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190107105330.280153213@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <3742c6dc-0b58-0f94-d631-35db5699aa4c@kernel.org>
Date:   Mon, 7 Jan 2019 15:33:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/19 5:32 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.149 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jan  9 10:53:04 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.149-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

