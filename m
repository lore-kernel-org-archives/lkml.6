Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE6DC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A73A208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A73A208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbeLNNBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:01:07 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55514 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729641AbeLNNBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:01:07 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C0965207B8; Fri, 14 Dec 2018 14:01:04 +0100 (CET)
Received: from qschulz (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id 87A482074D;
        Fri, 14 Dec 2018 14:01:04 +0100 (CET)
Date:   Fri, 14 Dec 2018 14:01:04 +0100
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Josh Boyer <jwboyer@kernel.org>
Cc:     thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        antoine.tenart@bootlin.com, allan.nielsen@microchip.com,
        steen.hegelund@microchip.com,
        Linux Firmware <linux-firmware@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL firmware] microchip: add firmware for VSC8574 and
 VSC8584 Ethernet PHYs
Message-ID: <20181214130103.hfojveu346ogrc6k@qschulz>
References: <20181206103348.m7dtld3hccuhfeuf@qschulz>
 <CA+5PVA5NViTUECEfrw3SqjUUx=qSoQJr6EQvvZ_Liv+B+aYr6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dzjir3orkhpssdfg"
Content-Disposition: inline
In-Reply-To: <CA+5PVA5NViTUECEfrw3SqjUUx=qSoQJr6EQvvZ_Liv+B+aYr6Q@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dzjir3orkhpssdfg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Josh,

On Fri, Dec 14, 2018 at 07:57:37AM -0500, Josh Boyer wrote:
> On Thu, Dec 6, 2018 at 5:34 AM Quentin Schulz
> <quentin.schulz@bootlin.com> wrote:
> >
> > Hi all,
> >
> > Both VSC8574 and VSC8584 Ethernet PHYs require a firmware patch to be
> > applied before making use of them.
> >
> > This adds the firmware for each of them.
> >
> > The Linux driver using the firmwares is already in Torvalds' tree:
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3Da5afc1678044a3eea48f0295ae7bc2b13d59b128
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D00d70d8e0e7811ed8acba24e04b9f193c3b84beb
> >
> > Thanks,
> > Quentin
> >
> > The following changes since commit 1baa34868b2c0a004dc595b20678145e3fff=
83e7:
> >
> >   Merge branch 'nxp_mc' of https://github.com/NXP/linux-firmware (2018-=
10-26 08:13:19 -0400)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/QSchulz/linux-firmware MSCC-PHYs
> >
> > for you to fetch changes up to 57d49d580af5c67d7f725dda75aa71cb94505514:
> >
> >   microchip: add firmware for VSC8574 and VSC8584 Ethernet PHYs (2018-1=
2-06 11:02:51 +0100)
> >
> > ----------------------------------------------------------------
> > Quentin Schulz (1):
> >       microchip: add firmware for VSC8574 and VSC8584 Ethernet PHYs
> >
> >  LICENCE.microchip                            |  40 +++++++++++++++++++=
+++++++++++++++++++++
> >  WHENCE                                       |   9 +++++++++
> >  microchip/mscc_vsc8574_revb_int8051_29e8.bin | Bin 0 -> 1655 bytes
> >  microchip/mscc_vsc8584_revb_int8051_fb48.bin | Bin 0 -> 92 bytes
> >  4 files changed, 49 insertions(+)
> >  create mode 100644 LICENCE.microchip
> >  create mode 100644 microchip/mscc_vsc8574_revb_int8051_29e8.bin
> >  create mode 100644 microchip/mscc_vsc8584_revb_int8051_fb48.bin
>=20
> Pulled and pushed out.
>=20

Thank you!

Quentin

--dzjir3orkhpssdfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlwTqY8ACgkQhLiadT7g
8aMX7A//XygYvOFlWBx2V/D2pcschuiVIDIdZLe8K2X9IzG2rjICfxIskXmYsoIp
yQ7em36wwN6TEXTRlSn/kCSPg855ou7It1P4xl9O44KsCrIU4g+X4aLqQg3C3S+5
ly5TH5VwZbLump/irsyMm8pVFosCrgdFLkOr+Fpwov78nsrId75GgSGtd2OTEweJ
skrOtflbwy7Y6ILxrw3MgPTOi71KAzmE1qAUAifHx0nQJ5oyk118qMYsOV+kJnfl
ziOFbPBHPt7xYqVzKXjt5cA/2SS39Xe7kNIXpwdg0ns/U9brtVOGGr1LKC4+iiba
O0SS3TgdFZsYdgsc4d9Ieg2ReSy6ajglPecfqkTxQhQ/ZU9Y8nLmatQCO1gfbrHW
RUZZAnQObexynOUw0s2HXGbvbccVuui72l17aL+0RfrkXrf3xfzWufyqOkV2aNF0
DyXL7J4NHlOD9jNn3VbSfm40MppaUdxD5o2chPIvzlxQK3/xGArQsYD7ztsWNWYB
LbE3yl/VYnSZVutsIzveAp1JHGZEVQhilo3gyh5cyb24IkXa2OjGGqnyLn/ziZn6
TXK4XFTWe7O/fZ87IqWas/v03jg+BEBBsOgtqj1SE9PK09nIh+15ByPDLGaCMzVp
CGW+d6DR709Qfhhlj/V1WRXqb4uC+CYgXUhPjv2uIUm27vSQYrU=
=RNXz
-----END PGP SIGNATURE-----

--dzjir3orkhpssdfg--
