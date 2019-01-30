Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45503C169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08EDE2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548814019;
	bh=mj7E0j0yZeceaqTDrCy+oz/1s9KlvUjY7c9Fbc8YrnQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=axNIn55TKDqtQ6jOkJ1ae7JqIddH4ufQtVZpSc/rusHEyyBF7l5otrLc72E7qR03b
	 clwpVFxb2TO39ZDdcTRX2yTksrCvQBFEKWJrBSstN/hzcZ/W5Ry3vKpERU/6MPAUuc
	 Tiv1cw2B/egDuOEeUdo+XU/annLwmq1UjEtfvvJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbfA3CG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 21:06:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:36958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbfA3CG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 21:06:57 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AEAA20880;
        Wed, 30 Jan 2019 02:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548814016;
        bh=mj7E0j0yZeceaqTDrCy+oz/1s9KlvUjY7c9Fbc8YrnQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=M6onj/6N9xJcBskpxxTylaKxYjlbHNSIJOvFMQNl/nnlCh9rFGXZwDBonp904DSlP
         ZcZXH1L5LW+f8mqeoIVhDC/16DeZvJg2NbdWxu/hJFN/EHmpeL260axVLvH2eNb3I7
         vgc2DTaJFf49KRcnvyURbRrlIXfLKTo6Ah/izJiU=
Subject: Re: [PATCH 4.14 00/68] 4.14.97-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190129113131.751891514@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <231eead7-75de-16dc-363b-76a757dad6e0@kernel.org>
Date:   Tue, 29 Jan 2019 19:06:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/19 4:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.97 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jan 31 11:31:10 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.97-rc1.gz
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

