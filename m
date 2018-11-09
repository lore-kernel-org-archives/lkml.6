Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C37EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99E520840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99E520840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeKISZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 13:25:48 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36231 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbeKISZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 13:25:48 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F048420798; Fri,  9 Nov 2018 09:46:12 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id BEC7A20787;
        Fri,  9 Nov 2018 09:46:02 +0100 (CET)
Date:   Fri, 9 Nov 2018 09:46:02 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Mark Van den Borre <mark@fosdem.org>,
        Gerry Demaret <gerry@fosdem.org>,
        Luc Verhaegen <libv@skynet.be>
Subject: Re: [PATCH v3 0/8] BL035-RGB-002 3.5" LCD sunxi DRM support
Message-ID: <20181109084602.ujftkglypwk2tbsi@flea>
References: <20181107181843.27628-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xb4qu2mlk5grg25q"
Content-Disposition: inline
In-Reply-To: <20181107181843.27628-1-contact@paulk.fr>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xb4qu2mlk5grg25q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2018 at 07:18:35PM +0100, Paul Kocialkowski wrote:
> The series adds support for the BL035-RGB-002 LCD panel and the required
> device-tree bindings for using it on the BananaPi M1.
>=20
> Only the changes related to the DRM driver and the panel are submitted
> for merge, which does not include the two final commits.

I pushed the first three patches, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--xb4qu2mlk5grg25q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+VJSgAKCRDj7w1vZxhR
xU3aAQC+4qB+sHYa99WoJ6onHnCPRcbWsnnj0o5pyxevgs4PowD9G6IkUYjhhsn5
arBQFmmZ8ZPXEzIdRUf7QU9PDjCamQw=
=PkbH
-----END PGP SIGNATURE-----

--xb4qu2mlk5grg25q--
