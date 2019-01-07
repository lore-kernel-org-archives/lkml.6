Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36094C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0A82087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546872747;
	bh=tFrkD6tK277pyXRGuI/HdmiaFAi64im7VMCDoYA8P9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mp6JEB8pSitAzIwjd5JNBtvExtYpBukG4a9UueBOEDKTl7tGx3iB1Wn6q7Te/Y9WT
	 gPBxuKmeF5wwT5HGB8EeSwuldRI9xXqopG1pKk2B+H47pXIlqvunE5Gd3mbn2mCNhF
	 xJfCvZdKSqfCTnzXqv2Hj9H+t9Wx/sGw0i3j5iZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfAGOwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:52:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:35942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727700AbfAGOwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:52:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 672B2206C0;
        Mon,  7 Jan 2019 14:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546872744;
        bh=tFrkD6tK277pyXRGuI/HdmiaFAi64im7VMCDoYA8P9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tGRscELZzWuD+q8DIwrXZ+1pSh8ZrLRW06k9EI7sqRcw+NVsRLqsVsinDDM0cGpel
         sXldp1luIXLGl+h2x8cvEHb4P+GQZTyPBLz+d5dEqvpBf/gna4KRyOBBkovwublOQo
         o/RgSjeCJKXKGxK+3Bw5DevGKWrSiWIvlxcLRxvM=
Date:   Mon, 7 Jan 2019 15:52:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/71] 4.9.149-stable review
Message-ID: <20190107145222.GC27768@kroah.com>
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

-rc2 is out to fix a build issue:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.149-rc2.gz

