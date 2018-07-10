Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961C3C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2F02089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2F02089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933352AbeGJNx3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:53:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56938 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754201AbeGJNx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:53:28 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6A3AA804D8; Tue, 10 Jul 2018 15:53:26 +0200 (CEST)
Date:   Tue, 10 Jul 2018 15:53:26 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: droid 4: no sound in the morning
Message-ID: <20180710135325.GA23878@amd>
References: <20180710105910.GA4442@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20180710105910.GA4442@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-07-10 12:59:10, Pavel Machek wrote:
> Hi!
>=20
> I attempted to use droid 4 as an alarm clock, but got no sound in the
> morning.
>=20
> Log said:
>=20
> [78798.682830] omap-mcbsp 40124000.mcbsp: CLKS: could not
> clk_set_parent() to prcm_fck
> [78803.561767] omap-mcbsp 40126000.mcbsp: CLKS: could not
> clk_set_parent() to prcm_fck
>=20
> Could it be related? Everything ok after reboot, v4.18-rc4.
>=20
> Does anyone else see that? Any ideas?

Ok, so I see that

[ 1775.896270] Charging, 4350000 uV, 532000 uA
[ 1778.700286] omap-mcbsp 40124000.mcbsp: CLKS: could not
clk_set_parent() to prcm_fck
[ 1778.898468] Charging, 4350000 uV, 532000 uA

=2E..even when audio still works. So possibly not related.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltEulUACgkQMOfwapXb+vJTMACeIPf7uc+TNJ5u3B2DyqzETeFi
5eUAnRiPLxAC+DKBwE/o/KfX6a3Bv+QX
=emDT
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
