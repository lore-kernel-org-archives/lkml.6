Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3736EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13D220661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13D220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeHaMkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:40:33 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59503 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727238AbeHaMkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:40:33 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C779F207B1; Fri, 31 Aug 2018 10:34:11 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9779A203EC;
        Fri, 31 Aug 2018 10:34:01 +0200 (CEST)
Date:   Fri, 31 Aug 2018 10:34:00 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Philipp Rossak <embed3d@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        eugen.hristev@microchip.com, rdunlap@infradead.org,
        vilhelm.gray@gmail.com, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, geert+renesas@glider.be,
        lukas@wunner.de, icenowy@aosc.io, arnd@arndb.de,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 07/30] iio: adc: remove mfd_probe & sunwi_irq_init
 function
Message-ID: <20180831083400.fobo2c7w22fspyf4@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-8-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zsi43eonrbj3zyck"
Content-Disposition: inline
In-Reply-To: <20180830154518.29507-8-embed3d@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zsi43eonrbj3zyck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 05:44:55PM +0200, Philipp Rossak wrote:
> In the previous commit we removed the function call, now we remove the
> unused functions.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>

This will create a warning between the two commits, it should be
merged in the previous patch.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zsi43eonrbj3zyck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluI/XcACgkQ0rTAlCFN
r3SVPg//a3pD3PkwWY8TWNBuE+7EddA092ScP5tA6YB1S+22IeoSs+WEHzMqkwzG
zdykFyZ8mWg6fwfhAg+AEbidSmpdTLtEqJwP4vFu9ZjYoZeaqThrpthUwYqKgOZm
buQswAshejCr06GqzCtnidALZD/Tc+u2MbP5+/3wgtlCkcMCyqQj4VJK0jWGkvTe
xI0EdBTCFN0tSHKDxit3EKz/iw9Ixd3eAy7EJBxm8wCFPPWop+4/ivFGbtmU9Umj
KE8sABW25KErtTi9gYI+YjR8JMQIb6/iApnEUl/ZMm4uwxhzoku/1c0TjIy5hDPV
ft3iTjaEjTfA9DCSVewJFM2PwhsICfZxf7hVo8wChod0QIY8RnAVvz+etjaMTJol
GtaREnREOecbkM23pUrVpHMVu4YXVbdkOAQj62YgCl6YqEH4gJyilt6XJ0jGJ0/d
8970rtfWpfEzqdqLQUFbGzFnW8Lpg+iSmiZCXSIChZ1wy590aKrs64EJMKTJ1Vxk
rohBRXenkDumCxDWP8CH1VpE+wskudfVFclU8xPHiv8QmvtEWxHa6CBPuypxyp2N
HamB0eNXq5lDGL03JUQiOu7fJp7KMWDN9Plo3QaI2kw9g3b8GrN/TRYfKkYdmKvg
ATp0ZE7xLcWyZC2Ahu+HgGAPPvS+6VO+nxc55HbIdbs+38aa/Tw=
=cFLB
-----END PGP SIGNATURE-----

--zsi43eonrbj3zyck--
