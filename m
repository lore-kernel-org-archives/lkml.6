Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B43DC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 06:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B79D2159D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 06:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B79D2159D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbeHSJR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 05:17:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51696 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeHSJR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 05:17:56 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0A4032C;
        Sun, 19 Aug 2018 06:07:33 +0000 (UTC)
Date:   Sun, 19 Aug 2018 08:07:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Driver Project <devel@linuxdriverproject.org>
Subject: Re: [GIT PULL] Staging/IIO driver patches for 4.19-rc1
Message-ID: <20180819060730.GB2895@kroah.com>
References: <20180818155724.GA22569@kroah.com>
 <CA+55aFzB8vSuRatQAy=LmLxjeU48dPwW3tOGpZQaBjWRw115aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzB8vSuRatQAy=LmLxjeU48dPwW3tOGpZQaBjWRw115aQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 11:00:20AM -0700, Linus Torvalds wrote:
> On Sat, Aug 18, 2018 at 8:57 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Note, you will have a merge problem with a device tree IIO file and the
> > MAINTAINERS file, both resolutions are easy, just take all changed.
> 
> Heh, no. In neither case should I take all changes: the IIO was
> "delete both sides"), and in the MAINTAINERS file, which was delete
> one side, add another, somebody can't even sort stuff alphabetically.

Ah, wow, I totally read that diff backwards, you are right, thanks.

greg k-h
