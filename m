Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7334ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6734920850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6734920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbeGRQCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:02:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57897 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730735AbeGRQCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:02:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CADA3207E8; Wed, 18 Jul 2018 17:23:41 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id A0A6820766;
        Wed, 18 Jul 2018 17:23:41 +0200 (CEST)
Date:   Wed, 18 Jul 2018 17:23:41 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2] drm/sun4i: sun4i: Introduce a quirk for lowest plane
 alpha support
Message-ID: <20180718152341.zr32w5cjtpfec4xe@flea>
References: <20180718092948.15334-1-paul.kocialkowski@bootlin.com>
 <76279f0a265bfbe509074fcff3156a437e7091dd.camel@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wflxnniappgthqoh"
Content-Disposition: inline
In-Reply-To: <76279f0a265bfbe509074fcff3156a437e7091dd.camel@bootlin.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wflxnniappgthqoh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 18, 2018 at 11:35:23AM +0200, Paul Kocialkowski wrote:
> On Wed, 2018-07-18 at 11:29 +0200, Paul Kocialkowski wrote:
> > Not all sunxi platforms with the first version of the Display Engine
> > support an alpha component on the plane with the lowest z position
> > (as in: lowest z-pos), that gets blended with the background color.
> >=20
> > In particular, the A13 is known to have this limitation. However, it was
> > recently discovered that the A20 and A33 are capable of having alpha on
> > their lowest plane.
> >=20
> > Thus, this introduces a specific quirk to indicate such support,
> > per-platform. Since this was not tested on sun4i and sun6i platforms, a
> > conservative approach is kept and this feature is not supported.
>=20
> Woops, I forgot to include PATCH 1/2 from v1, which did not change.
>=20
> Would it be preferable for me to send v2 again (and maybe call it v3)
> for convenience?

Yeah, resend it, and call it v2 resend (explaining why a resend was
needed).

Maxime


--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--wflxnniappgthqoh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltPW3wACgkQ0rTAlCFN
r3RhMQ//WHLtA5QpRkA+v3plxZ36kfQoi0vDYSymF8DbL4PRNle1LaVTEgV1co8S
1+Hyr2Y4CsE4zQ3aZXUsbkurXTFeXSW1d9zk2083a1qB71159BDtfBNTZ4mhBz0q
hFNBolQPT8TdRVqN2EBZ29l0ZoKYmfm6630A4P2yTctv5rtc1lPTgLHCwpRjYm9N
OO3TljS49zLv9S0bqQdl4CMAHBXtw6WK9500DyaFQH0xJ06cq2y5Gc+0OPjwn5Cy
25Sa5TlOQRZA9vR8IPP7cjgQ+Trdu4cEECGM3UahiWXl4Jd2IarnLWLQWPg0zqJN
DAB3YmCoyRcnA8Mp61Gr8YE/PmdO4MT0hrI1KfpHZvpel5Lf4ofhGPKpV4UqU86X
nsJAtmGIYa4EegpLZVxvcnzcKW2IHe7etX4f6OBGPJNdtf1jF5F44+BspdLd8fAD
1KjXHV6KWyRS0Wi7/1cQFMYkcWWRZAt4PgNqRmiwjyIyju0jsi6k6PlJ7670JDSw
e3l+yL4p9Q/MlZTqirjvSzaaekMNqUWoJ2hLXTT/45+Z21pbx7W1huBQJC1uWGho
paL9epELu+2PNxTwqCTu5/bRAdaeVNGc2Bz5qBc3d6FLJSIHFG5093WfvhclJU+u
/tnUHUVCrqNqiKcwhSrYY4t7gxE5RoBm28et89WPrqz0bHGCTHI=
=8SKu
-----END PGP SIGNATURE-----

--wflxnniappgthqoh--
