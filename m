Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6700FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277CA2075A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550765618;
	bh=hcQgLtVT0WLXzZgUZ0S1P6PtglEPhS31MxxRzfSCtZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wh9/NX7EZOyCZhTW4oxTnOJEDHn3z5goBV0vaX4rTVFHd6XUbfoGXO2PiGn+SSduL
	 8p34qvnr+txUJbusAgLa/sq026mburJUPKyawIgufW7UlfWZYfSVJ7K2Mytio1nT9Q
	 YGzWLs5JUwBbFXn5yh90twHZqo4vZ2KACAWVtWMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfBUQNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:13:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbfBUQNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:13:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54E4B2075A;
        Thu, 21 Feb 2019 16:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550765615;
        bh=hcQgLtVT0WLXzZgUZ0S1P6PtglEPhS31MxxRzfSCtZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bUGBsHa/LzYoXpDuz5ZRW5GhYbCfcP5Z3zuG4M7AaXbYV8oqzQjmrgHVf36r8cjTD
         liUZHUFhE7+ra92WJrUnmC67vlKFtXszSOMZvu+mk/MQ6yZ6vxx+370FdZ09HS430N
         gAqls4vqU/XyfL64kJPPKGvmbf3n29+HYyICj5KI=
Date:   Thu, 21 Feb 2019 17:13:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v1 0/7] stm class/intel_th: Updates for v5.1
Message-ID: <20190221161318.GC25800@kroah.com>
References: <20190221155006.76832-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221155006.76832-1-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 05:49:59PM +0200, Alexander Shishkin wrote:
> Hi Greg,
> 
> Second attempt. Added stable CC and Fixes tags to fixes.
> 
> Here are the STM and Intel TH changes that I have for v5.1. Nothing big,
> a few fixes that are too late for the v5.0 and a few minor cleanups and
> a documentation update. All sparse/smatch/coccinelle/cppcheck/checkpatch
> clean as usual, courtesy of aiaiai.
> Individual patches follow. Please consider pulling or applying. Thanks!
> 
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
> 
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git tags/intel_th-stm-for-greg-20190221

Much better, thanks, pulled and pushed out.

greg k-h
