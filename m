Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7063EC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACFB2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="a9Pbk74G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfBYJLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 04:11:54 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:40345 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfBYJLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 04:11:54 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 9E80D25B784;
        Mon, 25 Feb 2019 20:11:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1551085911; bh=xoWh6WILwJ3szpjWPowPrDm52l1MEjnNY6vaK1hhatU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a9Pbk74Gxm8TC5Kg/7297a+NtxSjBaby4ucTrblo3xdNYK0Y5OK+NmBYd0hyzWVmk
         UH5eERjnESAU0AS9NNHKdyXPM16e6GXmoIdGLv/DMcZ8+V5T7aLDXIo20/+flOJnae
         eD7hvUYw8u8iQLwWKOzQ7LsHppnAEPajNyMVQf0A=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id BDDEA94056F; Mon, 25 Feb 2019 10:11:49 +0100 (CET)
Date:   Mon, 25 Feb 2019 10:11:49 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     twischer@de.adit-jv.com, patch@alsa-project.org,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jiada Wang <jiada_wang@mentor.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: renesas: r8a7796: remove unneeded sound
 #address/size-cells
Message-ID: <20190225091149.ojihawt67okyurk3@verge.net.au>
References: <1550828099-3109-1-git-send-email-twischer@de.adit-jv.com>
 <877edo3bt3.wl-kuninori.morimoto.gx@renesas.com>
 <20190225090054.idyvcxgy3kupsgat@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225090054.idyvcxgy3kupsgat@verge.net.au>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CC linux-renesas-soc@vger.kernel.org, for the record]

On Mon, Feb 25, 2019 at 10:00:54AM +0100, Simon Horman wrote:
> On Mon, Feb 25, 2019 at 10:30:49AM +0900, Kuninori Morimoto wrote:
> > 
> > Hi
> > 
> > > From: Jiada Wang <jiada_wang@mentor.com>
> > > 
> > > commit 78bc93b3ffb2 ("arm64: dts: renesas: r8a7796: Add address
> > > properties to rcar_sound port nodes") added missing #address-cells
> > > and #size-cells for sound ports.
> > > But, these are based on platform, not on SoC. This patch cleanups it.
> > > 
> > > Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> > > Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
> > > ---
> > 
> > I thought I had mentioned about this, but it seems no fix...
> > Anyway
> > 
> > 	Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Thanks Morimoto-san,
> 
> applied for v5.2.
