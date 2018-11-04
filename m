Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00351C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 11:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C6E2082D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 11:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C6E2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbeKDUt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 15:49:29 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38898 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbeKDUt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 15:49:28 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id ED52380986; Sun,  4 Nov 2018 12:34:44 +0100 (CET)
Date:   Sun, 4 Nov 2018 12:34:04 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Add OLPC vendor prefix
Message-ID: <20181104113404.GE23864@amd>
References: <20181010163824.269277-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mR8QP4gmHujQHb1c"
Content-Disposition: inline
In-Reply-To: <20181010163824.269277-1-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mR8QP4gmHujQHb1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 18:38:24, Lubomir Rintel wrote:
> One Laptop Per Child is a non-profit that produced the XO series of
> eductional laptops for children.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mR8QP4gmHujQHb1c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlve2SwACgkQMOfwapXb+vLhxACeNmBqI0T4EDjSzT29gee6YiO+
SdgAn1bNHRWjk0G5HdVk2RoFI/hEQ/5C
=+IlM
-----END PGP SIGNATURE-----

--mR8QP4gmHujQHb1c--
