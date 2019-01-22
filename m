Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA41C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07F5217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548196316;
	bh=hnsOd0jiK3bdrl/YxWCHkszMA+csKQ/YGOT2DgfVr2Q=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=gcdETSqavPTASCKY0nUdwwS7l7LvtSlP8FYKbPqjt9KfZZNwwxHGCG2UIQ9Em95io
	 TRIqj1jTBxnEx9/pzM8W1flfRr2Y8RwpiFtjnemRV0B36tyB4ht1HwNWIuD38mf5D4
	 jojHs+uZUlVLUy6ns4+qTOQu0V0IjyGE37CdxUvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfAVWby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:31:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbfAVWby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:31:54 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CB6F20866;
        Tue, 22 Jan 2019 22:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548196313;
        bh=hnsOd0jiK3bdrl/YxWCHkszMA+csKQ/YGOT2DgfVr2Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CwuBPhn+/jhP70ibwtCxdk6DU6r4ewvVYZPg5Jzloul8QRsDlSb9nIndMjJbYVR7n
         +xhH+vKYCv8fhLPNDMxiHPv+EV1mWkpOJg+fbb05L/IOefbdZ4sH3FWLiKapxYb3Sv
         Uz8hXuH33X4l0vZuzPFDmachqInp9vBUUMy3ex9g=
Subject: Re: [PATCH 4.14 00/59] 4.14.95-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190121122456.529172919@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <2a32edb8-94c6-0d31-cde6-5e864ea09845@kernel.org>
Date:   Tue, 22 Jan 2019 15:31:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190121122456.529172919@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/19 6:43 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.95 release.
> There are 59 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jan 23 12:23:55 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.95-rc1.gz
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

