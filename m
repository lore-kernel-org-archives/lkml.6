Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C140FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6671E208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391172AbfAOWny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 17:43:54 -0500
Received: from sauhun.de ([88.99.104.3]:54076 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729846AbfAOWnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 17:43:53 -0500
Received: from localhost (p54B332B9.dip0.t-ipconnect.de [84.179.50.185])
        by pokefinder.org (Postfix) with ESMTPSA id 2384B2C9D2D;
        Tue, 15 Jan 2019 23:43:52 +0100 (CET)
Date:   Tue, 15 Jan 2019 23:43:51 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     kbuild test robot <lkp@intel.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        kbuild-all@01.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, me@jue.yt,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        Juergen Fitschen <jfi@ssv-embedded.de>
Subject: Re: [PATCH v4 3/3] i2c: at91: added slave mode support
Message-ID: <20190115224351.rtbqaqro5pl3dvov@ninjato>
References: <20181227151311.20107-4-ludovic.desroches@microchip.com>
 <201901050345.JaEWLmjh%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k747szf62j7ndfj6"
Content-Disposition: inline
In-Reply-To: <201901050345.JaEWLmjh%fengguang.wu@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k747szf62j7ndfj6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> All errors (new ones prefixed by >>):
>=20
> >> ERROR: "at91_init_twi_bus_slave" [drivers/i2c/busses/i2c-at91.ko] unde=
fined!
> >> ERROR: "at91_twi_probe_slave" [drivers/i2c/busses/i2c-at91.ko] undefin=
ed!

That needs to be fixed. Rest looks good to me!


--k747szf62j7ndfj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlw+YicACgkQFA3kzBSg
KbbCRw/9GyKnSdo2hH8DwxrBSUXFUdteS1XqDLnIl1XxXov0X/hBo7cy8ahSyaH1
ZtoYoB8kaRpi2DzgJzXslSWvy4YOan5wFyYErgxEh03EXFDWns0JoBee8HVU8Bax
vMln99pOTSa1wujN1zKcrdp6S4m4dPxfe4Xedr0XC5W7waQlL1QOdak+q/ap7i1x
DkklfHKCwHN+Z4erOe6IxpDHrhUOKDladtdASn/Te1zZPLKQrGfYtwyHx+7+IXBj
qNzqo0u+q5depphDBMLJmWLMufkQMRTk+MUeULSE53rUOUFR5YsFIDlbywa0zdUb
OG5tLyDQjgU7YOMxpqD1/I3phTZyPdRegnDrfAI0uC/8a1oY89GAvvf+VHgZ5CEC
bIkZy9fymqfckw3v0CxPaMsObNyM1ac/DdYOKRcsC0HIpcI4vJnN48d4Cqp6+PCx
ujwQwgBU1FmlBakGxZoJVxSb327Qo7F7twqECvgYHOrTMkzeM3atgownEQxJuUrx
KGYUi1XyN8StZtzY7ywiU9qbQpEb2mbGcjhy3qo8OfbxdAR6sRmyLL1vVknCYN3P
NaOVK+OyPidbSJr5EEsYY1PoJxrU3tjl0xtDbb+GUEzUecjoAZlWkhil5LkRGylC
yThBrkrbqblwHD67UtiB6cDoOCtaoyTVHU5KytR04CQyJP5Qs7M=
=2yQK
-----END PGP SIGNATURE-----

--k747szf62j7ndfj6--
