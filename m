Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10E2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA10A20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA10A20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeK0Akg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:40:36 -0500
Received: from gloria.sntech.de ([185.11.138.130]:56080 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbeK0Akg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 19:40:36 -0500
Received: from we0660.dip.tu-dresden.de ([141.76.178.148] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gRHDT-0000h2-3f; Mon, 26 Nov 2018 14:46:23 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Otavio Salvador <otavio.salvador@ossystems.com.br>
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Fabio Berton <fabio.berton@ossystems.com.br>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 08/13] ARM: dts: rv1108: Fix the PMU interrupt number
Date:   Mon, 26 Nov 2018 14:46:22 +0100
Message-ID: <6269571.AAM3N1jVdY@phil>
In-Reply-To: <CAP9ODKrX__KXo-XEdoaL=qwALFAxyzKV4-xu_t5baMqN1kQH4g@mail.gmail.com>
References: <20181125211907.9895-1-otavio@ossystems.com.br> <3361921.c4PKPBIJKP@phil> <CAP9ODKrX__KXo-XEdoaL=qwALFAxyzKV4-xu_t5baMqN1kQH4g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 26. November 2018, 14:36:01 CET schrieb Otavio Salvador:
> Hello Heiko,
> 
> On Mon, Nov 26, 2018 at 3:59 AM Heiko Stuebner <heiko@sntech.de> wrote:
> > Am Sonntag, 25. November 2018, 22:19:02 CET schrieb Otavio Salvador:
> > > According to the Rockchip vendor tree the PMU interrupt number is
> > > 76, so fix it accordingly.
> > >
> > > Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> > > Signed-off-by: Fabio Berton <fabio.berton@ossystems.com.br>
> >
> > looks ok, especially as the TRM I have doesn't list neither irqs :-)
> > But please explain the second Signed-off by Fabio?
> >
> > If Fabio is the original author, the patch From should reflect that
> > and the Signed-off-by lines should be swapped. As it is now
> > I would expect Fabio being the one sending the patches.
> > Or is it supposed to be a "Co-developed-by:"?
> > See Documentation/process/5.Posting.rst.
> 
> He works with me and he applied and tested it in our internal tree for
> our customer. He reviewed and tested this with me, so I'd like to
> provide him credit as well.

Reviewed-by:
Tested-by:

perhaps then? :-)


Heiko


