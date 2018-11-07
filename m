Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2256CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E032081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E032081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeKGWbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:31:22 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55687 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeKGWbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 17:31:22 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mgr@pengutronix.de>)
        id 1gKNSB-0006ct-Oy; Wed, 07 Nov 2018 14:01:03 +0100
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mgr@pengutronix.de>)
        id 1gKNS9-0004Pe-RG; Wed, 07 Nov 2018 14:01:01 +0100
Date:   Wed, 7 Nov 2018 14:01:01 +0100
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stoth@kernellabs.com, laurent.pinchart@ideasonboard.com,
        kernel@pengutronix.de, mchehab@kernel.org, davem@davemloft.net
Subject: Re: [PATCH 1/2] media: mst3367: add support for mstar mst3367 HDMI RX
Message-ID: <20181107130101.a2geyss47gpfd6nc@pengutronix.de>
References: <20181019105439.27796-1-m.grzeschik@pengutronix.de>
 <20181019105439.27796-2-m.grzeschik@pengutronix.de>
 <1539946939.3688.58.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="52puqmqenwrgio5w"
Content-Disposition: inline
In-Reply-To: <1539946939.3688.58.camel@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:58:31 up 147 days, 22:07, 120 users,  load average: 1.12, 0.48,
 0.24
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--52puqmqenwrgio5w
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 19, 2018 at 01:02:19PM +0200, Lucas Stach wrote:
> Am Freitag, den 19.10.2018, 12:54 +0200 schrieb Michael Grzeschik:
> > > From: Steven Toth <stoth@kernellabs.com>
> >=20
> > This patch is based on the work of Steven Toth. He reverse engineered
> > the driver by tracing the windows driver.
> >=20
> > https://github.com/stoth68000/hdcapm/
> >=20
> > > Signed-off-by: Steven Toth <stoth@kernellabs.com>
> > > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > ---
> > =A0MAINTAINERS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=
=A0=A0=A06 +
> > =A0drivers/media/i2c/Kconfig=A0=A0=A0|=A0=A0=A010 +
> > =A0drivers/media/i2c/Makefile=A0=A0|=A0=A0=A0=A01 +
> > =A0drivers/media/i2c/mst3367.c | 1104 +++++++++++++++++++++++++++++++++=
++
> > =A0include/media/i2c/mst3367.h |=A0=A0=A029 +
> > =A05 files changed, 1150 insertions(+)
> > =A0create mode 100644 drivers/media/i2c/mst3367.c
> > =A0create mode 100644 include/media/i2c/mst3367.h
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 556f902b3766..9c69b7f9b2f9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9787,6 +9787,12 @@ L:	linux-mtd@lists.infradead.org
> > > =A0S:	Maintained
> > > =A0F:	drivers/mtd/devices/docg3*
> > =A0
> > +MT9M032 APTINA SENSOR DRIVER
> > > > +M:	Michael Grzeschik <m.grzeschik@pengutronix.de>
> > > +S:	Maintained
> > > +F:	drivers/media/i2c/mst3367.c
> > > +F:	include/media/i2c/mst3367.h
>=20
> Das sollte nicht in diesem Patch landen, oder?

Yes, I will remove it from the patch and put this into a separate one.

Are there any more suggestions for this series?

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--52puqmqenwrgio5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAlvi4gUACgkQC+njFXoe
LGQucBAAnq8+lGHBzZnkWjFR0QCeBd3mmFzpXmUAULkHQfss6vSBZ/wZmmUlVNNE
zc/0hX1UPfL3BS7Qa9g4olSFdv0mjNqkKA/IAPZwdKhS1l5cVOaM9KBO7+BFlnDs
0NSTvqzncWm7b1nlO64uLWnl40K5ZD+Bd8nF/UKUzIG2BDd5yGdxNAcE8WEkWlp4
y0GnhmFp0B30eByAqraLK0xcXbKYpiObgM35vu91P0mzQuNfgqQ/BVjpC6QFOpwD
jaD1xxm7WQVkhKx5/vvXk9ugrVj5P0zwO5pr75lnX/FgLurBSuQmVyJlaTjhUgwn
0j+TJN9QAs3CEs5XqYo5USpfRZSVuA5yKQA/W9yY4VA04UG9/+qyp2iocSZe802+
PWUZsu46ZFDOJyhgsN5iFwjC671CwJV/9NYdJ2is2PdZNWm+yePgaIVTxgakMawf
bMYOgKM1HpTQBWa/Gtgdc/GJ7JBdoSpyN7i0EIZGBLva7dQHc8tMHOjv0SyN1yOE
evvY7feWDVWtR6mHSscWV1it/0GAn+oPkKtQjCzO3onEd4e6Q1aGsPeVGxP3Tlkf
C7skqS78WxtuGi7DajnBOoMfebLBRg6z2iwMfUGYJcqnvGGPVHJu+tt8XFwWJTQk
SBzUeV5+dRXG4NH1H44c6uny5vzQ8FbgjtblO53Nq45xbjWjXgU=
=uH3G
-----END PGP SIGNATURE-----

--52puqmqenwrgio5w--
