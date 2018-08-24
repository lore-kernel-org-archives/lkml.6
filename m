Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F791C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF68F208B7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF68F208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeHXSdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:33:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53275 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbeHXSdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:33:43 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8840822A2B; Fri, 24 Aug 2018 16:58:41 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5AB5620750;
        Fri, 24 Aug 2018 16:58:41 +0200 (CEST)
Date:   Fri, 24 Aug 2018 16:58:40 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Emmanuel Vadot <manu@bidouilliste.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Emmanuel Vadot <manu@freebsd.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: Add DT bindings documentation for
 Allwinner Thermal Sensor Controller
Message-ID: <20180824145840.isdcg3fr6mw4ntzg@flea>
References: <20180804070355.14857-1-manu@freebsd.org>
 <20180820111755.rzg7l2lznmbpuf2e@flea>
 <CAL_JsqLVQDRH1esAXghfQdxmp+iorWVCArM2qTwjbgmQzmhzQw@mail.gmail.com>
 <20180820140737.xmqhu5ndqzehvkql@flea>
 <20180820162715.49e6d8a469ece983f3c1d288@bidouilliste.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ctw732jamwpz6sc5"
Content-Disposition: inline
In-Reply-To: <20180820162715.49e6d8a469ece983f3c1d288@bidouilliste.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ctw732jamwpz6sc5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 20, 2018 at 04:27:15PM +0200, Emmanuel Vadot wrote:
> On Mon, 20 Aug 2018 16:07:37 +0200
> Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>=20
> > On Mon, Aug 20, 2018 at 07:41:22AM -0600, Rob Herring wrote:
> > > On Mon, Aug 20, 2018 at 5:17 AM Maxime Ripard <maxime.ripard@bootlin.=
com> wrote:
> > > >
> > > > On Sat, Aug 04, 2018 at 09:03:49AM +0200, Emmanuel Vadot wrote:
> > > > > This patch adds documentation for Device-Tree bindings for the Al=
lwinner
> > > > > Thermal Sensor Controller found on the H3, H5 and A64 SoCs
> > > > >
> > > > > Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> > > >
> > > > I'm not going to merge a binding for a device that doesn't have any
> > > > driver implemented at the moment in Linux.
> > >=20
> > > I'll take it then. Linux is not the only DT client.
> >=20
> > Then don't complain if we ever have to break the ABI. We never tested
> > that hardware, never had any code running on it, and it *will* cause
> > some issues. For example, the calibration data have never been used
> > and how they should be represented have never been described, since no
> > one ever actually tried to use it.
> >=20
> > And sure, Linux is not the only DT client. Just like FreeBSD isn't.
>=20
>  What kind of data would you need for me to make things better ?
>  We have the driver in FreeBSD for almost two years now, whne I started
> to see how to upstream it I noticed a lot of problems and spent 4 or 5
> days to try on all the SoCs mentionned in the serie, the only SoC I
> didn't include it the A83T as for some reason I couldn't make the
> driver work.

Do you have a link to that driver? How and how much did you test it?

Are you using the calibration data stored in the SID?

> I just hope that you understand that we cannot wait for Linux to
> have a driver to have some bindings.

Just like I'm sure you can understand that just merging the DT bits
without testing anything caused some troubles in the past, and I don't
want to discover it in a year from now.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ctw732jamwpz6sc5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluAHR8ACgkQ0rTAlCFN
r3SZQRAAmXuqaVEN/HMxUrhEiqWT9FyK11pZERNZsHYv+YfegdJDZw23huBgiJUH
4rAtpVwXukCaf0EzUyNL84lwYS+kVQA3Y+Y0gArCyEhUB96lUJYtbdsoJwZ/KKcj
Y5dhAgSLaYzpnGtcpVx5fhrpCQ6XkDSEhSvWrmeanVCDdpMqw7CVL3z/BEqJVBvO
obCFucd3aQqYDqtvxfcF2jD08BeQBbxtcKweQaFIJEP0u/G0HzrIIgFaasyrpsUe
npZCOZyHIiT8+ANG34sG/t4T9tl6DWuaVc1YGIFVD77Umin3Jkt4Co7XCF1PprlZ
2c0WEEogAffVGlQl/TPScXgLDXjByllikb4Gag+6sZwEmUYkunjSC3S65LX8ix7K
CchCpEelxO6Yx9RnGBVDrHNJf/bfaIf8dweiuEN4/0lujdKmYZ/qytQZZE3yc0wP
rUL5af8SMLabWA+dM8JeOrJTksz/styrBBrB5Vi5rZXaZfgbeCGrOL62OabJ2Fcn
HcvgGMGVUe7O608ML7wKxCKJduJuRmjhb6wNU0rYPUnS/wJVOvLN5yDcUPAie3mJ
1GgAOMtZ18RuGgmYwVS8WZHcp2NAVV5nKS91vYS/oxPTpE5C1Ypye+Pla6zMWXzD
R1Cs1CJTpMQxNVgE6j8yjfe98wkdBYYajLmRsncke1TyXbY14js=
=1xTs
-----END PGP SIGNATURE-----

--ctw732jamwpz6sc5--
