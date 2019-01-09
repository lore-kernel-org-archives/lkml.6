Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EC0C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4B920657
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547059152;
	bh=r17Y21f9hRuQJpwNP1r4UcuaEVgO6/BJNlVrHLAymL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DEqf7/627Lo5xrcURSEovZdTsFnEzZRjTwBHrbQqPU5OznYRl6+RXisaEh4TcH2TV
	 73OH+H4otrUQeMblm1rhciB3oHk1NoasPUMGQmnzFsSGOFjkn30pLiLte19RxyOW78
	 T2al0oOYHsoBCT+AaaK+F3D2fKs5SkxB3Z4o+REQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfAISjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:39:11 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44576 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfAISjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5FoI7gSu/ENNy82kt7SSlXlBu2Xn9OA9Gyq+j2PR5Gc=; b=vLjP5xhRWEWAqD1G/u43gs7+K
        PxgKk1/k8vOQE5YMRtuHl+Q1yyIS3kGU8f3cGHVrS3IDyKQrz4jlCPlAjKDaMJB0G5ldjYBHvXF7d
        ai/f6JwEwOnDn8LKW8TVSGzdVQd7OgG+B4W0BbwpXdwLUN7CsiyEmzWzEnpEW4dz+L1wo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ghIkO-0000jo-HJ; Wed, 09 Jan 2019 18:38:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0D31B1127528; Wed,  9 Jan 2019 18:38:36 +0000 (GMT)
Date:   Wed, 9 Jan 2019 18:38:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     b-ak <anur.bhargav@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tlv320aic32x4: SND_SOC_DAPM_MICBIAS is deprecated
Message-ID: <20190109183836.GI10405@sirena.org.uk>
References: <20190109171121.GA12810@Ideapad-330S>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2nTeH+t2PBomgucg"
Content-Disposition: inline
In-Reply-To: <20190109171121.GA12810@Ideapad-330S>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2nTeH+t2PBomgucg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 10:41:21PM +0530, b-ak wrote:
> SND_SOC_DAPM_MICBIAS is deprecated, replace it with SND_SOC_DAPM_SUPPLY.
>=20
> MICBIAS voltage wasn't supplied to the microphone with the older
> SND_SOC_DAPM_MICBIAS widget, hence the microphone wouldn't work.
>=20
> This patch fixes the problem.

Note that the reason we've not done that already for everything is that
the DAPM graph needs updating for the new routing in machine drivers as
the two widgets are wired differently.  However this is fine here as
there aren't any in tree users I can see so I'll apply, thanks!

--2nTeH+t2PBomgucg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2P6sACgkQJNaLcl1U
h9CTzwf8CHx4tksZFKzyy1F8/aAi0gjcds5AuFQHz7K20Fmrvr6QvPbtCT7JVt/T
uVSnOIBqpXMo+NY36bJieBEgol5y8iKrpDvJG9JWQtOZTzjMT9yKEi3JdqFrN24Z
QB/NOFIfIuIut0Wj2npruViGZh0K/LW45tp1ykl5RfZA1dNYEMhnGSM0oqhBvP1d
uxf1VYyxY5c9fFiYNlBJdzbqQvJIZyNJM1U+APm+9miAbdSw0//hu4KxnwVQgJx3
hSApVBtwc2ySN7jAuR5Q+lsm68tR9AfGh19PE1+Tf7xLjorq6nLS56IcKJgL5TCM
fgjN4I15oddD9zi0/ibTid0ICyxDsA==
=A9Mu
-----END PGP SIGNATURE-----

--2nTeH+t2PBomgucg--
