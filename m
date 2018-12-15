Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC861C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC0E21721
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="k/RJMUo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbeLOPSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 10:18:24 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:47804 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbeLOPSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 10:18:24 -0500
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 1A4D225AD76;
        Sun, 16 Dec 2018 02:18:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1544887101; bh=S8ZJ3dVNq/Pms366mTfLvJkvAsYUurKWV97MGvIvNU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k/RJMUo8zi4CkQ9EdXiM/bkTWz6Fc9VfCr0+XVZncSPNK+V+U75c8scaHCGCzMxYV
         4VlTy5cVAxzY/3wl9ss31N1SFyk5GbH+Z2xRT4jVGCXkbAi8o+KM16aw9BHPH7vNJq
         oYQeknZjObuxFTS+RSLWwpBtuwiE8fa4sS50i+Wo=
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 076B9E20E06; Sat, 15 Dec 2018 07:18:19 -0800 (PST)
Date:   Sat, 15 Dec 2018 16:18:19 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: renesas_usbhs: Add r8a774c0 support
Message-ID: <20181215151818.ymunljdhlduvvh7v@verge.net.au>
References: <1544732463-6685-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732463-6685-1-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:21:03PM +0000, Fabrizio Castro wrote:
> Document RZ/G2E (R8A774C0) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

