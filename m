Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459C7C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C6A20671
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C6A20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388389AbeGXNoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:44:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58674 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388256AbeGXNoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:44:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B86B9207B3; Tue, 24 Jul 2018 14:37:50 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id 83E9420737;
        Tue, 24 Jul 2018 14:37:40 +0200 (CEST)
Date:   Tue, 24 Jul 2018 14:37:41 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, airlied@linux.ie,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 00/18] Allwinner R40 HDMI refactoring
Message-ID: <20180724123741.bbkjgy2uwmzsj45k@flea>
References: <20180710203511.18454-1-jernej.skrabec@siol.net>
 <20180711083036.7attjq4hm5ay5gmn@flea>
 <2309112.TTVI9Fv1ar@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="32fdg44zyqfmmwtk"
Content-Disposition: inline
In-Reply-To: <2309112.TTVI9Fv1ar@jernej-laptop>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--32fdg44zyqfmmwtk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 22, 2018 at 04:43:56PM +0200, Jernej =C5=A0krabec wrote:
> Hi Maxime,
>=20
> Dne sreda, 11. julij 2018 ob 10:30:36 CEST je Maxime Ripard napisal(a):
> > On Tue, Jul 10, 2018 at 10:34:53PM +0200, Jernej Skrabec wrote:
> > > This series fixes several issues found in R40 HDMI patch series after
> > > it was applied. Conversation can be found here:
> > > http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/58601=
1.htm
> > > l
> > >=20
> > > Patches are based on latest linux-next (next-20180710) and are ordered
> > > in such way that they don't break R40 HDMI at any time. Because of th=
at
> > > I suggest that whole series goes through drm-misc to preserve that or=
der.
> > >=20
> > > I also tested those patches on H3 to make sure it doesn't break other
> > > platforms. However, it would be nice to test for regressions also on
> > > older SoCs (with DE1).
> > >=20
> > > Best regards,
> > > Jernej
> >=20
> > Applied all patches but the patch 10, thanks!
> > Maxime
>=20
> It seems that you forgot to merge some patches:
>=20
> [PATCH v2 12/18] drm/sun4i: tcon: Add another way for matching mixers wit=
h=20
> tcon
> [PATCH v2 13/18] drm/sun4i: tcon: Add support for R40 TCON
>=20
> Without them, R40 display pipeline can't work.
>=20
> Maybe they are in your spam folder?

Thanks for telling me, I'm not quite sure what happened.

I've applied them.

Sorry,
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--32fdg44zyqfmmwtk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltXHZQACgkQ0rTAlCFN
r3QoKg//UALd/tvBxAnyMwMcVQrsMpdkYoevVrEcfZbviWMAEosEF/6v539iNm3l
/FKgAY2hemnAmn7lgRXH9mPOLZCVaPtHjeWgOw8HjwVnDF49jNJJn3t8xWGkLsrj
WNCixZsjNFHx3+ZpN66r0fVfhIUVVaCmuTFpX5rdBw05KEGJ+T7d4GJYLvzYJs0u
IhklxPqKcYqrb5apfWZ8t9ZokrvJADL2djZGVlFq5sJHElmxGbYkJ1QpwjgiftuB
OnLd9HLqbKoUIj+7J1S2wMGtzUW/9Bj5xYyAEjw3VBUKIQPgCpTTbDna4XyMJizU
TkH+HEYxrY2S9WpJ+Inm7x29/r0xw6DmGbdYENec4OckKWcz2G0nvYpoStnubKaU
KVLkCrEORKc/jcvA/DdqcyGDPwSMddMChDYQm558czXtIFq9j/fMqUWTZr54+FFa
EqURxkX+hkj5l/H98wsok2sAXkXJCigLawOxlSEbM5bWFEX2n89mZrO3IW6f/QIZ
WjI94eo5alyqnZkf/Gpy7QYMxmM88f9m2brWBPH3TwM9dBsZWiY3rhe+JVuVMXsc
E7wCxF6e92CkSyi5+K8yt3MaTQ4iTBDp5AJcdT+s8rxJ7G9p3+qGYMLuRlEvnFlR
3XACHOnbYiWyunWndvSVNjlFrlABHjwdPALt5IbR2b5DTl5akS8=
=NVTJ
-----END PGP SIGNATURE-----

--32fdg44zyqfmmwtk--
