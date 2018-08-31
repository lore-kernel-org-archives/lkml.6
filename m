Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2EDC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E3220661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E3220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbeHaLSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 07:18:24 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:49468 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeHaLSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 07:18:24 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id A7B0223EEC;
        Fri, 31 Aug 2018 03:12:21 -0400 (EDT)
Date:   Fri, 31 Aug 2018 17:12:19 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] m68k/mac: Use correct PMU response format
In-Reply-To: <CAMuHMdUFss2C_ifNxU7OH_rbY4b9zS-v9P54qAfsjYuiZa8Jiw@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1808311707160.196@nippy.intranet>
References: <9b103c232c73b223ec951994c9789326754ef7a9.1535015050.git.fthain@telegraphics.com.au> <CAMuHMdUFss2C_ifNxU7OH_rbY4b9zS-v9P54qAfsjYuiZa8Jiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2018, Geert Uytterhoeven wrote:

> Hi Finn,
> 
> On Fri, Aug 24, 2018 at 4:02 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > Now that the 68k Mac port has adopted the via-pmu driver, it must decode
> > the PMU response accordingly otherwise the date and time will be wrong.
> >
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
> Looks good to me, so I will queue as a fix for v4.19.
> 

Thanks!

> I guess the proper Fixes tag is:
> 
> Fixes: ebd722275f9cfc67 ("macintosh/via-pmu: Replace via-pmu68k driver
> with via-pmu driver")
> 
> Can you please confirm? Thanks!
> 

If you want to add a 'fixes' tag, that would be it. I omitted the tag 
because a -stable tree isn't needed for this. I don't mind either way.

-- 

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
