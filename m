Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8962AC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4014D2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bPGEO+Cs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4014D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964939AbeFNQxB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 12:53:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32886 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755234AbeFNQw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 12:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OL6a8jo6YdsicKov6tqrjQ9OKEdb1o8bTMCiqqcsYZ0=; b=bPGEO+CsaGSta6z5KhiGswrS2
        Wq7UMMbUIHPM0NRUFIfOkEQR40oPBZINmHldpwkCUj2TOFLJykhi5Kh6MhsONtLN0bX1OucLnbQ03
        uhB8x4JDD2GSWoPYg46pX9xQXdiS+t5lIesraByc3Wp6RjFxW0kYa/Z7ZzCUSFQZx90Uh9ZJWD7qb
        VMulb13IN0ThkfQrep7RWrFEHBVKbSdOGcrAAYIR1VK99bjLsOZImaXEVeZXoFxuAZTHv+68JGBKo
        blkOr1S3+ipfXuJEVvzie+jwT5VbNw7mrZK29eKBDB0cZWtPDWcabcoRN6r+JjhwFlT5hWw4fMRl5
        Iqts+LvYw==;
Received: from 177.41.114.220.dynamic.adsl.gvt.net.br ([177.41.114.220] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTVUY-0003SX-Qw; Thu, 14 Jun 2018 16:52:59 +0000
Date:   Thu, 14 Jun 2018 13:52:54 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Alan Tull <atull@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Subject: Re: [PATCH v3 21/27] MAINTAINERS: get rid of non-existing
 Documentation/fpga
Message-ID: <20180614135254.75cfc17d@coco.lan>
In-Reply-To: <CANk1AXRnnYketpdvrsvN11hL6G9=WinzWHVM4k9VrGJZJ99pLQ@mail.gmail.com>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
        <948d6c0304eecaf916d21af5cfb0be21df80ed42.1528990947.git.mchehab+samsung@kernel.org>
        <CANk1AXRnnYketpdvrsvN11hL6G9=WinzWHVM4k9VrGJZJ99pLQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 14 Jun 2018 11:39:20 -0500
Alan Tull <atull@kernel.org> escreveu:

> On Thu, Jun 14, 2018 at 11:09 AM, Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org> wrote:
> > This directory seems to have moved to a new place
> > (Documentation/driver-api/fpga/), with is already at MAINTAINERS.
> >
> > So, get rid of the old location.  
> 
> Wow, you caught that fast!

Just a coincidence :-) I had to rebase a pending patch series close to
the end of the merge window.

When I ran the check tool:
	./scripts/documentation-file-ref-check

It detected this.

> There's other documentation coming to this
> directory soon.  IMO we might as well leave it.  We don't need to keep
> adding and deleting this line from MAINTAINERS.

Yeah, sure. I'll drop this hunk for v4.

> 
> Also, why didn't you cc linux-fpga mailing list on this?  I guess you
> ran get_maintainer.pl after adding this patch? :)

Yeah, that was the case. I also had to sanitize the c/c for this
specific patch as get_maintainers.pl isn't good enough to check for
MAINTAINERS access... it usually just get some random noise...

> 
> Alan
> 
> >
> > Cc: Alan Tull <atull@kernel.org>
> > Cc: Moritz Fischer <mdf@kernel.org>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  MAINTAINERS | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 783ce44b3e7a..67641f5bb373 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5632,7 +5632,6 @@ L:        linux-fpga@vger.kernel.org
> >  S:     Maintained
> >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/atull/linux-fpga.git
> >  Q:     http://patchwork.kernel.org/project/linux-fpga/list/
> > -F:     Documentation/fpga/
> >  F:     Documentation/driver-api/fpga/
> >  F:     Documentation/devicetree/bindings/fpga/
> >  F:     drivers/fpga/
> > --
> > 2.17.1
> >  



Thanks,
Mauro
