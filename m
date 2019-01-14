Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C88BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC1B2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfANJib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:38:31 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33187 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfANJia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:38:30 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 17CAD809E5; Mon, 14 Jan 2019 10:38:23 +0100 (CET)
Date:   Mon, 14 Jan 2019 10:38:27 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@llwyncelyn.cymru>,
        Jiri Slaby <jslaby@suse.cz>, Johan Hovold <johan@kernel.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 0/3] serdev support for n_gsm
Message-ID: <20190114093827.GA20510@amd>
References: <20190114012528.2367-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20190114012528.2367-1-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2019-01-13 17:25:25, Tony Lindgren wrote:
> Hi all,
>=20
> Here's a series of patches to add initial serdev support to n_gsm
> TS 27.010 line discipline.
>=20
> This allows handling vendor specific protocols on top of TS 27.010 and
> allows creating simple serdev drivers where it makes sense. So far I've
> tested it with droid 4 for it's modem to provide char devices for AT
> ports, modem PM support, and serdev drivers for GNSS and Alsa ASoC.
>=20
> I'll be posting the related MFD, GNSS and Alsa ASoC drivers separately.
> For reference, the MFD driver is at [0], the GNSS driver at [1], and
> the Alsa ASoC driver at [2] below.

For the series:

Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks for doing this!
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw8WJMACgkQMOfwapXb+vKm5wCfcgQc/RoV7ugMqwQ/9ftNQuFK
KggAnj+WGa+X3casYnsEbEIhVrJK4CG9
=vRKC
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
