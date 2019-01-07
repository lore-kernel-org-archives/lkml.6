Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81EBC43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3782173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546876413;
	bh=kYw6byPDpny+hxiVprsaX055uPGvf/HAwLVfVgLbGlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N26LO9QloTb0XJjXcNh9xapLzofn0XRXjYzrwkNwCrUWhpjk0M/aH4mTRC5iAUZsF
	 lBZdkKGk0uMWkQP/32vPg7MGFPpQXNfwmwC5KTTyLfHaUb4kQM6lvaXKc6aUnjtgB5
	 ey4WCxiJ2k7PP5/G8j8SKsFPLlxmAQbq855QPYto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbfAGPxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:53:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:59828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfAGPxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:53:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 562C82089F;
        Mon,  7 Jan 2019 15:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546876411;
        bh=kYw6byPDpny+hxiVprsaX055uPGvf/HAwLVfVgLbGlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Glk5X+nTik/+8E8MV57LQ4m+anMt+bCubv/iwlbE1sHluSZzKDx6xnowcriOY+Hus
         R878ydPVwfL89l+ma5ffyo1X1wnB3MGAzmjIpvPMTL9OtznrqCDV8cxPVd32+vIeDn
         XLIyxnVI6BX4LOYc4H7coWzM54jc2tRtePAwncaA=
Date:   Mon, 7 Jan 2019 16:53:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/71] 4.9.149-stable review
Message-ID: <20190107155328.GA26514@kroah.com>
References: <20190107105330.280153213@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 01:32:29PM +0100, Greg Kroah-Hartman wrote:
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

Ok, hopefully this is better, at least it builds on x86-64 properly
now, -rc3:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.149-rc3.gz

