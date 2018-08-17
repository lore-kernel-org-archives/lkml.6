Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A45C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33274218DB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="RpGRsHme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33274218DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbeHQM7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:59:32 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:49247 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbeHQM7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:59:32 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id C1E0425BEE1;
        Fri, 17 Aug 2018 19:56:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1534499804; bh=lx3uqoDAPwupj+D9FVRwNh5EyEraOfhRHW4bNK8sKzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RpGRsHmesEivwYvwLEoW5GjgMqpF7vuZkVEHdJC4uq+Is3Z8KHdUHMG4TQE0l3BPl
         skc48wKvRoAw8U4E16zqMQx5FBphGUf4nfG6UggL5nFed/BtDpO24J6rVc45SncEr1
         zQRkX17cDdvw67BQb4UTxxR2Bb1JbHMbnlQbFEnc=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id B9815940453; Fri, 17 Aug 2018 11:56:41 +0200 (CEST)
Date:   Fri, 17 Aug 2018 11:56:41 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Rob Herring <robh@kernel.org>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        Ulrich Hecht <ulrich.hecht+renesas@gmail.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: rcar: Add r8a774a1 support
Message-ID: <20180817095641.aolmewiurhazx66s@verge.net.au>
References: <1534249975-15588-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180815201442.GA31058@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815201442.GA31058@rob-hp-laptop>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 02:14:42PM -0600, Rob Herring wrote:
> On Tue, 14 Aug 2018 13:32:55 +0100, Fabrizio Castro wrote:
> > Document RZ/G2M (R8A774A1) I2C compatibility with the relevant driver
> > dt-bindings.
> > 
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> > ---
> >  Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

