Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09EBC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBFC218DB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="OXJuSa//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBFC218DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeHQM76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:59:58 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:49264 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeHQM76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:59:58 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 8EF2625BE87;
        Fri, 17 Aug 2018 19:57:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1534499829; bh=Ng9zPsJshS3IuJH7TojlHDrjcrDUpXGY9oZsnqbnevo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OXJuSa//4DZZyYJYvw7ZAnDOJUneNUQeS+VB8AnCLrT4OxJfhh9gLx1NaBo+uEAFa
         abGXZmzCuTatZYCLDQcv425bp2jRFEaO25p8FABMhCD7W97FfNx1oieCEwvBJ2FMk2
         UgU6aoPp3KpCRZVSTqelHjhrnlsXXT1GTznl8teQ=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 8FA63940453; Fri, 17 Aug 2018 11:57:07 +0200 (CEST)
Date:   Fri, 17 Aug 2018 11:57:07 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Rob Herring <robh@kernel.org>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Biju Das <biju.das@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: sh_mobile: Add r8a774a1 support
Message-ID: <20180817095707.e5jehzp4dp32xayk@verge.net.au>
References: <1534249988-15635-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180815201520.GA32035@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815201520.GA32035@rob-hp-laptop>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 02:15:20PM -0600, Rob Herring wrote:
> On Tue, 14 Aug 2018 13:33:08 +0100, Fabrizio Castro wrote:
> > Document RZ/G2M (R8A774A1) SoC bindings.
> > 
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> > ---
> >  Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

