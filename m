Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE43CC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53C02133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="LCEwQqeq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732634AbeLQL51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:57:27 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:39368 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbeLQL50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:57:26 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 315E025B781;
        Mon, 17 Dec 2018 22:57:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1545047843; bh=EGALCNTKGVNOaL+dVMKp3+U2bBgnTVySbHLkf7vNckk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LCEwQqeqDKvxxsDk2aAMSlPLIW6oasXs/GB9Ga1TVdqF23KxrTbP7r39Tz3P3S4Hh
         W65qBLBhVC3xEucnoaKCMEb3uwJf5e0M2VSrJ3eQ2bKoAnMuX+Tptq5Hf54zb1jGub
         ZCAJuDQtBHnKzgnyeXI1dYat20NVViw2JvSrxgQ4=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id A2C0094048A; Mon, 17 Dec 2018 12:57:21 +0100 (CET)
Date:   Mon, 17 Dec 2018 12:57:21 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: display: renesas: lvds: Document r8a774c0
 bindings
Message-ID: <20181217115721.vn3u4ayzpwl3m7yq@verge.net.au>
References: <1544732454-6633-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732454-6633-1-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:20:54PM +0000, Fabrizio Castro wrote:
> The RZ/G2E (r8a774c0) supports two LVDS channels. Extend the binding to
> support them.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

