Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0385FC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD12E20685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD12E20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388800AbeGXVax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:30:53 -0400
Received: from sauhun.de ([88.99.104.3]:59204 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388640AbeGXVaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:30:52 -0400
Received: from localhost (p54B3332A.dip0.t-ipconnect.de [84.179.51.42])
        by pokefinder.org (Postfix) with ESMTPSA id 201CD6377E9;
        Tue, 24 Jul 2018 22:22:41 +0200 (CEST)
Date:   Tue, 24 Jul 2018 22:22:40 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Przemyslaw Gaj <pgaj@cadence.com>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
Message-ID: <20180724202240.ucfvomrwr7at2yhg@ninjato>
References: <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se>
 <20180720101206.tv7nsoanwo5ftnia@ninjato>
 <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
 <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se>
 <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
 <a74a7472-e900-d031-d10b-b12f03ea9ff1@axentia.se>
 <20180720154132.2fwmwpiwtxa73ljf@ninjato>
 <CAK8P3a0+8a9LCyW2WX6gO2Pi3GJa_ofznC07LMHjWmxZ4HaX7Q@mail.gmail.com>
 <20180724155717.aodl6xehacparo7b@katana>
 <CAK8P3a1KU+KMOQ+iqpmsn2MqQpOdH-tiN0tbOmSKeaBs8DMVgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="le7s62ypnh4q3eaa"
Content-Disposition: inline
In-Reply-To: <CAK8P3a1KU+KMOQ+iqpmsn2MqQpOdH-tiN0tbOmSKeaBs8DMVgw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--le7s62ypnh4q3eaa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > My personal use case is debugging. R-Car H2 is great because I can
> > always pinmux this or that I2C IP core to the same set of pins, and in 2
> > out of 4 cases even GPIO bitbang on top of that. So, it is great to
> > compare behaviour, do scopes with the same type of setup, etc...
> > For that, I do runtime switches, but the slaves are not really under
> > real usage.
>=20
> Ok, so runtime here still means it's chosen by an operator (i.e. you),
> not part of regular operation.

Yes.

> I meant multiplexing it through the pinmux framework, with one of the
> two being active at any time. Obviously this makes no sense for
> i3c slaves, but it can be useful if the bus only contains i2c slaves.

Unless Linux is not an I2C slave itself.

> What I meant here was switching the bus between an i2c master and an
> i3c master like you do with the i2c demuxer. Right now, this wouldn't
> work because i2c and i3c use different representations in DT and in
> Linux for the same devices.

I see. Thanks for the clarification.


--le7s62ypnh4q3eaa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltXiowACgkQFA3kzBSg
KbavvRAAgIXQBwW06cIEgeeV3DZcajNU8mBokosxM0p28FycAlRa3LXjRHZlW03/
EcHNHBcOPt9Om+03lVkpJ83NsSKSTtK+oPRiipcjzHtZNnRUe7jSUlt37nc3A+oZ
2J0V/rwjcj8X4q8Ti7y92eQ4c1igU5PyZiK+lfnhsnOh5FlVWJGFRWlQDG+aC/Rf
5SR5hxQrjCdiLRR6Sw1nLDrH5Sn5ilOhkVNoPdXKfVpF8qfhKmG9Rvi6aFIb2xpe
1oH2OZ0yT++wRBUmrrdXi30HqkYVwtFpPYTYN8HmPvvdtGb+rMEUo/XDPeaqf/4L
G1GIMmVzU0FuMT/ZmMR7E7rWZX1EN1G96cfcSht1VmATIyPFZWPCmsThqe3C08/d
/Mb2yuUWwUmmvFLkYZQ4V0ISbJ6bl09VfjmSOfvRzfy/n+UhqMaN9uNbplwtJV1H
PH06SQnGDlfgba3g7y+SXJv7T2H4xRc+a6ortBx3DN+xreC4JlGWF0KrtHT3q6Sn
4B+bWH4pwlVsYcweg6RlGhyZeST9Ct/J9+lZ9sOpFUgfFrSZMo6pxlfIHpBlq35V
S8S+HrMX15UflTFwLMGn65cCXfDOBkHgMh1f1gglTZSiR9h+Lcu1pIJVI6+hmCoO
YQwfCt86rXzSndDbsTraaFE75x3OFzzNdCuJ/68WUwtyfq25qeQ=
=NaDZ
-----END PGP SIGNATURE-----

--le7s62ypnh4q3eaa--
