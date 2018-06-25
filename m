Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5237EC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38A624F26
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="u6fWj0bA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38A624F26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933047AbeFYLXm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:23:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46034 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754720AbeFYLXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SqoGsyRUgaGijueL2P9Jq+hlgy28AgkOmb9jQ7oCZao=; b=u6fWj0bACrLFCtHDZmCbB61Jo
        aeNtIc7MkIt4q34QPF5ul673rvi8/yZU7y2NOt+F8qGQkSE9bPQ7GxE2ifrD1C/mWuIWixYuVRsAF
        N9jnzpPwkfOG9gdAoPWH9ZBHpTekIP1ER32VXR64KK3SCpylNbPhRSBiQsYtJrUB/BgUo=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXPak-0007mY-V4; Mon, 25 Jun 2018 11:23:31 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXPak-0004OK-HG; Mon, 25 Jun 2018 12:23:30 +0100
Date:   Mon, 25 Jun 2018 12:23:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ALSA: ac97: add bus binding for codecs
Message-ID: <20180625112330.GD9413@sirena.org.uk>
References: <20180622192834.7797-1-robert.jarzmik@free.fr>
 <s5h36xbe1cp.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Content-Disposition: inline
In-Reply-To: <s5h36xbe1cp.wl-tiwai@suse.de>
X-Cookie: I'm having a MID-WEEK CRISIS!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 25, 2018 at 10:07:02AM +0200, Takashi Iwai wrote:
> On Fri, 22 Jun 2018 21:28:33 +0200,
> Robert Jarzmik wrote:
> >=20
> > Add the generic ac97 bus binding, especially for ac97 codecs discovered
> > by ac97 hardware probing.
> >=20
> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>=20
> OK, now I applied both patches.
>=20
> Mark, if you need these changes, pull topic/ac97-bus branch from my
> tree.  It's a clean branch from 4.18-rc1.

Thanks!

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsw0LEACgkQJNaLcl1U
h9DfrAf9GlxyEFEs2pxqfLQp4kmb6cd1fA5N3twtiLq0KnqFUsIX95MX0ZT37p+V
cFSoD5v+C+bvhvjeEP0ASkFWqo+C45LsR6yh7nyAzrpahjCaKcWXscx0wh7v/A5+
gHB4e+kb58vi49pTptg1uMhY7osfqX1UpO11Sw3xK4kUnrTRGrFh2ahxIUbySx9U
taK4MBGBrEJnstdevxGesPRxuMXcQuv7bG5wUbAFX9e4STQIqVFpKy7pgO99XMzQ
P8kVQAAxUP6kOf61KsnSfSCHJZAIR0uLNFNU+l1RRCjDOi4BOr/sKnF14jptTXzK
pRq5FPsDVuOimrbmg/iqP3OPawUHMA==
=VlxG
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--
