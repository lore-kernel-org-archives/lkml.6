Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB350ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 07:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92435214C3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 07:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAYBEZ47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92435214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeJTPtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 11:49:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbeJTPtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 11:49:16 -0400
Received: from localhost (10.193.71.37.rev.sfr.net [37.71.193.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0A37214C3;
        Sat, 20 Oct 2018 07:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540021187;
        bh=SgOZud4F8S8pPKy3/kCKuWoNFv3dAxwxDjUPvFMfIok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XAYBEZ47so8DW55Tc+wz8wLuWZmie2G9MW7FsnPEl078x24OLa9awp+I2h4MRE5rx
         AzBL1nVxgYIrgwk1KaU0f1RFxWw3pYN5OzMoxbTS7hpdk0uE8A7Rw+p6yIJQSWm2zq
         RuPWZRokm+xMDHtyagoQCmFLt/FuTEujdpudNLsk=
Date:   Sat, 20 Oct 2018 09:39:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dave Airlie <airlied@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] drm fixes for 4.19 final (part 2)
Message-ID: <20181020073944.GB9710@kroah.com>
References: <CAPM=9tzvmdwN2DWFMnH_OQfaz_M8YtGUO6K+Z0QRzuX1z6FoqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tzvmdwN2DWFMnH_OQfaz_M8YtGUO6K+Z0QRzuX1z6FoqQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 12:33:20PM +1000, Dave Airlie wrote:
> Hi Greg,
> 
> Looked like two stragglers snuck in, one very urgent the pageflipping
> was missing a reference that could result in a GPF on non-i915
> drivers, the other is an overflow in the sun4i dotclock calcs
> resulting in a mode not getting set.
> 
> Thanks,
> Dave.
> 
> drm-fixes-2018-10-20-1:
> GPF fix in atomic flipping, sun4i overflow fix.
> The following changes since commit f8e6e1b6f0ae3bb91cdcd08213d36a0ce6e98535:
> 
>   Merge tag 'drm-misc-fixes-2018-10-18' of
> git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2018-10-19
> 13:52:03 +1000)
> 
> are available in the Git repository at:
> 
>   git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-10-20-1

Now pulled, thanks.

greg k-h
