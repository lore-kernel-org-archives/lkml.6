Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF6FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E75924710
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E75924710
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933854AbeGDGxK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:53:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51093 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933206AbeGDGxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:53:09 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 57EE580594; Wed,  4 Jul 2018 08:53:06 +0200 (CEST)
Date:   Wed, 4 Jul 2018 08:53:05 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     jacek.anaszewski@gmail.com, ben.whitten@gmail.com,
        geert+renesas@glider.be, w@1wt.eu, pombredanne@nexb.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v2] leds: ledtrig-morse: send out morse code
Message-ID: <20180704065305.GA23509@amd>
References: <20180703155328.GA18299@arbeit>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20180703155328.GA18299@arbeit>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-07-03 17:53:28, Andreas Klinger wrote:
> Send out a morse code by using LEDs.
>=20
> This is useful especially on embedded systems without displays to tell the
> user about error conditions and status information.
>=20
> The trigger will be called "morse"
>=20
> The string to be send is written into the file morse_string and sent out
> with a workqueue. Supported are letters and digits.
>=20
> With the file dot_unit the minimal time unit can be adjusted in
> milliseconds.
>=20
> Also add documentation for the morse led trigger
>=20
> Thanks to Greg and Geert for suggesting improvements
>=20
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

As I stated before, I don't think morse encoder belongs in kernel.

LED pattern trigger should be merged, instead.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAls8btEACgkQMOfwapXb+vIl/wCeN+xEVRwOmIgwfh5wGeO83+ss
+G8An1B7SRgMEcZNiLOksSbMiilQkECn
=jugO
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
