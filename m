Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ED4C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B557E208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B557E208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732340AbeGKIhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:37:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40368 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbeGKIhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:37:50 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5C65E20739; Wed, 11 Jul 2018 10:34:38 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 31F78206F3;
        Wed, 11 Jul 2018 10:34:38 +0200 (CEST)
Date:   Wed, 11 Jul 2018 10:34:38 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marco Franchi <marco.franchi@nxp.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Smitha T Murthy <smitha.t@samsung.com>,
        Tom Saeger <tom.saeger@oracle.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Benoit Parrot <bparrot@ti.com>,
        Todor Tomov <todor.tomov@linaro.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pawel Osciak <posciak@chromium.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Randy Li <ayaka@soulik.info>
Subject: Re: [PATCH v5 03/22] dt-bindings: sram: sunxi: Introduce new A10
 binding for system-control
Message-ID: <20180711083438.o2nwi3czsm2ku6p6@flea>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
 <20180710080114.31469-4-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6b6xkqqnehiflbtw"
Content-Disposition: inline
In-Reply-To: <20180710080114.31469-4-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6b6xkqqnehiflbtw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 10, 2018 at 10:00:55AM +0200, Paul Kocialkowski wrote:
> Following-up on the introduction of a new binding for the A64, this
> introduces a system-control binding for the A10 as a replacement of
> the sram-controller binding.
>=20
> This change is motivated by consistency with the Allwinner literature,
> that mentions system control over SRAM controller. Moreover, the system
> control block is sometimes used for more than SRAM (e.g. for muxing
> related to the ethernet PHY).
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--6b6xkqqnehiflbtw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltFwR0ACgkQ0rTAlCFN
r3TilQ/9G9dgx0ypcWSh/Xvt1YkGOaD+eqJBtlSeC/qdcKj3Ozrlk0TyA+hfXeHg
svJDrjUFYExxH5CV0Bk2DjNLuFH1tV74cembOuVfi/YXma27TDkyGXRnx2TtOD3b
f8Jbe/aKLR2JUeGQqW/fvqEc71ImhStbRQguGyxdfsU2GemZ9/G5uT1ky+O9DLZE
gD/1p6NSuBhO1or25ZVdyoA/ZBeTzQ0Vum37iqbHn5BDvLChSn9o8abR35W0UfxS
TfICKGejqGdQBD3zF9BNXthpEfDeynvGLw/be/MYAu7XngSYC+2C69Yjmz2MPs1m
+Zod1Mxdev3rFmgxdDXyi2DhYUWY5z+/9yCJgkTJCv2JCGD2h86DLH5e8gJN4SHd
puZYPW4L0On+W+OUc/KQszjiHvnHe4aR20aU9pKTwoGyarpXUlI1t9iGy5QV82AR
B6/IEXWI5Ka5WX0900qccmKROcMJcUFmA4v+Vjed0w/vcxId+pzStzi2ZJZdCRwG
/rZD/hwhQIJDJTLK2inzsV3CjfdFxYafWw7wy7HtHaSfK3rR9DxyuegINff8wzBX
p8AipAlZ0NQZUcArA61WxXzyEUInSJP4pkLU8ys3Hk5frlQhu863VHvBi/RqR48U
jnhIuRONZsTWU0sVW9SPErCoZtbsfcSwjauIy4vPXQaNR6SGT/U=
=Q1/M
-----END PGP SIGNATURE-----

--6b6xkqqnehiflbtw--
