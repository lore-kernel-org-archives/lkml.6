Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D067C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CAD208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CAD208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387440AbeHAUpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:45:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35051 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731900AbeHAUpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:45:23 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 5B6B3806C9; Wed,  1 Aug 2018 20:58:11 +0200 (CEST)
Date:   Wed, 1 Aug 2018 20:58:07 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Subject: Re: [PATCH v4 0/5] Initial support for Samsung Galaxy S and Galaxy S
 4G
Message-ID: <20180801185807.GB26087@amd>
References: <1530958183-10956-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <20180710120504.GB6884@amd>
 <5549799.hqpipYcP1I@acerlaptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
In-Reply-To: <5549799.hqpipYcP1I@acerlaptop>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-07-10 14:18:39, Pawe=C5=82 Chmiel wrote:
> On Tuesday, July 10, 2018 2:05:04 PM CEST Pavel Machek wrote:
> > Hi!
> >=20
> > > This patch series adds support for Samsung Galaxy S and Galaxy S 4G.
> > > Both are commercial phone based on Aries family.
> >=20
> > Thanks for doing this. What kind of userspace are your running?
> >=20
> > (I do have N900 here running Debian and PostmarketOS, and Droid 4
> > running Maemo Leste)
>=20
> Currently i'm running arch linux arm (but wanted to try PostmarketOS also=
).
>=20

Depending on your goals, Maemo Leste is worth looking at, too. (Unlike
postmarketOS, their goal is useful phone).

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltiAr8ACgkQMOfwapXb+vK/PQCePPUU7htshonWL95I58vGV6R8
C1cAoKBInX5dH/IJGUMvawlAPdE+VWCj
=VTyn
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
