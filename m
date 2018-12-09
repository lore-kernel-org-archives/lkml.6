Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1113C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 17:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C87A20837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 17:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C87A20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbeLIRms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 12:42:48 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36093 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbeLIRmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 12:42:47 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C3F498076F; Sun,  9 Dec 2018 18:42:41 +0100 (CET)
Date:   Sun, 9 Dec 2018 18:42:45 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: Droid 4: poweroff does not work? calls
Message-ID: <20181209174244.GA28617@amd>
References: <20181209121318.GA24478@amd>
 <20181209164650.GX6707@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <20181209164650.GX6707@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-12-09 08:46:50, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [181209 12:13]:
> > Hi!
> >=20
> > Poweroff does not seem to work on Motorola droid 4 -- it reboots. It
> > seems to be problem "forever", 4.18 and 4.20-rc5 seem to be
> > affected. It is bad, because when your battery is low, you get into
> > reboot loop and discharge it furher, which batteries do not like.
> >=20
> > Any ideas, or at least idea how to debug this?
>=20
> Hmm can you check if this is happening with usb unloaded or
> unbind? I suspect ohci or musb..

I tried disabling USB in the config, with v4.20-rc, and same
behaviour. sudo poweroff causes reboot.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwNVBQACgkQMOfwapXb+vIhxACfU+qMvE2H576SW5FXcUNHpjFg
6IQAn3YkX5S6nEQyJb8mUqTXTM3GRXr+
=eZVg
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
