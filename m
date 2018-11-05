Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B13C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E8220862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E8220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbeKESgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:36:03 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46029 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeKESgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:36:03 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 534D8807E4; Mon,  5 Nov 2018 10:17:15 +0100 (CET)
Date:   Mon, 5 Nov 2018 10:17:17 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-media@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Cameron <quozl@laptop.org>
Subject: Re: [PATCH 07/11] [media] marvell-ccic: drop unused stuff
Message-ID: <20181105091716.GA4439@amd>
References: <20181105073054.24407-1-lkundrak@v3.sk>
 <20181105073054.24407-8-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20181105073054.24407-8-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-11-05 08:30:50, Lubomir Rintel wrote:
> Remove structure members and headers that are not actually used. Saves
> us from some noise in subsequent cleanup commits.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvgCpwACgkQMOfwapXb+vI7cACeNwLsyq2Vrtlx7dcDL7gjUo6G
qfgAn3w4qvvC6oqOmrvJ8cTkzgS4JQlb
=jsJ9
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
