Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AB8C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CB621565
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="rikGspcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CB621565
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeHQNEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:04:54 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:49378 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeHQNEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:04:53 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id BCFCA25B803;
        Fri, 17 Aug 2018 20:02:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1534500124; bh=PHGuXC/ebiAU1KB+qNnmU1rG2OITbwsQNueSCvrxOBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rikGspcYIMv1c2kRt8QGD4GkzcJOmfhbjLbcDMwN1GasbdcNmIhLuYkz20XqjrIHp
         ScTW04Q0o/iB4+FYietbdcqMsBP+pYoyF9zyh9llz1LIQIM7U9RhZeDy0702G22z6I
         45eOQdnAL7/mvdBC/RdOYCVT1fai7H2JBbVQVDF0=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id BC5FD940453; Fri, 17 Aug 2018 12:02:01 +0200 (CEST)
Date:   Fri, 17 Aug 2018 12:02:01 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Rob Herring <robh@kernel.org>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: renesas_sdhi: Add r8a774a1 support
Message-ID: <20180817100201.d762mirtkngr3am5@verge.net.au>
References: <1534250074-15890-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1534250074-15890-3-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180815202405.GA13760@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815202405.GA13760@rob-hp-laptop>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 02:24:05PM -0600, Rob Herring wrote:
> On Tue, Aug 14, 2018 at 01:34:34PM +0100, Fabrizio Castro wrote:
> > Document RZ/G2M (R8A774A1) SoC bindings.
> > 
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Not sure why you didn't use 'dt-bindings: mmc: ' for the subject like 
> the others, but anyways:
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

