Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F78C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFBF20854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFBF20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbeIKOLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:11:08 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40929 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbeIKOLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:11:08 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B869B20703; Tue, 11 Sep 2018 11:12:43 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8412E2000E;
        Tue, 11 Sep 2018 11:12:33 +0200 (CEST)
Date:   Tue, 11 Sep 2018 11:12:32 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Philipp Rossak <embed3d@gmail.com>, lee.jones@linaro.org,
        mark.rutland@arm.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 14/30] dt-bindings: update the Allwinner GPADC device
 tree binding for H3 & A83T
Message-ID: <20180911091232.2ozypemfam5kayef@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-15-embed3d@gmail.com>
 <20180831084854.q2uh63pw5vprqlzt@flea>
 <20180910194424.GA21461@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ttcwp2nzxxraldfm"
Content-Disposition: inline
In-Reply-To: <20180910194424.GA21461@bogus>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ttcwp2nzxxraldfm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 10, 2018 at 02:44:24PM -0500, Rob Herring wrote:
> On Fri, Aug 31, 2018 at 10:48:54AM +0200, Maxime Ripard wrote:
> > On Thu, Aug 30, 2018 at 05:45:02PM +0200, Philipp Rossak wrote:
> > > Allwinner H3 features a thermal sensor like the one in A33, but has i=
ts
> > > register re-arranged, the clock divider moved to CCU (originally the
> > > clock divider is in ADC) and added a pair of bus clock and reset.
> > >=20
> > > Allwinner A83T features a thermal sensor similar to the H3, the ths c=
lock,
> > > the bus clock and the reset was removed from the CCU. The THS in A83T
> > > has a clock that is directly connected and runs with 24 MHz.
> > >=20
> > > Update the binding document to cover H3 and A83T.
> > >=20
> > > Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> >=20
> > You probably want to have a look at:
> > https://www.spinics.net/lists/arm-kernel/msg670167.html
>=20
> Well, which is it? An ADC or thermal sensor?

It's both actually. This IP used to be called GPADC, and had a thermal
sensor + some ADC channels. The design evolved across several
generations of SoCs to drop the ADC channels and be used only to have
thermal sensors.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ttcwp2nzxxraldfm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluXhv8ACgkQ0rTAlCFN
r3RlLRAAhGrKBGOaPU36B9oHrqrOOdRRxLiK2BhzFdgWj8CadI2C62PxhwyTtyCZ
O0Qbiuu3UEQdvK2ymSWeRR3sGEpdbNF0M9A44WMWn3+r9EchrryDNwpPHYQtE3N1
eN3XFVOY4kEfVhwGrKLBPjECUoTORj8UAd1LUSkfubSqH26T77YZujRg5KHzDXmY
leV5rs8/WfXLKJzcAiIqjDQaP/K71kEizka8Xdqt7nOn2hsr1oV/y1xxuPlsKPHv
/ULINf1+EqR1u/a36WGICvdpMpgM4flKbp7cZEWIOIdKcoI7q23Szi5+3y129LdT
0KOTGS+ywJxUTIHtduBs7gV0zOq4RCnqPjweXk5yOjjn8baF3OSHiv4m6zEJ9Wpt
xB1HKbmcRdMyi5ttzAxkqWv4dowJywkkSD8K4OviRoixe944tFXW9o1GBogWosER
i3wuMgj6A+HK5qDRZHmJMw+/W5UprUPxpzjNqNv8/ge09W4AB6mqLZ8HCgE/5OI8
61XGlcNKcww/1l259vSgbD94I0ITrnrdcXmSuTOaHFwJLN0F8/cE5fIG7QCaeyeI
7OfEefWqhLFpWLQYtqAZnF8dQaHmN+1X2//IBhWdMbLxOfyBGkHEB9jl3mgh8Wgz
+pQ40R+mn+TrqHCi6xu2Sn11dfz6j4DNWAlEMpTMyauE+THkuuk=
=AUym
-----END PGP SIGNATURE-----

--ttcwp2nzxxraldfm--
