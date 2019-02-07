Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46F1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879E921904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfBGPzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:55:53 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:55611 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfBGPzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:55:53 -0500
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 3CCCC24000F;
        Thu,  7 Feb 2019 15:55:50 +0000 (UTC)
Date:   Thu, 7 Feb 2019 16:55:49 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the sunxi tree
Message-ID: <20190207155549.pdxy36rl4bomoyp7@flea>
References: <20190208005042.6b353e17@canb.auug.org.au>
 <CAGb2v650UCEXbEnNPTiPPSn_5Tznso4gg5W23P9K8Y7f_pAqxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k7mwlffbqscvi2cl"
Content-Disposition: inline
In-Reply-To: <CAGb2v650UCEXbEnNPTiPPSn_5Tznso4gg5W23P9K8Y7f_pAqxw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k7mwlffbqscvi2cl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 09:53:22PM +0800, Chen-Yu Tsai wrote:
> On Thu, Feb 7, 2019 at 9:50 PM Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
> >
> > Hi all,
> >
> > In commit
> >
> >   df0aeb208b24 ("ARM: dts: sun9i: a80-optimus: Add node for AXP809's un=
used dc1sw regulator")
> >
> > Fixes tag
> >
> >   Fixes: aa4a27bc819e ("ARM: dts: sun9i: a80-optimus: Add AXP809 PMIC
> >
> > has these problem(s):
> >
> >   - Subject has leading but no trailing parentheses
> >   - Subject has leading but no trailing quotes
> >
> > Please don't wrap the Fixes tag over more than one line.
>=20
> Right. I forgot to update the messages from these I made in the past.
>=20
> Maxime, can you fix it up?

It should be done now, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--k7mwlffbqscvi2cl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFxVBQAKCRDj7w1vZxhR
xemuAP9co9fA5IJGgwimfLW+JN9WBOab4glj5YCJND/gfhycAQD/ZhpBDHgqxG0H
T4NUk5xDp3haclYWDNGEboBPIRZ0kAo=
=kQoO
-----END PGP SIGNATURE-----

--k7mwlffbqscvi2cl--
