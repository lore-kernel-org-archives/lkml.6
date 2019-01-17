Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EA4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5C520652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="ihU+42A0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfAQMT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:19:29 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:32822 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfAQMT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:19:28 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 6286325B760;
        Thu, 17 Jan 2019 23:19:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1547727562; bh=toeG74A7tPD9//tWwZ9d9JQs5MernHiBINuWSxGVR8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ihU+42A0wqE4J5WRhcM/STpLyAr/jAajSIY5h15Bizm/i+vc3v8g0oZVnHt+2uMRi
         UGuULnXCfw1Ff8fUU23qZaTPmFAQorbIqam6xUkPtomA9UpwvC+o9DvWqvvzi+z1EY
         xHR1v2H9EjRSsi/zbFJv1e8gYhg564z/2ViPlObU=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id CB312940459; Thu, 17 Jan 2019 13:19:19 +0100 (CET)
Date:   Thu, 17 Jan 2019 13:19:19 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <treding@nvidia.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Johan Hovold <johan@kernel.org>,
        Lukasz Majewski <lukma@denx.de>,
        Michal Simek <monstr@monstr.eu>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        ebiharaml@si-linux.co.jp
Subject: Re: [PATCH 01/11] dt-bindings: Add vendor prefix for Silicon Linux.
Message-ID: <20190117121919.c5u66sorut5a5nib@verge.net.au>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-2-git-send-email-fabrizio.castro@bp.renesas.com>
 <bb5b27ed-a077-f639-b97b-4da22c9bb3ad@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb5b27ed-a077-f639-b97b-4da22c9bb3ad@suse.de>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 12:17:56PM +0100, Andreas Färber wrote:
> Hi Fabrizio,
> 
> Am 16.01.19 um 19:37 schrieb Fabrizio Castro:
> > From: Biju Das <biju.das@bp.renesas.com>
> > 
> > Add Silicon Linux to the list of devicetree vendor prefixes.
> > 
> > Website: http://www.si-linux.co.jp
> > 
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > index 4b1a2a8..02a7037 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > @@ -344,6 +344,7 @@ sgx	SGX Sensortech
> >  sharp	Sharp Corporation
> >  shimafuji	Shimafuji Electric, Inc.
> >  si-en	Si-En Technology Ltd.
> > +si-linux	Silicon Linux Corporation
> 
> With the website being Japanese only, I haven't been able to confirm the
> spelling of the company name. Looks sensible though.

According to the company web site
(http://si-linux.co.jp/index.php?%E4%BC%9A%E7%A4%BE%E6%A1%88%E5%86%85)
the company name is.

Japanese: シリコンリナックス株式会社
English:  Silicon Linux Corporation

And in my opinion these are equivalent (although other translations of
the corporation bit are possible).

> Due to "en" coming before "five" I've double-checked that elsewhere we
> do order dashes before letters, so placement in file and tab-indentation
> is fine, too.
> 
> >  sifive	SiFive, Inc.
> >  sigma	Sigma Designs, Inc.
> >  sii	Seiko Instruments, Inc.
> 
> Personally I would drop the full stop at the end of the subject, but anyway:
> 
> Reviewed-by: Andreas Färber <afaerber@suse.de>
> 
> Thanks,
> Andreas
> 
> P.S. Please double-check how this excessive CC list came to life!
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer, Jane Smithard, Graham Norton
> HRB 21284 (AG Nürnberg)
> 
