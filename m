Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DE5C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4282073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4282073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeIELnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:43:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34256 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbeIELnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:43:25 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 592B020756; Wed,  5 Sep 2018 09:14:36 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 30754206DE;
        Wed,  5 Sep 2018 09:14:36 +0200 (CEST)
Date:   Wed, 5 Sep 2018 09:14:35 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/3] dt-bindings: change the A64 HDMI PHY binding to R40
Message-ID: <20180905071435.lgsogpzmh5nw6bcy@flea>
References: <20180903133434.58188-1-icenowy@aosc.io>
 <20180903133434.58188-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a6njpttkpajmgw7j"
Content-Disposition: inline
In-Reply-To: <20180903133434.58188-2-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a6njpttkpajmgw7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2018 at 09:34:32PM +0800, Icenowy Zheng wrote:
> By experiment, the A64 HDMi PHY doesn't support the PLL-VIDEO mux
> introduced in R40, although it has two PLL-VIDEOs.
>=20
> Change the A64 HDMI PHY binding to R40 one.
>=20
> This binding is introduced in v4.19, which is still in RC stage, so we
> have change to fix it.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

That doesn't make much sense. The A64 doesn't have any particular
reason to behave like the R40, and the R40 can definitely use a
different compatible if it has a different behaviour. But I don't see
*why* the A64 not behaving like the R40 is a justification to remove
the A64 compatible. Especially when the R40 was released later.

Add a new compatible, and leave the A64 compatible alone.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--a6njpttkpajmgw7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluPgloACgkQ0rTAlCFN
r3SwXw/9HqVu3EL1DDbKcfZUs68DxEvIDkd5f/UsJ2TtfNbII1yIBHI2g6V40C6E
BoAnymq9HT+4GgIDGqihj/B4jzoSgPKAkEtGwfBPgFja28x/X2LHdrnBj+V71Kvn
95NO8+SPVvyfToHVthat2Q8H+9nHaeeDAZ8FZLMpDy8FOqubSCTrxxjDOri8uaa9
p2JCXM0LO1eF7NgeyTYkEE/53VxxBWuQwsTVP+/4zy+6w+dsv1ZnKRfusdYwrqAa
egy35EsYM3oJYy/n3TBJQiolLtLupjKh289bTb+tXhmScABeEsr3Q3e8SX4oedFi
fO6EKgIM1BOTZcmvDDH0QHIya5QMin6O7dVknNOWMrBnW3ffUiFDa1N+sGK4sEs4
zM+8uIwleqKhjIDC0wt+eBQOZInjZdUaHymMWKMQuqb7VG8IIMXC4fMQ9MufjBOJ
GtZgzv4vKAk2aDzk8PioEyUABJEDsIFAKI/9vg0iIN0cvyKTUhBBBTCIsJ/efhEw
F8kD9go3Wquh/DQn2trys3HDexnMS8cB4KfsS4x+gJjopfdZoK7ZMaCgomPElM4d
exxNBLF9kkqmVLvHCRFfX0OQe7FdpFRJpuYl05k0/FMVNWLOijNiPJ3f4kjFchSP
ZM4yq9rjVm8ydmzSK1joSm7jT0ejZhvrb18MnFUw4sD+eJ3mtDA=
=qcKI
-----END PGP SIGNATURE-----

--a6njpttkpajmgw7j--
