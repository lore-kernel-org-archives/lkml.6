Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6665FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B292150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B292150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732776AbeISWkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:40:15 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34032 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbeISWkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:40:15 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id w8JH0tIf032615;
        Wed, 19 Sep 2018 19:00:55 +0200
Date:   Wed, 19 Sep 2018 19:00:55 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: process? [Re: Crypto Fixes for 4.19]
Message-ID: <20180919170055.GB32582@1wt.eu>
References: <20180105073808.GA14405@gondor.apana.org.au>
 <20180212031702.GA26153@gondor.apana.org.au>
 <20180428080517.haxgpvqrwgotakyo@gondor.apana.org.au>
 <20180622145403.6ltjip7che227fuo@gondor.apana.org.au>
 <20180829033353.agnzxra3jk2r2mzg@gondor.apana.org.au>
 <20180919062201.ov5o4vljvholgsed@gondor.apana.org.au>
 <20180919132324.GA24399@kroah.com>
 <d8c061a9-b415-e092-c28f-9e433d83b59b@infradead.org>
 <20180919164019.GA7195@kroah.com>
 <06e6fac1-6011-7117-454f-af930a288d75@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06e6fac1-6011-7117-454f-af930a288d75@infradead.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 09:48:42AM -0700, Randy Dunlap wrote:
> On 9/19/18 9:40 AM, Greg KH wrote:
> > On Wed, Sep 19, 2018 at 09:10:55AM -0700, Randy Dunlap wrote:
> >> submitting-patches.rst says:
> >> The Signed-off-by: tag indicates that the signer was involved in the
> >> development of the patch, or that he/she was in the patch's delivery path.
> > 
> > Yes, but not for git pulls.
> > 
> > I have not applied any patches sent in emails at this point in time, so
> > there's nothing that I could have even signed off on.
> 
> OK, I see.

Just FWIW, if this line was added, it would change the commit message
hence the resulting hash. That's why it only appears on patches really
committed by the mentioned people (typically using "git am").

Willy
