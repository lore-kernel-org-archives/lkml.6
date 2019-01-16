Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BE9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5B2206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393324AbfAPNs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:48:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34001 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387886AbfAPNs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:48:26 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 0D61C80852; Wed, 16 Jan 2019 14:48:17 +0100 (CET)
Date:   Wed, 16 Jan 2019 14:48:23 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Johan Hovold <johan@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Scott <hashcode0f@gmail.com>,
        NeKit <nekit1000@gmail.com>, omerlle@gmail.com,
        Sebastian Reichel <sre@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20190116134823.GA10145@amd>
References: <20181217004450.GW6707@atomide.com>
 <20181218124616.GA10758@amd>
 <20181218153650.GA6707@atomide.com>
 <20181218202242.GA30831@amd>
 <20181218215311.GD6707@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20181218215311.GD6707@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > I did a quick test in my config... and it did not break my old setup
> > > > -- voice calls still work when set up over USB and with manual mixer
> > > > setup. That was good surprise.
> > >=20
> > > OK good to hear. Using the n_gsm port instead of USB during idle
> > > has a major PM advantage as the SoC can hit retention during idle
> > > while still connected to the modem and getting notifications.
> > >=20
> > > So looks like during idle we can keep USB in autosuspend mode with
> > > something like the below shell script function.
> >=20
> > Yes, I should really start using serials instead of USB. But... I have
> > working ofono there, and was using that phone and am little short on
> > time at the moment.
>=20
> Hopefully adding support to ofono and modemmanager to use use
> /dev/motmdm1 for calls should be quite trivial now.

git@github.com:pavelmachek/ofono.git

"quite trivial" does not mix with ofono. I did parts and it is still
not finished. At the moment, I do not have enough working SIM cards to
test everything. Feel free to help :-).
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw/NicACgkQMOfwapXb+vJy2wCfYD/PszNYMbY/v/ahB9ybQFoX
u8MAn1+hKDArcUkhatVDZQqiL/oOtWhK
=wfWW
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
