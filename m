Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A97EC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F6A20850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546950001;
	bh=b5UXo5c6GXcfPvMvC8Ei7p6N7jTlG56FepLuiwAda+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cDi7D+mAK4oLVPAMRG2JpwA2hYLE4GncCjVUuqgNkZ34U6V13/jsUZiBGDgJ9dmzN
	 F3Rcc1VHrZdHsMo3/frj3gMnNb4lgLgA9D7ymglmUUoORrYxl7/8Iz+brcTQzS1nZm
	 sbz7aHhU7l8cpT4o7f+LP6G3zkK1hzV8U09ips14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbfAHMUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:20:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:36378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728794AbfAHMUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:20:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E37E8206B7;
        Tue,  8 Jan 2019 12:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546949999;
        bh=b5UXo5c6GXcfPvMvC8Ei7p6N7jTlG56FepLuiwAda+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fr4fJLe1wihnGxy0poT4qCB+eHaEvd8iOJlGt0UGWI9tnqrN0Wlal0nSGcfKETR5J
         Lrv+P+YRN12v+ecKO9wdZMD17OUbNPKroADPpk1cf6vMyP1Pm0RUTsWOX5QS8DWWSm
         iY1kgQjWu6AFKN2Dz+SqW/YuSSUwWriO4ztcsbMc=
Date:   Tue, 8 Jan 2019 13:19:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/170] 4.19.14-stable review
Message-ID: <20190108121957.GE3884@kroah.com>
References: <20190107104452.953560660@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 01:30:27PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.14 release.
> There are 170 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jan  9 10:43:54 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.14-rc1.gz

-rc2 is out to fix some build issues:
 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.14-rc2.gz
