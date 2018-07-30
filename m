Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23F113F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6A620893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6A620893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbeG3Ptq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:49:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35283 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbeG3Ptq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:49:46 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id ADA23805B3; Mon, 30 Jul 2018 16:14:31 +0200 (CEST)
Date:   Mon, 30 Jul 2018 16:14:31 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eckert.Florian@googlemail.com
Subject: Re: [PATCH] leds: add APU3 dmi information to leds-apu
Message-ID: <20180730141431.GA24051@amd>
References: <20180730091108.30098-1-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20180730091108.30098-1-fe@dev.tdt.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-07-30 11:11:08, Florian Eckert wrote:
> This driver should also get loaded if this is a APU3 from PC Engines.
> It has the same pin layout for leds.
>=20
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>

Acked-by: Pavel Machek <pavel@ucw.cz>


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltfHUcACgkQMOfwapXb+vK3ywCgjIl/fCx5BA6iYqdoGBZN7rzf
OI0An3PQwpwaqBy7K4QWbKBzT2KZCttG
=u87m
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
