Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4F3C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D58B20857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D58B20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbeGZQlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:41:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35189 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730793AbeGZQlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:41:49 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 377022082B; Thu, 26 Jul 2018 17:24:27 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0B0E0206A6;
        Thu, 26 Jul 2018 17:24:27 +0200 (CEST)
Date:   Thu, 26 Jul 2018 17:24:27 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i: r40/v40: rewrite BPi M2 Berry DTS to
 rebase on M2 Ultra
Message-ID: <20180726152427.cjji4ymwfjifja4q@flea>
References: <20180724163655.61365-1-icenowy@aosc.io>
 <20180726124119.dwne2sncws2p3sdi@flea>
 <BA51039A-02DD-42C2-A7A9-E1B866074CA6@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rzdcwqlnpfqrlwqg"
Content-Disposition: inline
In-Reply-To: <BA51039A-02DD-42C2-A7A9-E1B866074CA6@aosc.io>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rzdcwqlnpfqrlwqg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 26, 2018 at 08:47:34PM +0800, Icenowy Zheng wrote:
>=20
>=20
> =E4=BA=8E 2018=E5=B9=B47=E6=9C=8826=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
8:41:19, Maxime Ripard <maxime.ripard@bootlin.com> =E5=86=99=E5=88=B0:
> >On Wed, Jul 25, 2018 at 12:36:55AM +0800, Icenowy Zheng wrote:
> >> Banana Pi designs the BPi M2 Berry board to be software compatible
> >with
> >> BPi M2 Ultra,
> >
> >Do you have a reference for this?
>=20
> See [1], it says "BPI-M2U and BPI-M2 Berry share the same image".
>=20
> [1] http://www.banana-pi.org/download.html

Debian supports different SoC from different vendor using the same
image, so it's not really a good argument to share the device tree. I
mean, you can even boot an H3 to a shell using an A33 device tree.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--rzdcwqlnpfqrlwqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltZ56oACgkQ0rTAlCFN
r3QygBAAksC5oQgLhyS60oyqCjAVdKvSOxT5nUlK4bDETzsA8Bb02d0w9tIflHPS
kqjgptPYuzahoPYlW2XASy0aE0GmPorGjmrX1fLDatAc67itzMQZ8U/G9wWvhhCH
dgvUX3txiB1WEK658t+Foz/f5yp6y/nnaWJyL73KUvEMqeI2vK97mrQtAfyeaHFw
TYuOWGE9VVciVIoU7b+mjAzOehXJyLWjEj/ZLgqtp0ut3DMo4Whtarpuhb4bdyN8
jYPwCy5AFdNXv2kVyqXLR0+2laKhBu6kL3ZFKvIgcJoTj5P+5kpKWGNz+epBiZQ5
BxOBe9plT5tBAw863rNjH/SufJtrFhzkgrmYnv+03rs0CgyJeNhVNACnsEgleR/S
eStylZVwriHR50k/DFv1EkvelBD2ms85jB4RDna5AiERamqtMSwaO3KZMeIuuvei
Q2aOklpa4LbDm4cLIWcj3ThU6ecEFbT8SVyD3PpHv6OPhS2zmw3h1NFE0pCb++N6
xvHgLXKfgiLMQM4fv2SO6ADt0o6QEmdob7YweAFlWw2PtCLpomfqYdLtI8voxK/x
amsUxZa/byuUIPRHl75fXXFgxeK91sbCA5FVXgHyHvpDdFqXvpr49vUrtDS3XSAz
OaOTS9MY1RNN8eUNGQNpH7Tk9+go67Fq4ZEffM8Ck/QAkggt+zM=
=uBBx
-----END PGP SIGNATURE-----

--rzdcwqlnpfqrlwqg--
