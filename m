Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61425C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0A121738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbfBSXnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:43:22 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45514 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfBSXnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:43:21 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 0851827FF96
Received: by earth.universe (Postfix, from userid 1000)
        id C09743C08DD; Wed, 20 Feb 2019 00:43:17 +0100 (CET)
Date:   Wed, 20 Feb 2019 00:43:17 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] power: reset: at91-reset: add support for sam9x60
 SoC
Message-ID: <20190219234317.2oyp3ktqp3cikh5l@earth.universe>
References: <20190206181221.27914-1-nicolas.ferre@microchip.com>
 <20190206181221.27914-3-nicolas.ferre@microchip.com>
 <20190208152435.GC23062@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tkplu3agw26zk46b"
Content-Disposition: inline
In-Reply-To: <20190208152435.GC23062@piout.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tkplu3agw26zk46b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 08, 2019 at 04:24:35PM +0100, Alexandre Belloni wrote:
> On 06/02/2019 19:12:21+0100, Nicolas Ferre wrote:
> > Add support for additional reset causes and the proper compatibility
> > string for sam9x60 SoC. The restart function is the same as the samx7.
> >=20
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> > Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> > ---
> > v2: split series and collect tag
> >=20
> > Sebastian,
> > I add your Acked-by tag here but as I would like that you take the 3 pa=
tches on
> > your tree now, I let you modify it on your side. I'm expecting Alexandr=
e or
> > Ludovic to have a look as well.
> >=20
>=20
> Sebastian, please take this series through your tree. Thanks!

All right. I just merged them!

-- Sebastian

--tkplu3agw26zk46b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxslJIACgkQ2O7X88g7
+ppA5A/+IgJmgk73r39b7sVQDIRJzLpLKH/r6ioaFSbPCcC4owKjc0U4O0V+peRz
tZfwhfjeARci7EwVfrpmm9cXcoAtQ7A8uLrDjK/30zNZ6bIj/LymFzaF9YbuFo4P
A6N/7HfGPSMjc6a0V09jYWkQ7nHuvdoxocr4TKDg8JREAZVdih4gKtUoWnc26iQQ
gjWPx/yo4KAzHi9BbknO7z1LLxS4wmfjWlvLZTLJ6gv7oSEL48dM/KVsLXN5hWzn
vvpeHgbLl87DWRxFNHLjhO7IDPfVh01lGWnThvqP+1+O/qjCq6w0QPvVbSU7ERPj
qsyKE8ImbXOg8TBVswEord1chbOmCDbawL76vlOq7w1GN2B8Psedr/uu2vV+hS1c
wvSvIEL8f5m8E2OsyfssRjbtJqS+rWHcTuucHdRZa/xY3M+/OscVX8dQ3FLgB9bQ
2+V7AvAR7c8OHiXGF0nZZ4AHAwdb3XbkL/BUiD4+3ko3mpIHwId/EJXRCUlMPdCw
0bGzo9IQSJx50FzIA/3s1Oih1nBto9Gr4qidCD8clRIMvbsyesDiiRgYUl+MqMTh
RQd43y5CebvIchrYvIuM7xPnCHlwbb+7UM2wfHEaRMpoVVntr5HJcgaUlFRWavRs
icJF/h7BInttqAm0OFCo6UoP4wyJvHXWOrNBxQ21EPjD8EqzO18=
=oRbw
-----END PGP SIGNATURE-----

--tkplu3agw26zk46b--
