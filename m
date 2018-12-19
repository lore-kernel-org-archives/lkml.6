Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220C9C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB74D21850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545204340;
	bh=1zzyZeJZfb6fePDeHelQgJQbMK/CMaaOhuETqe1wmDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d9BC3R4J+73Rui5x1Pbe7bSxkG5OF4zgX6q50CfAz1QwyeFqrcGje65RuHJ4jG7D3
	 sd1CfaRGLxkeaN8iDhpe+7klu4Y3wdJp8CeczlZ/iTRMRLlOzskfHNRgMvujHOROqC
	 d/7SUGK33SxoSHtRjob3ERGdDdpKPuaFdLreJ224=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbeLSHZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:25:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:49574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbeLSHZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 02:25:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 449EC21841;
        Wed, 19 Dec 2018 07:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545204337;
        bh=1zzyZeJZfb6fePDeHelQgJQbMK/CMaaOhuETqe1wmDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D54ASZSe9neBAa21/MouKWpvxqBS2v98UwNBaHbko+uXEDzIPPGE8x8BPJ0RTynRz
         U7gLmzSNVGAtEmNtpBW6sabaB36Pz9hx/w3lJWzCkxl+MEVoM5/9A5SMUbPVE9Oq1G
         FZwRw/rnoyH2C7NkehdO0Ia9P+aDzfSoqyYObFWk=
Date:   Wed, 19 Dec 2018 08:25:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: serial: sh-sci: Document r8a774c0
 bindings
Message-ID: <20181219072535.GA28473@kroah.com>
References: <1545134590-22510-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545134590-22510-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 12:03:10PM +0000, Fabrizio Castro wrote:
> RZ/G2E (R8A774C0) SoC also has the R-Car Gen3 compatible SCIF and
> HSCIF ports, so document the SoC specific bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> v1->v2:
> * Fixed title according to Geert's comment
> 
> This patch depends on:
> https://patchwork.kernel.org/patch/10565543/

I don't have that patch in my tree, so can you please resend all of the
pending patches that you need applied so that I can?  Including this one
too.

thanks,

greg k-h
