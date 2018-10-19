Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2876ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF3A21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yUozdZkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF3A21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeJSPTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:19:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbeJSPTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 11:19:19 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82D8C20869;
        Fri, 19 Oct 2018 07:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539933271;
        bh=xBNTmPUTp+0YPUTy6t9LRnxB8eqMJOpOFJFFLPxk/1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yUozdZkmdEoKAGnq+lm+PohBh0VfFRR4tl4b7GEs/9hBpXPI4HvgBwMSwDDzd+Lir
         AdZm5hE0VWWwcF3URvAOot4C0FOsSUauGkEAGiNP0NJfuwo/Z3cyXvhp8m8FDXzBTQ
         LS7kyzfdX/az1pjohPNZbc5hRJnswNHIGfc2a7ms=
Date:   Fri, 19 Oct 2018 09:14:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] drm fixes for 4.19 final
Message-ID: <20181019071428.GB28551@kroah.com>
References: <CAPM=9txsa9pSu0QaL3rWfSViRBkY3GB2Hm8=_SDp_TTiwsP_pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9txsa9pSu0QaL3rWfSViRBkY3GB2Hm8=_SDp_TTiwsP_pQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 02:59:11PM +1000, Dave Airlie wrote:
> Hi Greg,
> 
> Just a last set of misc core fixes for final.
> 
> 4 fixes, one use after free, one fb integration fix, one EDID fix, and
> one laptop panel quirk,
> 
> Thanks,
> Dave.
> 
> drm-fixes-2018-10-19:
> drm: one set of misc fixes for final release
> The following changes since commit 35a7f35ad1b150ddf59a41dcac7b2fa32982be0e:
> 
>   Linux 4.19-rc8 (2018-10-15 07:20:24 +0200)
> 
> are available in the Git repository at:
> 
>   git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-10-19

Now merged, thanks.

greg k-h
