Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 90F51C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9C4208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C9C4208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936180AbeFOIpz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 04:45:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43064 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933986AbeFOIpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 04:45:54 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 24A9D20862; Fri, 15 Jun 2018 10:45:52 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-37-30.w90-88.abo.wanadoo.fr [90.88.156.30])
        by mail.bootlin.com (Postfix) with ESMTPSA id E2857207B0;
        Fri, 15 Jun 2018 10:45:41 +0200 (CEST)
Date:   Fri, 15 Jun 2018 10:45:42 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     linux-sunxi@googlegroups.com, wens@csie.org, robh+dt@kernel.org,
        airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [linux-sunxi] Re: [PATCH v2 04/27] dt-bindings: display:
 sunxi-drm: Add TCON TOP description
Message-ID: <20180615084542.slp3ma4krrj744do@flea>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
 <20180612200036.21483-5-jernej.skrabec@siol.net>
 <20180613073456.jk72zw4rt4ysjco7@flea>
 <2481282.yoIGH2ksVh@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uehqhgocot3w3pij"
Content-Disposition: inline
In-Reply-To: <2481282.yoIGH2ksVh@jernej-laptop>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uehqhgocot3w3pij
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 06:03:21PM +0200, Jernej =C5=A0krabec wrote:
> > > +Required properties:
> > > +  - compatible: value must be one of:
> > > +    * allwinner,sun8i-r40-tcon-top
> > > +  - reg: base address and size of the memory-mapped region.
> > > +  - clocks: phandle to the clocks feeding the TCON TOP
> > > +    * bus: TCON TOP interface clock
> > > +  - clock-names: clock name mentioned above
> > > +  - resets: phandle to the reset line driving the DRC
> >=20
> > s/DRC/TCON TOP/ ?
>=20
> Yes, copy & paste issue
>=20
> >=20
> > > +    * rst: TCON TOP reset line
> >=20
> > Remaining consistent with the clock name would be great
>=20
> You mean "ahb"? I noticed that most other nodes with reset lines don't ha=
ve a=20
> name associated. Maybe I could just drop it and use first specified reset?

It's called bus in the binding, but yes. And yeah, we can drop the
name as well.

> >=20
> > > +  - reset-names: reset name mentioned above
> > > +  - #clock-cells : must contain 1
> >=20
> > An example would be nice here
>=20
> You mean node example? with ports? In the past, Rob was against examples=
=20
> unless really necessary. Node from R40 DTSI can serve as an example.

Ok.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--uehqhgocot3w3pij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsjfLUACgkQ0rTAlCFN
r3Q+JQ/8C12cz1mDx1+BF4O9IZ2xfHWa/0ZHDDOVTxwRujGMDvmwMT7fUaJJTtl6
dBLUQAyGq/reCzTyHu2LgpduQ4BcGADTybfdOXAa9uED0I0/dfm6YjK4XlOFt8vs
q2KgSWCs0xddgw7/L/KzoN71E9IMv93sEd/f9HAxv6bfysrROJbtB5itaEvT+NcL
VbFd2lb5E6W3FJOxaVsjQFI1wT7fBP1pL3E796oY2ZSJWoiHTXiQ2tbRkfTM1PQz
KPv0XT2RD8A6/x+lUDo6RaQQJpZeFIwcZQJ1V4cJRXJLh20s0XtRga53Bcph2V8O
uRHQ/uPK4nG7ReT17ld6ofFF7PUDqh6ilJEf/RFd2mjVb/ob36iS2JCd2BORuhu+
C6ZX9SO73CSqVPJQmgfMiI9yUZ8WHg4LCletyN97SQijhMPiSE/AD73Xj9XVRaBD
2xVtUW3S7O1CDRambj7HxpfDWzxuShs0leTev46fBuzrHZTmJ4kLd50zSJIr0+cD
MD9ccJdOiK8cF8tDUYJlY81fI9j3ZtoEvbMZv3/yndSfHvm1ops97GGo2oCTGkMO
W6hA78jPMrWd/tDIJHEuWQu5AlTw6ZuZ0elcfHeXIThSS8SeeR52xfvb2s0/w+Wf
NXZdaeqei7Wg3hucgDsPcWt4BXSbkgHAlF7Xx4nOvr/9RHjmyF0=
=74NE
-----END PGP SIGNATURE-----

--uehqhgocot3w3pij--
