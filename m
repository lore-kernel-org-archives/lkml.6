Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75401C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B9521096
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B9521096
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbeFYPdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:33:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45289 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbeFYPdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:33:47 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E811880551; Mon, 25 Jun 2018 17:33:45 +0200 (CEST)
Date:   Mon, 25 Jun 2018 17:33:45 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Raffaello D. Di Napoli" <rafdev@dinapo.li>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: Modify PC Engines apu/apu2 driver to support apu3
Message-ID: <20180625153345.GA6003@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-06-25 08:50:02, Raffaello D. Di Napoli wrote:
> PC Engines apu3 is an improved version of the apu2, using the same SoC
> and almost everything else.
>=20
> This patch reuses as much as possible from the apu2 definitions, to
> avoid redundancy.

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsxC1kACgkQMOfwapXb+vKgvACeIW05lX9IiDIGvVwDb5748e6m
M5YAoKhC4w/R+dT2hgwgvMy7wiJRPgGQ
=hX8B
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
