Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6442AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0C22086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0C22086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeJLR3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:29:33 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45298 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbeJLR3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:29:33 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1F35A208F4; Fri, 12 Oct 2018 11:57:53 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-7-245.w90-88.abo.wanadoo.fr [90.88.129.245])
        by mail.bootlin.com (Postfix) with ESMTPSA id D9979207BB;
        Fri, 12 Oct 2018 11:57:42 +0200 (CEST)
Date:   Fri, 12 Oct 2018 11:57:43 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
Cc:     Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        David Lechner <david@lechnology.com>,
        Thierry Reding <treding@nvidia.com>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Johan Hovold <johan@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] arm64: new board - Emlid Neutis N5
Message-ID: <20181012095743.llxqyggkhtnsbpaf@flea>
References: <1538745949-13188-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539012044-29998-1-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539012044-29998-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <20181010144957.exrlupoph7ovsmdw@flea>
 <9398571539259289@myt4-929fb874f3f2.qloud-c.yandex.net>
 <2d09d6c0-0404-589d-2c34-da846cff4fb8@suse.de>
 <20181012093523.GA29014@imagebutcher>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iuam3nijsixprzkz"
Content-Disposition: inline
In-Reply-To: <20181012093523.GA29014@imagebutcher>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iuam3nijsixprzkz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 12:35:23PM +0300, Aleksandr Aleksandrov wrote:
> > >> =A0+&uart1 {
> > >> =A0+ pinctrl-names =3D "default";
> > >> =A0+ pinctrl-0 =3D <&uart1_pins>, <&uart1_rts_cts_pins>;
> > >> =A0+ status =3D "okay";
> > >> =A0+};
> > >>
> > >> I guess this is for bluetooth? Have you tested serdev drivers?
> > >>
> > > Yes, bluetooth is connected over uart1.
> > > You mean if I have tested bluetooth stack via serial device?
> >=20
> > Not quite, we're missing a child node within uart1 for a serdev driver.
> > Is there no such driver yet for your Bluetooth chipset, or did you not
> > yet check?
>=20
> Got it. I haven't checked a serdev driver.
>=20
> Maxim, the SoM can't be run without a motherboard. According to your last=
 message
> I don't change dts files, right?

Yep, that works for me.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--iuam3nijsixprzkz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlvAcBYACgkQ0rTAlCFN
r3TNcg/+NznxMtq5R7Vz1MiAerJ0oOjsactYGKpLSOZuM2l0H7HbBJOhyLEUDhw9
97I1K8JIBHwcRhF+ZmIlIT5x2+TG9ovf+WrQG2OgddhYqD7XArMaol4tGSBLUnvu
aZmCFwriAfkRa8p87/OCLvQxXPYAPgbFABNZI0D5DwrTZM4tzQsSSBQDhxwkg/j+
g0LUoHQ2k34qlAoqNYp89BhCAwIrumSm8vn1SANXbijqCXxXerWdiu3aJS3Ze26h
ZIacY3d9bWrWxJmbBvv12Y65JwvcQMBUORLF/20Y8WaNLx+pb7LNoWTiXLgatQYI
PmARM9C/iqPeWqU6rrR/bfuc8Z39fpUkoCXgrL24MFGo4djcwwuKM77qpyMKlNaQ
K+CrJrwjhUH+/RRsETSEN6rQRzctTPmSi6ew20x27J5kJz6UsT1T+yJHKWKjxSYJ
mOS5UnT9+leJCSlm/G8HmAPozKDRAUO3JkV3y7VQgmAwJX47INSw+fZN+CxXvnuF
w8NJPo08A5/mVrlUBIA0ri0s7Rg6s28/FoP91PWfSHbN/Q3r8902HPpfMJnEfElR
H5sxl3nE4GQpJbnEGEcrycPAPQ/BTWe8foQfxF/BudhrnfcI6E5GCw1DxjPi8BEK
51tK9tUWIZBNEdlroKZVpsJetPl69aNlHX3Q/UhcEMkjryg2PfY=
=kUeK
-----END PGP SIGNATURE-----

--iuam3nijsixprzkz--
