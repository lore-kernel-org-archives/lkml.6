Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E45AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00972146F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="Hz00Wsf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfBZLOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:14:17 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:34750 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBZLOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:14:17 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 8563825BEDD;
        Tue, 26 Feb 2019 22:14:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1551179654; bh=vl6VLfE2pOIXDr/KikVjWTZsnGFLS27ADPxyOs9iF44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hz00Wsf3tf290EhO0kWVNO3uE93u5vWv+sb5sI4hM1bFaYcB5flb1T4RHJfpJOtDd
         PjSOpPeUiOuGNlqZfh3CIjuS0yV2YDrwI9OpC/EEIZiJ3U2/1LpbZ99Tw0WDA+hdCA
         qUKLZV112XBetkWXmXd0rnUZm2WR48euzJrnxWNk=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id D34D0940373; Tue, 26 Feb 2019 12:14:12 +0100 (CET)
Date:   Tue, 26 Feb 2019 12:14:12 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     twischer@de.adit-jv.com, patch@alsa-project.org,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH v2] arm64: dts: renesas: r8a77965: add SSIU support for
 sound
Message-ID: <20190226111412.llczj7f7t3ssfu2g@verge.net.au>
References: <1551098381-1733-1-git-send-email-twischer@de.adit-jv.com>
 <87a7ijbfdx.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7ijbfdx.wl-kuninori.morimoto.gx@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 08:58:37AM +0900, Kuninori Morimoto wrote:
> 
> Hi
> 
> > rsnd driver supports SSIU now, let's use it.
> > Then, BUSIF DMA settings on rcar_sound,ssi (= rxu, txu) are
> > no longer needed.
> > Applies commit 8d14bfa074db ("arm64: dts: renesas: r8a7796: add SSIU
> > support for sound") and commit 10bd03fa896e ("arm64: dts: renesas:
> > r8a7796: remove BUSIF0 settings from rcar_sound,ssi") for r8a77965.
> > 
> > Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> > Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
> > ---
> 
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, applied for v5.2.
