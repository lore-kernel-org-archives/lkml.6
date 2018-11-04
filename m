Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536A2ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 11:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2295620854
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 11:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2295620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbeKDVDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 16:03:35 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39499 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbeKDVDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 16:03:34 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 97F2680960; Sun,  4 Nov 2018 12:48:48 +0100 (CET)
Date:   Sun, 4 Nov 2018 12:48:50 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 4/8] clk: mmp2: add SP clock
Message-ID: <20181104114850.GH23864@amd>
References: <20181010142504.233467-1-lkundrak@v3.sk>
 <20181010142504.233467-5-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MP5ln1Rcf9Bvi+ZW"
Content-Disposition: inline
In-Reply-To: <20181010142504.233467-5-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MP5ln1Rcf9Bvi+ZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 16:25:00, Lubomir Rintel wrote:
> The "security processor", sometimes referred to as "wireless trusted
> module" or "generic encrypt unit" is a low-power core present on MMP2,
> that has nothing to do with security, wireless, trust or encryption.
>=20
> On an OLPC machine it runs CForth and serves as a keyboard controller:
> http://dev.laptop.org/git/users/wmb/cforth/tree/src/app/arm-xo-1.75/ps2.f=
th
>=20
> The register address was obtained from the OLPC kernel, since the
> datasheet seems to be the Marvell's most important business secret.
>=20
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--MP5ln1Rcf9Bvi+ZW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlve3KIACgkQMOfwapXb+vI0eQCfQloAAVjKQSZofPO/UZnoIebe
ZV4AnirIF9w7IEd86O82WRODtS15nhnB
=zOEP
-----END PGP SIGNATURE-----

--MP5ln1Rcf9Bvi+ZW--
