Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5F3C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7522A21547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7522A21547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390040AbeIUUTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:19:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41723 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbeIUUTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:19:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C0851208F3; Fri, 21 Sep 2018 16:30:00 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-42-80.w90-88.abo.wanadoo.fr [90.88.160.80])
        by mail.bootlin.com (Postfix) with ESMTPSA id 975DE208B0;
        Fri, 21 Sep 2018 16:29:50 +0200 (CEST)
Date:   Fri, 21 Sep 2018 16:29:41 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rodrigo =?utf-8?B?RXh0ZXJja8O2dHRlciBUasOkZGVy?= 
        <rodrigo@tjader.xyz>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: Olimex A64-OLinuXino: fix
 ethernet
Message-ID: <20180921142941.5ymp7ksphgboxrwz@flea>
References: <20180919141938.18791-1-rodrigo@tjader.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vttrmrupjt5ob2dm"
Content-Disposition: inline
In-Reply-To: <20180919141938.18791-1-rodrigo@tjader.xyz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vttrmrupjt5ob2dm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 19, 2018 at 11:19:36AM -0300, Rodrigo Exterck=F6tter Tj=E4der w=
rote:
> Without "allwinner,tx-delay-ps =3D <600>;" on the DTP it can receive pack=
ets
> but not send.
>=20
> Signed-off-by: Rodrigo Exterck=F6tter Tj=E4der <rodrigo@tjader.xyz>

Again, that commit log would be nice if it was a bit more
explicit. What is a DTP? How did you come up with that value? What is
the value used by Allwinner/Olimex, and why did you use another one if
you did?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--vttrmrupjt5ob2dm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlulAFQACgkQ0rTAlCFN
r3QmZA/+Lc8bhiH5aWZXAbd91kWJaxdmHhDLH93kD5TpHZSXVtlRA4in0NYjPyus
tO60+vUYt3VbOWeMxV+C0kDr3WgQoCSuDjWbhoKn8CA9W1jW6XRhUqgjIznLobQj
6Ab6dXEBCRsgpVXeN1rIWJZ0sed2HycZ3fy3IGbgF8CeXEgCQGRbN60wsVHEeSE8
wELOlD4KmNeMzdBkUbjeE/vqVkyNrBvhiMpB/m9iUCZaD/1TCmJLYosIMit85TuB
Sb1Ax93jj8NXx1n20s1UzxqTBTsu7GPylOrrdDRoF4elvZd3b38W0fWAvxwsYXrm
3fAfkcRQDffMzm8r1wjVfqfcw1JOzHHTckB9JssBmNh37nlIPOLIlp/uFG89auIu
WStFgcwwggeQKtSBHQw0XyvqbOk6IY1Eue8T9QYAezwhLYM6Ra4uwX6BzNnNepVK
RKOXGqbh3Hg812jwZEkGlHQw4n3HKI7n8Fw7hZHBxxcOBXax10CZhHVWKCPUiFN6
GRLt2x0oETFscyf+gL57o/qgFHrTfjCA/greRrMXxfC5KB6/kWFQ/uJtZVQueRSq
GELr47eusgVDfRv4jIpvf5TjCGBVxsoIPZaFBXGIj8RX4/EqH57KEtRZEb3DXvJB
5APnyDAJ99pyci7XQjK3h31vYOso9y5nVkOXAa1UKq/K++z4Gxs=
=Czs8
-----END PGP SIGNATURE-----

--vttrmrupjt5ob2dm--
