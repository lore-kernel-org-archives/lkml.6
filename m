Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4E4C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34042086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfBHPsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:48:00 -0500
Received: from mout.gmx.net ([212.227.17.20]:41243 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfBHPr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:47:59 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBaDy-1h0LZY010Y-00AT5t; Fri, 08
 Feb 2019 16:47:50 +0100
Date:   Fri, 8 Feb 2019 16:47:48 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Dong Aisheng <dong.aisheng@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: pinctrl: Document the i.MX50 IOMUXC binding
Message-ID: <20190208154748.GA2061@latitude>
References: <20190129165530.7606-1-j.neuschaefer@gmx.net>
 <CAOMZO5ABy+uDXMhQy95vuY8Yz2a8Wr0Q0+fUq=2Xkm2NSCdQGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <CAOMZO5ABy+uDXMhQy95vuY8Yz2a8Wr0Q0+fUq=2Xkm2NSCdQGQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:M0f1cUdd2uAHfc6mGEWmhUj02JeSZau/k7auzhvnehsIQbe22GP
 do3z+7A/gS4i9MM50hhMHCtdFuN+Nt11SXaIVZZSB5fk3x+dCTDockyFoxgDAR++WxB7nMK
 Y2eO7lDazEE3KPIIEQEH+6ERGdTtn8fnntcar/vhOLW4QiyrmSCaOjlNRjy+zz1n8LRutua
 QhOzE1VoHvFsZ4bLMgsQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OFB4c/fzeHA=:yqxFvLZ5n7RR1azoq083US
 cjoPtHOfEcZrkneZzP8dnkciXtoYGxoYGCm96NhEQO32jr56VGm06XS1eOKHpB6cIcEXZfZf6
 CX46GdK33C2IMFNQR5j6LvIIjCRwOXhYTpbsHimNZlAWpYAFH3q4vETjY6NXaqySOzeEpvkjg
 gvecSqeE/EdM3X5qai6fhVrCpdp7Yg9ytRIj/E1bP5Wx0kluUnjCSDAxAkTfR20hrY2B2Uegv
 7kHxOrHExIWnDfuZnsR3OOcQbA1f73TTZh4zFSMfnbLu1ooqklRmLVtUc4aQxUevVD54ESy+u
 aNnbfMvl1qFnCq/fTXb5/Eghd9xa1ZA1UrVYepRuge13Ex9lTTlvGLA8pWLmPVnSG8E1CsiKN
 KEaYmfnwVSRfaAgnghAiQ8eYvZ82XHcmsOT5VWzYYJXmXcud6Bp9LGsumnW9xdi0RhgNHgY+d
 KzU1hlnrX6NuRJ2Dd8/9MIU6ysAo91N4UoEmpANWbCE/HruxPrTqwPbIJH66QMg9DsRQZHiHl
 JJCI3LjHnPmCgsbKqIImtKSidzTES0RpChM3Z2cFVesg8u5+InDOUGe/p5zlb34LmHh7o/mo9
 YB0ZgiA4eDViSdI2ekT1gs1QIJB4NlQqjaFnMgpIv4wOeQAkAGrmV0cKteM5bNlrPjpvgfUKx
 kJJme8szL51GNaGIomgX4XtOBn6xmg3fZVqyWtScVY8sxzEOhcLYEXAXEUlTyhFehjqM3Lc+n
 Cqs7jTjAVF0ExcZAXMsF9SpR8COLl6jF8MwY5YiyFjM/DXyil/+gRFx8xODvWdNyM0HUDpliN
 PjnCjjVwRHykK10c7YzJwjV9GD4vJ3+nP7wI4d/RqhZHvqYmBbqDnmkBx43UzLrjroadNBYKJ
 tIMCdIfNr5y8Qj417sfr67SY85iCTQoy5zD+TfHZSlCOn9tdx0/j1u6AU/mAQD
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2019 at 09:57:04AM -0200, Fabio Estevam wrote:
> Hi Jonathan,
>=20
> On Tue, Jan 29, 2019 at 2:55 PM Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
> >
> > AFAICS from the i.MX50 Reference Manual, the i.MX50 IOMUXC works the
> > same as the one in i.MX51, so I copied fsl,imx51-pinctrl.txt and changed
> > the text to imx50.
> >
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > Cc: Dong Aisheng <dong.aisheng@linaro.org>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
>=20
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks!

> > +Required properties:
> > +- compatible: "fsl,imx50-iomuxc"
> > +- fsl,pins: two integers array, represents a group of pins mux and con=
fig
> > +  setting. The format is fsl,pins =3D <PIN_FUNC_ID CONFIG>, PIN_FUNC_I=
D is a
> > +  pin working on a specific function, CONFIG is the pad setting value =
like
> > +  pull-up for this pin. Please refer to imx50 datasheet for the valid =
pad
>=20
> Nit: It is the i.MX50 Reference Manual, not its datasheet that
> describes the pad settings values.

Indeed, good catch.

> I noticed that all the bindings say datasheet though, so I will send a
> patch to fix this.

Thanks!


Jonathan Neusch=C3=A4fer

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlxdpJwACgkQCDBEmo7z
X9uHfBAAqJchn+W1yJ7iqKTAb0yWuwNzGIpW7u2RQoY89GyT+YHWfcYm4+v10ph1
KGYdJ6xARGyOZGYS6NTS6kokjST5/aZNND00UXmhnK7T2TFU/G0w/ULkPtjpSgvI
dPTKvssIS6XnxJPO41y6LO+IZOzFk5s5d5osvsvLnzky5DHivkPEYyi3Od+cC5J9
m3u71BOIOPJAdph///p504Skk9LYd0GGgCNXaXfEN4RdZ/6Mtx8M/YLagOaPpU09
EIcqXhln2TWF3rEAFTUtOhbJLdOblmCe1ybEF2RN2dNAbsHZPps0Nusip70aMoDw
EiYR9e/hWB897SIhbRAhofsDw73fvzTzwD4e1R1iigwOkMFLuRkDuhBCebU6QTOz
CHebJ98WQaq5d0z7La91XvLrGGjLQPMcngUKPAYCoFN03HQY8WvxZeMu+J2MVFGQ
hI9teS3o06khZIB/ELOzO0q6zWBbU2Ngl3b9roj/OBjdXitl0fTVwh0lmipsMMz2
IoOdgM4GAtYyCneYin17LHEzMA59ffv43qh8zkOIL2Rz/V3kqy/Omu3OVP2DI7Xv
sA3Kjan12S2KZ5X267/jw7/gU/7dE4ZocBzWD4SH1Fw9E1OPb6QXZB/EOrCaCZGy
n0ZcgB/p+/BpzNgNdzd/6kKyzYhpXhYf3G3X6bZZ22vDXmGDQ1Y=
=oF7H
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
