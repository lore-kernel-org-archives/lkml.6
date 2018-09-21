Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E8FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6834F21531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6834F21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389424AbeIUN12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:27:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47652 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389258AbeIUN11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:27:27 -0400
Received: from localhost (unknown [37.170.50.219])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 49804D27;
        Fri, 21 Sep 2018 07:39:49 +0000 (UTC)
Date:   Fri, 21 Sep 2018 09:39:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] drm fixes for 4.19-rc5
Message-ID: <20180921073921.GA18500@kroah.com>
References: <CAPM=9tz2sHYqjTMUnzr_SQ1J9qrWAGDs56y_2CrFhCCJOeYgjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tz2sHYqjTMUnzr_SQ1J9qrWAGDs56y_2CrFhCCJOeYgjA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 10:06:58AM +1000, Dave Airlie wrote:
> Hey Greg,
> 
> Looks like a pretty run of the mill set of fixes for this stage,
> 
> core: fix debugfs for atomic, fix the check for atomic for
> non-modesetting drivers
> amdgpu: adds a new PCI id, some kfd fixes and a sdma fix
> i915: a bunch of GVT fixes.
> vc4: scaling fix
> vmwgfx: modesetting fixes and a old buffer eviction fix
> udl: framebuffer destruction fix
> sun4i: disable on R40 fix until next kernel
> pl111: NULL termination on table fix

Now pulled, thanks.

greg k-h
