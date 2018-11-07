Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BC5C46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6043F2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6043F2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389198AbeKGLf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 06:35:26 -0500
Received: from utopia.booyaka.com ([74.50.51.50]:53981 "EHLO
        utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388990AbeKGLf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 06:35:26 -0500
Received: (qmail 30180 invoked by uid 1019); 7 Nov 2018 02:00:30 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Nov 2018 02:00:30 -0000
Date:   Wed, 7 Nov 2018 02:00:30 +0000 (UTC)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     Stephen Boyd <sboyd@kernel.org>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Megan Wachs <megan@sifive.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-riscv@lists.infradead.org, paul@pwsan.com
Subject: Re: [PATCH v2 2/3] dt-bindings: clk: add documentation for the SiFive
 PRCI driver
In-Reply-To: <154152561238.88331.13239370518226908068@swboyd.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.999.1811070159350.29982@utopia.booyaka.com>
References: <20181020135024.28573-1-paul.walmsley@sifive.com> <20181020135024.28573-3-paul.walmsley@sifive.com> <154152561238.88331.13239370518226908068@swboyd.mtv.corp.google.com>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2018, Stephen Boyd wrote:

> Quoting Paul Walmsley (2018-10-20 06:50:23)
> > diff --git a/Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt b/Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt
> > new file mode 100644
> > index 000000000000..d7c1e83fa5ed
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt
> > @@ -0,0 +1,43 @@
> > +SiFive FU540 PRCI bindings
> > +
> > +On the FU540 family of SoCs, most system-wide clock and reset integration
> > +is via the PRCI IP block.
> > +
> > +Required properties:
> > +- compatible: Should be "sifive,<chip>-prci<version>".  As of the time this
> > +              file was written, only one value is supported:
> 
> I don't think we need the "As of the time" sentence. It will become out
> of date almost immediately so why not just say "The list of supported
> values is:"?

Adopted this change.  Thanks for the review.


- Paul
