Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5D2C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C9620661
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547059576;
	bh=WXFN1akWkMR/vffsTH4X6t0sRENrns8bZUe4g9+hKF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HNCNYGkyb/rcJsUVnqZ4VVC2BTt+RSxJduxxIt6elCc49fm8iGkh+Dpb+uklaZRi4
	 hmb3+qKH/Cs4qVUdORj3UR2tYyWEchhlHTYU0KHomgiNvcTGCfLTL7ehKDgqYzQwuA
	 xP97zXxIMuscRQxR2NXJzdyMFJjglIwqxMbOIGjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfAISqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:46:15 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56436 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfAISqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HoUUAmONh6tfxEaWm8k8WBpdpdPeuNV9ZIsTcKwd+uE=; b=D0lRYUSttmiOmBj2aHK6X4kKe
        0Kd+C2Fr/6p6P7fVYg3Si2H26D0ufOSShgZ3dziQqWt51SszEjzfk4TGVc8+gTZw+SLL6/Mv3KFjy
        FTRd3QigPvQzLlx0+9XCmPwnpCwbAKWNGUC53VOeWeqX7he2uzCTje9UXn88aHfh43nV8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ghIrc-0000k9-Qu; Wed, 09 Jan 2019 18:46:04 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 55EFB1127528; Wed,  9 Jan 2019 18:46:04 +0000 (GMT)
Date:   Wed, 9 Jan 2019 18:46:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Code Kipper <codekipper@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Subject: Re: [PATCH v3 1/9] ASoC: sun4i-i2s: Adjust regmap settings
Message-ID: <20190109184604.GJ10405@sirena.org.uk>
References: <20181221152110.17982-1-codekipper@gmail.com>
 <20181221152110.17982-2-codekipper@gmail.com>
 <CAGb2v66-JmONW9AYqoSmifrEj+nstREdsbkcy9ECwnJ47zxARA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x+WOirvrtTKur1pg"
Content-Disposition: inline
In-Reply-To: <CAGb2v66-JmONW9AYqoSmifrEj+nstREdsbkcy9ECwnJ47zxARA@mail.gmail.com>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+WOirvrtTKur1pg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 22, 2018 at 12:44:07AM +0800, Chen-Yu Tsai wrote:
> On Fri, Dec 21, 2018 at 11:21 PM <codekipper@gmail.com> wrote:

> > +       regcache_cache_bypass(i2s->regmap, true);
> >         regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
> >                            SUN4I_I2S_FIFO_CTRL_FLUSH_RX,
> >                            SUN4I_I2S_FIFO_CTRL_FLUSH_RX);
> > +       regcache_cache_bypass(i2s->regmap, false);

> IIRC the flush cache bit is self-clearing. So you likely want to mark
> this register as volatile. If it is marked as volatile, then all access
> to that register bypasses the cache, so the regcache_cache_bypass calls
> are unneeded.

Yes, that should be the case.

> However, looking at the code, the write would seem to be ignored if the
> regmap is in the cache_only state. We only set this when the bus clock
> is disabled. Under such a condition, bypassing the cache and forcing a
> write would be unwise, as the system either drops the write, or stalls
> altogether.

Right, access to a cache only register while the device is in cache only
mode is not a great idea - the usual reason we're in cache only mode is
that the device is in a state where I/O isn't going to work.  One thing
that can work for this if you need the register to be cached (but is a
bit gross) is to do a write setting the self clearing bit then another
immediately after resetting it back to the cleared state.  That works OK
for cases where the bit is a strobe and never retains state, though if
the device isn't operational then needing to write to the register might
indicate a bigger picture logic error (or it could be that the register
map mixes random things into one register).

--x+WOirvrtTKur1pg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2QWsACgkQJNaLcl1U
h9Czcgf/WEsr/xgxGR1vWUvTZ6HNUj2DdVfl5O8Fqvyh5XNwHUGt4I8gueUJSoRL
lRSRA1NqnXYhd1S27qKSWtJA4VgRg7bDT/SoD7PFAspmc4R8fZ9yPdKBqqTZB+yv
KCwF2H/u/8LIhGVJtqTpEpmwkmQh+H3he6HLSnDaVRtaqiEQKzD/1gP5NGW5AJdL
SgZsfpsGlefkKglwLqw62e2lnjjqShydhd5p9ciEO51Hc4rJzQgxYQYWTJwZ9jNK
XjGkwyVghD8WtKoEAnwrd7l1JR//Hapv52wmq4oSZ83in8TNXracdM1djPxxizjW
q6G62CFmh8On1d62dbYKwhdZxpQlvg==
=Yhg0
-----END PGP SIGNATURE-----

--x+WOirvrtTKur1pg--
