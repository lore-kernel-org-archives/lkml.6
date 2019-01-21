Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB75C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB5F20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfAUNji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:39:38 -0500
Received: from mail.bootlin.com ([62.4.15.54]:54236 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728817AbfAUNjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:39:37 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BECDC207B2; Mon, 21 Jan 2019 14:39:34 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
        by mail.bootlin.com (Postfix) with ESMTPSA id 848C5206A7;
        Mon, 21 Jan 2019 14:39:34 +0100 (CET)
Date:   Mon, 21 Jan 2019 14:39:34 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Sean Paul <sean@poorly.run>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Krzysztof Witos <kwitos@cadence.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Chen-Yu Tsai <wens@csie.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v4 8/9] phy: Add Cadence D-PHY support
Message-ID: <20190121133934.5e3uwk5x6vzno36w@flea>
References: <cover.5d91ef683e3f432342f536e0f2fe239dbcebcb3e.1547026369.git-series.maxime.ripard@bootlin.com>
 <a089ce6aaefe6d2ddf6b17f5558ec7eb0ebf3774.1547026369.git-series.maxime.ripard@bootlin.com>
 <20190117135322.GB114153@art_vandelay>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hzi2fvtnjykoiksc"
Content-Disposition: inline
In-Reply-To: <20190117135322.GB114153@art_vandelay>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hzi2fvtnjykoiksc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Thu, Jan 17, 2019 at 08:53:22AM -0500, Sean Paul wrote:
> On Wed, Jan 09, 2019 at 10:33:25AM +0100, Maxime Ripard wrote:
> > +	opts->wakeup =3D cdns_dphy_get_wakeup_time_ns(dphy) * 1000;
>=20
> This should be "/ 1000" since the units of wakeup is us now (thanks to pa=
tch 2).
> You've made this change in patch 9, so I think it's just a misplaced fixu=
p.

Good catch, this was fixed in patch 9, but it definitely belongs there.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--hzi2fvtnjykoiksc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEXLlgAKCRDj7w1vZxhR
xW+LAP4zEe1z/qdpFjO7LKfIjMbOAWFDH1HPxrfSrGKjD/8GtwEAztE37tEckDJq
RYu3qFgjy6BMgbB4/6tjGMfKoB2b0AI=
=rG2u
-----END PGP SIGNATURE-----

--hzi2fvtnjykoiksc--
