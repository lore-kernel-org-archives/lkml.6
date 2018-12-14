Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2324DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD40D206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="kud2R5+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbeLNQhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:37:09 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:36522 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbeLNQhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:37:08 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 969DA25BEDF;
        Sat, 15 Dec 2018 03:37:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1544805425; bh=TW+/zpEJIjRSteNbkG0os5DfYRZ0gPBOEkESA3x5MrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kud2R5+0h/G3DZPEDzT5kMxymAiXx1ZJBbv7jfgN32RVTjhG//P7CE3MEjc+/de8q
         43pf6BCqk5HYPUP1zqRzBL9kZge9cazYyKZS++pi7xx7S++DokrPrraqeLAre4G3t4
         nqU1Bl92ljYALX6ifovaQAYxzfzLDFJQ+iMjF6Jg=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id D91559403C3; Fri, 14 Dec 2018 17:37:03 +0100 (CET)
Date:   Fri, 14 Dec 2018 17:37:03 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das@bp.renesas.com>,
        Ulrich Hecht <ulrich.hecht+renesas@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: rcar: Add r8a774c0 support
Message-ID: <20181214163703.c3itx4fcrg5ltmdq@verge.net.au>
References: <1544732342-6131-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732342-6131-1-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:19:02PM +0000, Fabrizio Castro wrote:
> Document RZ/G2E (R8A774C0) I2C compatibility with the relevant driver
> dt-bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

