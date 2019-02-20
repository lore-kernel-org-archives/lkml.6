Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18262C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56FE20675
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550621936;
	bh=PJMJ/7K0m2r9NTY4Q7xevhjiva+9yzGKfCdLyC32tV8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=0OgCZX7DvFzdoWldQSLhNVojxnZCkaazA+kinJrFsdWK46KYbzmip4Ih0BZJ5Shqq
	 31e/wdwL7kqVM7sHg31kq5kAXbHvgta3G0GGfai0AsfsRV7BLi5ieRpeFsGQG5TIrB
	 t0/zpsYP04tlsZ4wA7kj64FnaBtgtbWywXPgXk50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbfBTASz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 19:18:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:52368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729011AbfBTASz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 19:18:55 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30A1B2147A;
        Wed, 20 Feb 2019 00:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550621934;
        bh=PJMJ/7K0m2r9NTY4Q7xevhjiva+9yzGKfCdLyC32tV8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=vTAuPvwlBTARetjuZRLPubWpmmY1fCTXTW9mzTcVsGMD2L9RsnkxLbRabDqHBN6mI
         oXq/DocU9c6+SogrKNZvtC0DgIKnXs/NmjVaBBDtlvsmxaSd33zf9uyp+dQTZ6aQZ4
         2KTrlIaXaDqg6AW/1ScU4OBcP4t4dA5WEYJ1Cnt4=
Subject: Re: [PATCH 4.14 00/62] 4.14.102-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190218133505.801423074@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <6c733888-1962-cc66-89b4-8b934b40f78d@kernel.org>
Date:   Tue, 19 Feb 2019 17:18:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218133505.801423074@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/19 6:43 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.102 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 20 13:34:36 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.102-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No demesg regressions.

thanks,
-- Shuah
