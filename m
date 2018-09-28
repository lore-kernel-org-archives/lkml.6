Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73771C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4828320868
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4828320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbeI1X5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:57:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43674 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbeI1X5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:57:38 -0400
Received: from localhost (unknown [88.128.83.59])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EDC7DE7D;
        Fri, 28 Sep 2018 17:32:38 +0000 (UTC)
Date:   Fri, 28 Sep 2018 19:30:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull[ drm fixes for 4.19-rc6
Message-ID: <20180928173011.GA20063@kroah.com>
References: <CAPM=9tzPZcrUoxq==jObY6tGOgsPP9kbAqcmOoUkts-EjHb5Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tzPZcrUoxq==jObY6tGOgsPP9kbAqcmOoUkts-EjHb5Ww@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 09:59:11AM +1000, Dave Airlie wrote:
> Hi Greg,
> 
> Looks like a pretty normal week for graphics,
> 
> core: syncobj fix, panel link regression revert
> amd: suspend/resume fixes, EDID emulation fix
> mali-dp: NV12 writeback and vblank reset fixes
> etnaviv: DMA setup fix
> 
> Regards,
> Dave.
> 
> drm-fixes-2018-09-28:
> amd, etnaviv, mali_dp, syncobj and panel fixes
> The following changes since commit 6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84:
> 
>   Linux 4.19-rc5 (2018-09-23 19:15:18 +0200)
> 
> are available in the Git repository at:
> 
>   git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-09-28

Now pulled, thanks.

greg k-h
