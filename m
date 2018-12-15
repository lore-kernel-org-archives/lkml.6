Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D82C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 19:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575212084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 19:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeLOTmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 14:42:05 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60624 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbeLOTmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 14:42:04 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id CD8D6808C2; Sat, 15 Dec 2018 20:41:58 +0100 (CET)
Date:   Sat, 15 Dec 2018 20:42:02 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: isp1704: switch to gpiod API
Message-ID: <20181215194201.GB31052@amd>
References: <20181213013858.23996-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <20181213013858.23996-1-sebastian.reichel@collabora.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-12-13 02:38:58, Sebastian Reichel wrote:
> This migrates isp1704 driver from old GPIO API to new descriptor
> based GPIO API and drops useless platform data as a side-effect.
>=20
> Migration is simple, since all mainline users are DT based and
> DT API does not change. Out of tree users of the platform data
> need to migrate to gpiod_lookup_table as described here:
>=20
> Documentation/driver-api/gpio/board.rst
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwVWQkACgkQMOfwapXb+vI2XwCfQ1Tx9Bx7hb1V9trNx0wWdtep
l5AAniXQcMV7UwsqACdEXEdcZtGKj9EJ
=YdWX
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
