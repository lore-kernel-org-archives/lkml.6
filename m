Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E84FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF342085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF342085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbeKGX4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:56:31 -0500
Received: from leonov.paulk.fr ([185.233.101.22]:48710 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727627AbeKGX4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:56:30 -0500
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 66602BFE9C;
        Wed,  7 Nov 2018 15:25:54 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id BB4CFC1057; Wed,  7 Nov 2018 15:25:53 +0100 (CET)
Received: from collins (unknown [192.168.1.1])
        by gagarine.paulk.fr (Postfix) with ESMTPSA id 4E6E6C02F6;
        Wed,  7 Nov 2018 15:25:46 +0100 (CET)
Message-ID: <a4bf7684b456956cfc25699a8d13edc165b33566.camel@paulk.fr>
Subject: Re: [PATCH v2 3/7] dt-bindings: Add vendor prefix for LeMaker
From:   Paul Kocialkowski <contact@paulk.fr>
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com
Date:   Wed, 07 Nov 2018 15:26:31 +0100
In-Reply-To: <20181105220802.GA21348@bogus>
References: <20181101200045.6078-1-contact@paulk.fr>
         <20181101200045.6078-4-contact@paulk.fr> <20181105220802.GA21348@bogus>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-G39TMI/WFfQedA/LP2wP"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-G39TMI/WFfQedA/LP2wP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le lundi 05 novembre 2018 =C3=A0 16:08 -0600, Rob Herring a =C3=A9crit :
> On Thu, Nov 01, 2018 at 09:00:41PM +0100, Paul Kocialkowski wrote:
> > This introduces a new device-tree binding vendor prefix for Shenzhen
> > LeMaker Technology Co., Ltd.
>=20
> Would be nice to say this is already in use, but wasn't documented.

Oh right, it is indeed already used by a few devices.

> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> >  1 file changed, 1 insertion(+)
>=20
> In any case,
>=20
> Reviewed-by: Rob Hering <robh@kernel.org>

I'll change that in v3 and include your Reviewed-by.

Cheers,

Paul

--=20
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/

--=-G39TMI/WFfQedA/LP2wP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlvi9hcACgkQhP3B6o/u
lQz9Tw//RwW2l8dkD5hFDjw48Xl7PJHhMuLONZ+t7XQJB50egll3ltTHbjo57XgJ
irSCYblnSPD4KXKXAhMuSHUW0Sr101eRN44hyH3X/w93RkNXiO9z1hq4/XDGjFq4
09WAMZO2TLkY2l6+fQfCJMGAwAVrJEGLRxV1dKcJtt/u2dgPN53HmA7t4yr1DLiY
4dDej2FygSpkQ/rXzYVQtnFpxS+EHi6DJNjrKXWchWVu2mN5geMCHY+OLfXuyNmw
vb/oqQgHCSnPKqVEgohl/SkYsM7NDnM+CFyxUMOgkE/OIGReZh9zq5l0205+cd6h
sFDhhpxDVJljljErkCgDkjdcoA3AUSS/MEwe+T1ATwswsMLkUCqBedFW3O8rRTuu
qzMMaGFBRtFxxhcLnGOAUuvxJhcKhzwOPKzvWLgkHNR5EzdHnh7+MuC2aErTKbB3
mAsvwPt3YO2SSXn6TM/cXROXyCovvI0lnu2iNUUSTr2xdgGyrv+jr30OjgsVB/6k
V8x0s5wle3JVxdkbZF8+ds5D9RFD2Y1nu0nHCtNyXgtLoULUaKnNDrrPBNWsUQU0
wXN2NIjiIa2sae4WB+tfpJx0wocX0zkiLv3ati7BYxqfhUMiWHvCQvVwXRMhWh5Q
VT1tuYF6dIRhiZUiVo77p8HHeZvQgr0gjOzc4c5G8WOlzRLaCvg=
=Lx5p
-----END PGP SIGNATURE-----

--=-G39TMI/WFfQedA/LP2wP--

