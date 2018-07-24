Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB49C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EBC20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4EBC20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbeGXRE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:04:29 -0400
Received: from www.zeus03.de ([194.117.254.33]:55464 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388395AbeGXRE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:04:29 -0400
Received: (qmail 24588 invoked from network); 24 Jul 2018 17:57:18 +0200
Received: by mail.zeus03.de with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 24 Jul 2018 17:57:18 +0200
X-UD-Smtp-Session: l3s3148p1@dpAJ0cBxfMAgAwDPW8tnAAId4P/+oMhl
Date:   Tue, 24 Jul 2018 17:57:17 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
Message-ID: <20180724155717.aodl6xehacparo7b@katana>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se>
 <20180720101206.tv7nsoanwo5ftnia@ninjato>
 <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
 <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se>
 <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
 <a74a7472-e900-d031-d10b-b12f03ea9ff1@axentia.se>
 <20180720154132.2fwmwpiwtxa73ljf@ninjato>
 <CAK8P3a0+8a9LCyW2WX6gO2Pi3GJa_ofznC07LMHjWmxZ4HaX7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i6qv4o2lf76sjo7x"
Content-Disposition: inline
In-Reply-To: <CAK8P3a0+8a9LCyW2WX6gO2Pi3GJa_ofznC07LMHjWmxZ4HaX7Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i6qv4o2lf76sjo7x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Renesas R-Car Gen2 has two I2C IP cores. One can do DMA and automatic
> > transfers to the PMIC, the other has I2C slave functionality. One cannot
> > do I2C_SMBUS_QUICK, the other can. And some more kind of quirks.
> > Sometimes you can mux the pins to GPIO, so you have a third option.
> >
> > This setup is the reason the demux driver exists.
>=20
> Have you run into scenarios where you dynamically switch between
> the two masters in order to do different things (on one slave, or
> on multiple slaves), or could you always decide on one of them
> at boot time with that particular chip?

My personal use case is debugging. R-Car H2 is great because I can
always pinmux this or that I2C IP core to the same set of pins, and in 2
out of 4 cases even GPIO bitbang on top of that. So, it is great to
compare behaviour, do scopes with the same type of setup, etc...
For that, I do runtime switches, but the slaves are not really under
real usage.

I have absolutely no idea how $customers use it, sadly.

> I think an SoC design we will likely see is an i3c master multiplexed with
> an i2c master to access one bus. The i2c master can then use clock
> stretching and other things that may not work in the i3c master, and it
> may be used in the absence of proper i3c drivers in the OS.

Multiplexed? Well, as soon you want to use I3C features like IBI, this
is not going to work, right? It will not even work with Linux being an
I2C slave itself. Or do you mean running the I3C and I2C controller
simultaneously using the same wires?

> However, that case cannot be handled with the abstraction in the
> proposed i3c framework, which can only deal with multiple i3c
> standard compliant masters. I'm also not sure if it can be added
> to the i2c-demux-pinctrl driver.

The I2C demuxer maps the whole bus to an i2c_adapter. You cannot select
a master per client.


--i6qv4o2lf76sjo7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltXTF0ACgkQFA3kzBSg
KbYVlg/7Bu8HOA8vNgSwokh1EIbhJ2F5B1TAS9MbdWMQUsvRm3WXDaCsQjjXS1JT
x8YJ3JNpaAd9LpsvvklSu2HFJ8oqRFSvyj4phy6jENzQgVpX99EgKU5opORUrpX/
lftSUltKMSnC97TgT3g4nn3atIau+qQI452/Cnugm10XaFKyeqk3neUtK+Tc0Lhs
RvU+MRc0fB4T4/1MIVEVc7xTXNjMKBnvzEslvP9K3VNrD65Itb2LKsaH3TqHqJkc
9Sn2sfH+6EZoLWvtBC0gvQ0EEd06PjO9UIMY1Kqzz3LgcMVE9BevvFSIOsWTlVtl
EaqHiVBUJf4iiAYCAOIp6OkxXiYbgizk1VUEP9dX4Kmc4zSYWzOalzlP251vKbGI
kvqn1onOHJly6WBvZApkiffqAMVrQ8qZsxRs5AdUz95Y/REjHGTssF67AuGVABnB
OyqhY4FmIEuSPzpQkXgj8d9MKj7ys02GcBIFj2Ho9MwcMNaZpUUZZGCj0zeTAcsi
uckxRSIIEk/PXIPNoT5VMmtLUyOvfU2NLerEHbghZr/v3KM9vq9ACDsxnb/d2h6H
BM1g/NyBqMGOa0Fk+y7maNtQDKYkUeZCNuLbhjMRdGwux+hwLiZdX+gU+WsF7sDM
wRNq7yIVmgb8yv2NGiE+FnUZE6N5sa8lmlgbhPG2PRRMw7s7Y7k=
=+Hcu
-----END PGP SIGNATURE-----

--i6qv4o2lf76sjo7x--
