Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9371C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA13F20869
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545236705;
	bh=ynBOE4cQfiV3/sV2QIv7YW4C9thhLZNSnCbJdKc26x8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uPSuCmlcI8Rs6y3MEo/e8/cr0hhjO4vrScDAxN5F54B6HAu6N5tg7BPcneXbHTz9r
	 GxG+qWHF8y5KwPtVA3lN2T3BGTX1sMN7OeKcYHXIX15puVdbjjXjJuGBW7CV96YHkX
	 B3MpdeRBk8TIQzTPQQhHJKWzoxPK7DECqWnfHiw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbeLSQZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:25:04 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42282 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbeLSQZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ynBOE4cQfiV3/sV2QIv7YW4C9thhLZNSnCbJdKc26x8=; b=NtDfhc5r0Cbr9T8h2dph2oMOZ
        /zS/uujyIgGXJ5yV0L5CJJQadmOh5F/LRu+GL+F1PfyojLo+ex5Ybg3JkXR2/KMsOcmHP0CCf49OB
        pwsKIE0hYKFSjwYpZPKArdoY3yO7gQJEDDfEyMFkf0Kxr9YV3H7VcVU1ChQAKPsM5D+98=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gZeeA-0004mf-Mj; Wed, 19 Dec 2018 16:24:34 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3FC0B11259E9; Wed, 19 Dec 2018 16:24:34 +0000 (GMT)
Date:   Wed, 19 Dec 2018 16:24:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vishal Sagar <vsagar@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ASoC: xlnx: change license header format style
Message-ID: <20181219162434.GE8130@sirena.org.uk>
References: <1545212440-109949-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
 <20181219151704.GA5040@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="orO6xySwJI16pVnm"
Content-Disposition: inline
In-Reply-To: <20181219151704.GA5040@infradead.org>
X-Cookie: <Manoj> I *like* the chicken
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--orO6xySwJI16pVnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 19, 2018 at 07:17:04AM -0800, Christoph Hellwig wrote:
> On Wed, Dec 19, 2018 at 03:10:40PM +0530, Maruthi Srinivas Bayyavarapu wrote:
> > Changed License header from C to C++ style comment block.

> Why this completely pointless uglification that goes counter to
> the common style all over the kernel?

I asked for it, when you end up with a C++ comment immediately adjacent
to a C comment block it doesn't exactly look clean and intentional
either.

--orO6xySwJI16pVnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwacMEACgkQJNaLcl1U
h9BXJggAgDnUwbPAA4QfJoHhG2/p1leWGoIKiP4Fr4dYKmHefRmCIpCH27hX39HY
Py4SFoThSWx7Q+DVQLAmSGBIUpIC4yZtiHmmJFDuS2gyJV5u935ZckVV/5e+AfKV
zAqjANpHoBpJDAiJOYNkuHUH8g0sQ8GFe7Rodd7H909t0KzdwUd/Tnv57BWUdD7k
6GpVSqF/93i0qVZVeG2bcNgD8gYGPACkmoXDeLn9HogzbVBGW3zUOfc/R38HU4Rs
/isIDR8v3EF9+YGssN3yz37KvAjVwXP8WtVogzXlOXjzGpEkvQINQL9mE/qSCj70
rWoj+/j2bf6Km6ksAAe8w+yrEg0N2g==
=msUA
-----END PGP SIGNATURE-----

--orO6xySwJI16pVnm--
