Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07404C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEF5204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBEF5204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeJIOny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:43:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42170 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbeJIOny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:43:54 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 29BD8207A3; Tue,  9 Oct 2018 09:28:19 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id EA96220712;
        Tue,  9 Oct 2018 09:28:08 +0200 (CEST)
Date:   Tue, 9 Oct 2018 09:28:08 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] phy: ocelot-serdes: fix out-of-bounds read
Message-ID: <20181009072808.5eynmktmkgjpi2ho@qschulz>
References: <cover.1539036280.git.gustavo@embeddedor.com>
 <30c1dcb4a8d3707238fcf0a996b9e0bf0a4a7bbc.1539036280.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b4ojgugveeianwqy"
Content-Disposition: inline
In-Reply-To: <30c1dcb4a8d3707238fcf0a996b9e0bf0a4a7bbc.1539036280.git.gustavo@embeddedor.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b4ojgugveeianwqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Tue, Oct 09, 2018 at 12:22:33AM +0200, Gustavo A. R. Silva wrote:
> Currently, there is an out-of-bounds read on array ctrl->phys,
> once variable i reaches the maximum array size of SERDES_MAX
> in the for loop.
>=20
> Fix this by changing the condition in the for loop from
> i <=3D SERDES_MAX to i < SERDES_MAX.
>=20

Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>

Thanks,
Quentin

--b4ojgugveeianwqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlu8WIgACgkQhLiadT7g
8aPENQ//Yku5/atqMQnfPkL9gPlXcwqnKzdLPoqg8STNzSFCL+/Z19M/1EhIQWHG
DqY04THJUqXwNpFeFXeR3Ac1gsZ0juK71c6iDIveL81xuH6CFJyh3zX5iCr4NlBA
h/qpxXc6//3HmnpoEMLZj8LzSwGi2nsfYuXbxgEAbQ8TmTruSaIBYyj41h78uBXk
j3tWNYAZUXX/QkoKCK3S/UmhhM4wqc3vw9CiuUENAwWyq4uC0j+8xBYpMIzoyvWU
gBimIVlNGZx+FefedTmS1AUrXT92QAcaoaT7/g1T2BcnHY2J0kvZy1Wk/1botn5q
C5ywzft5xn7OxJ1WBeoXFz2oHFUA7+hehotqCfWcsJ8vWLQqxpJwzcaVFfo1OPik
taCbiaBdsLugVjr9PIRZ4+4f9sSWCxfNK8sxY6PrNC89hF+BKbGA+YKJgVuK7Y6C
K/s3tpl5uGcIHZ8nvQhWtEJnGnUEGau7GYkQLMfrgC96CRFcPcriRlcVL9M3cXfa
4Ey3NVT8X1p4v8EX7B6l1ItNB/Eo2FhnYY5j+rnxGZnj+UJh6qfUUhkwdxlr09rl
fI9Yx/jwUVdXxw/INJBRx9z6MLvZRPUsAGLfp42VFfj0is1DqKJyb0rRI+ydnwTo
G/n/DLxL6qrP6DF4WEJgqSgSPvgHTM/aZZEuv7I6Jx5eM9Re+w8=
=q13U
-----END PGP SIGNATURE-----

--b4ojgugveeianwqy--
