Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB67C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EAF20833
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EAF20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbeIRUg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:36:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbeIRUg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:36:29 -0400
Received: from localhost (unknown [147.67.4.98])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CC435CE9;
        Tue, 18 Sep 2018 15:02:46 +0000 (UTC)
Date:   Tue, 18 Sep 2018 17:02:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     shawnguo@kernel.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: do not double put device node in zx_drm_probe
Message-ID: <20180918150244.GA21766@kroah.com>
References: <1534472646-10368-1-git-send-email-zhongjiang@huawei.com>
 <5BA112BC.8080108@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5BA112BC.8080108@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 10:59:08PM +0800, zhong jiang wrote:
> Hi,  Greg
> 
> Can you pick up the patch? 

Nope:
$ ./scripts/get_maintainer.pl --file drivers/gpu/drm/zte/zx_drm_drv.c
Shawn Guo <shawnguo@kernel.org> (maintainer:DRM DRIVERS FOR ZTE ZX)
David Airlie <airlied@linux.ie> (maintainer:DRM DRIVERS)
dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR ZTE ZX)
linux-kernel@vger.kernel.org (open list)

why would I take thi when all of those others are the correct
maintainers?

Also, you only posted this 1 day ago.  Please relax and give people time
and a chance to review your patch.  It is not instant.

thanks,

greg k-h
