Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F7EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C062E218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfBKUv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:51:29 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35950 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfBKUv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:51:29 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A6DE580292; Mon, 11 Feb 2019 21:51:19 +0100 (CET)
Date:   Mon, 11 Feb 2019 21:51:25 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.9 034/137] ARM: mmp/mmp2: dt: enable the clock
Message-ID: <20190211205125.GB22473@amd>
References: <20190211141811.964925535@linuxfoundation.org>
 <20190211141815.120436242@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
In-Reply-To: <20190211141815.120436242@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> 4.9-stable review patch.  If anyone has any objections, please let me kno=
w.
>=20
> ------------------
>=20
> [ Upstream commit f36797ee43802b367e59f0f9a9805304a4ff0c98 ]
>=20
> The device-tree booted MMP2 needs to enable the timer clock, otherwise
> it would stop ticking when the boot finishes.
>=20
> It can also use the clock rate from the clk, the non-DT boards need to
> keep using the hardcoded rates.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

While I agree this is good idea for mainline (thus my ack), I don't
think it is suitable for stable, as older kernels will not run on OLPC
in useful way, anyway.

Not-acked-for-stable-by: Pavel Machek <pavel@ucw.cz>

So I don't think this and ARM: dts: mmp2: fix TWSI2 is good idea for
stable kernels.

								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxh4E0ACgkQMOfwapXb+vJiHQCguwgD9xo7si4TDrOEuNR3pkdG
uHEAn3JHvlYc58pw0bWAhmfb2UqIlav2
=bOaf
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
