Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D401CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8394420870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8394420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbeGaP4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:56:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39671 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729762AbeGaP4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:56:55 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A80A020789; Tue, 31 Jul 2018 16:16:21 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id 78FAC20731;
        Tue, 31 Jul 2018 16:16:21 +0200 (CEST)
Date:   Tue, 31 Jul 2018 16:16:22 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Diego Rondini <diego.rondini@kynetics.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v2] ARM: dts: sun8i: Add initial Orangepi Zero Plus 2 H3
 support
Message-ID: <20180731141622.d3hvpfc5h74pwtgm@flea>
References: <20180727125739.22871-1-diego.rondini@kynetics.com>
 <20180730115223.14161-1-diego.rondini@kynetics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tomexo5ozpxwvilj"
Content-Disposition: inline
In-Reply-To: <20180730115223.14161-1-diego.rondini@kynetics.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tomexo5ozpxwvilj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Mon, Jul 30, 2018 at 01:52:23PM +0200, Diego Rondini wrote:
> +&uart1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&uart1_pins>, <&uart1_rts_cts_pins>;
> +	status =3D "okay";
> +};

Like I said in the mail from a minute ago, we either want the serdev
node, or no BT node at all and leave it for later.

The rest looks fine, thanks!
maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--tomexo5ozpxwvilj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltgbzUACgkQ0rTAlCFN
r3SiUhAAmFMRW5ZtBQc4rZvlJ+gU0LDsOw51gXoW/hIrynh6EWCepO1h41bKOTYW
yID8gofBzwYcEZEXl7DNBvepYOYhIuNfVu3Q/6x//v4BnSPUjPpdNOw2UubJGrfW
8JcAO558Vgt09GLtO0VqpF2pB60UhTTXj+lwRPYGfHxgk6sTKTwyUzQXVUBpS95q
hOkyb/LQ7fx1HnGAVkn7OJvOSKH0OYcMW3hf8qeCj3At0DktirEncE2+NaFbIwPf
H9foK10QKVJzNhP5CbWFrVjUE93vQuXz7XUKLIDjWcYlipUOMzBrPQE5+zMtj2i7
/+Nb0cRZp3NyWCIbzWmxDXzFlA9Qr4Xj1tc0iZ8F6QRDcEAKp1u49ve6pdFL91hd
8v2yTVmRExqZiTYbNMcpTIypDJ/XApYiLexlXq+F5AeHPb6Ux1S5uM7XMleATDS/
PSgYgI3uZAA15aK5m5hxDAdhmBkW/mescYChuxQe6u6NwKhHceoUkigOPfYzFqaZ
FV/pVLmQ1m+oDXu5zVhrmUDZWnv80wKH0awWh7okLPvvHN7CktP9t0gZj93o1Ifb
bvJITbEcdedBK3+bulXDy2RqAtyaz6asXpp51xXA0x6TQUMasaJLc5AZ11E0/zmM
xpfAOOh12VE+JqpQvynvCB6iBBvsyRwY53McTkU2Qh/ZZNTFy7o=
=fpso
-----END PGP SIGNATURE-----

--tomexo5ozpxwvilj--
