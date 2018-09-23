Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C5CECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 18:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451E5208D9
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 18:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451E5208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeIXAOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 20:14:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49390 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbeIXAOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 20:14:06 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1D71410A7;
        Sun, 23 Sep 2018 18:15:44 +0000 (UTC)
Date:   Sun, 23 Sep 2018 20:15:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: Re: Linux 4.19-rc5
Message-ID: <20180923181542.GB6505@kroah.com>
References: <20180923175547.GA4462@kroah.com>
 <CAMuHMdU5NnL6n_KbBRGdmV5XGsBkDsfzJKuiNB=hhqt0_mON1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU5NnL6n_KbBRGdmV5XGsBkDsfzJKuiNB=hhqt0_mON1Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 08:05:23PM +0200, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Sun, Sep 23, 2018 at 7:57 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > As almost everyone knows, it's been an "interesting" week from a social
> > point-of-view.  But from the technical side, -rc5 looks totally normal.
> 
> Thanks for, and congratulations with, your first non-stable release!

Thanks.

> > As usual, please go and test this thing, and let me know if anything
> > technical isn't getting addressed that needs to be.
> 
> Oops... non-technical... you might want to drop the "stable" from your
> future rcX tags ;-)

Ugh, and here I thought I could recycle that script of mine, nice catch,
I'll fix that up for next time :)

Nice catch, it's good to see that people verify the signed tags.

greg k-h
