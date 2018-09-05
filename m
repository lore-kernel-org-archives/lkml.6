Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ED0C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE742077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE742077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeIETTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:19:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52538 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbeIETTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:19:46 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3BA7820734; Wed,  5 Sep 2018 16:49:13 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 44935208B5;
        Wed,  5 Sep 2018 16:48:53 +0200 (CEST)
Date:   Wed, 5 Sep 2018 16:48:52 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v4 3/4] drm/sun4i: Enable DE2 Mixer for SUN8I and SUN50I
Message-ID: <20180905144852.db2galdquxx22kjh@flea>
References: <20180904163609.10171-1-jagan@amarulasolutions.com>
 <20180904163609.10171-3-jagan@amarulasolutions.com>
 <20180905070748.g43lfdqdhmoci6pk@flea>
 <CAMty3ZBYjq8VBnwSqKhJgag1ARRvnPTVSpYT7SWu=A6pMwKEiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="en7fpj6tbqjjbcyr"
Content-Disposition: inline
In-Reply-To: <CAMty3ZBYjq8VBnwSqKhJgag1ARRvnPTVSpYT7SWu=A6pMwKEiA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--en7fpj6tbqjjbcyr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 05, 2018 at 01:51:25PM +0530, Jagan Teki wrote:
> On Wed, Sep 5, 2018 at 12:37 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > On Tue, Sep 04, 2018 at 10:06:08PM +0530, Jagan Teki wrote:
> >> Allwinner SoC like SUN8I and SUN50I are now using DE2 Mixer
> >> so enable them as default.
> >>
> >> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >> ---
> >> Changes for v4, v3:
> >> - none
> >> Changes for v2:
> >> - Enable for SUN8I
> >>
> >>  drivers/gpu/drm/sun4i/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kco=
nfig
> >> index c2c042287c19..cfa8b96273fb 100644
> >> --- a/drivers/gpu/drm/sun4i/Kconfig
> >> +++ b/drivers/gpu/drm/sun4i/Kconfig
> >> @@ -61,7 +61,7 @@ config DRM_SUN8I_DW_HDMI
> >>
> >>  config DRM_SUN8I_MIXER
> >>       tristate "Support for Allwinner Display Engine 2.0 Mixer"
> >> -     default MACH_SUN8I
> >> +     default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
> >
> > I'm not really sure we should put it as a default. We should just
> > enable it in the defconfig.
>=20
> What would be the difference in both cases it would be build as module
> since DRM_SUN4I=3Dm for ARM64

We wouldn't force it down the throat to every user by default, even
though they have no interest in that driver being compiled into their
kernel.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--en7fpj6tbqjjbcyr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluP7NMACgkQ0rTAlCFN
r3SA3w//UvUCidVC1bCGgZ1mFpBQJ6Jyw4gvoHRH/oJzrN/PwzJQlMleDRrlIhc3
JkWwmGyZKZGLISF3Xa/Z1pgQoFrl2HV9jiTUNVKkQ9kxwIebLAM5th72Ksurl1U/
Y1HuDO9Qk1RGmFogRiJpdmw99Z3pModUUWOM+OxUADd8JP8bTnA4yrvcebAcXV+p
+/x29nNZUmCjrN1YdZSXLDtg3TdxhIA3QFDBETlJuZioM3HIzZ6p6DeSzzBC91IN
IBGF3TMXU+cVa3JM2PbGYOO0c/W2P1oB6s+PFTw74crfxSqAI28mc+j/gjGm18OS
fMmk6ENVSt6SB8mp1quKh+peoVZ0hQ/vBmcIwKaTFUTeVE741wBGzpp2rb/gCThx
N3aXFLiAVpdCnjZNE+ATWAnTFnmlfl4K4Oo2XYeIdaAcyatxQGSgdOypz72C4A+q
2Sg7rpYKB7h8IOYlkGkrroU/S4641P8swC3+9yxNxY8KK8G1Zed4X3V/+I+JmCG5
BHmxSaq74KjzBs9BRrwQsy/GBE3FnhpBF/GeSPQVUnRuf1MJzyvDRgpIrMi0L442
rI6imPJHKlDHvYE3EInLXIsSmFC82YNj0ULlGQLP8hsdgVNQ/umGs5ZAHhPm8f3A
ZE5ET7x0rpVJlkzioNl8ZaWmM8EXt38/H/xTTMn20XmLdbpvqAQ=
=Ma1n
-----END PGP SIGNATURE-----

--en7fpj6tbqjjbcyr--
