Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33F0C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4B52152D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4B52152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeHTPQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:16:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38505 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbeHTPQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:16:19 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8082320DEC; Mon, 20 Aug 2018 14:00:56 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-85-9.w90-88.abo.wanadoo.fr [90.88.27.9])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4DFDB20DE0;
        Mon, 20 Aug 2018 14:00:46 +0200 (CEST)
Date:   Mon, 20 Aug 2018 14:00:46 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] Re: [PATCH] ARM: dts: sun8i: r40/v40: rewrite BPi
 M2 Berry DTS to rebase on M2 Ultra
Message-ID: <20180820120046.7tonxtb52q43ocfq@flea>
References: <20180724163655.61365-1-icenowy@aosc.io>
 <20180726124119.dwne2sncws2p3sdi@flea>
 <dc8a28bcfbe082158bac5b097badb3ddf0f51ce8.camel@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gef5bru62hgkzpqm"
Content-Disposition: inline
In-Reply-To: <dc8a28bcfbe082158bac5b097badb3ddf0f51ce8.camel@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gef5bru62hgkzpqm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Wed, Aug 08, 2018 at 06:36:56PM +0800, Icenowy Zheng wrote:
> =E5=9C=A8 2018-07-26=E5=9B=9B=E7=9A=84 14:41 +0200=EF=BC=8CMaxime Ripard=
=E5=86=99=E9=81=93=EF=BC=9A
> > On Wed, Jul 25, 2018 at 12:36:55AM +0800, Icenowy Zheng wrote:
> > > Banana Pi designs the BPi M2 Berry board to be software compatible
> > > with
> > > BPi M2 Ultra,
> >=20
> > Do you have a reference for this?
> >=20
> > > so it's based on M2 Ultra with some function cuts, including:
> > >=20
> > > - 2048MiB DRAM -> 1024MiB (this should be proceed by the
> > > bootloader);
> > > - dropped a LED;
> > > - dropped eMMC;
> > > - dropped USB2 and connect USB1 to a 4-port HUB.
> >=20
> > Is it the exhaustive list?
>=20
> I have asked Mikey from Sinovoip, and he has agreed this.
>=20
> Here's a list provided by him, which covers some things I forgot:
> - 2GiB -> 1GiB
> - no eMMC
> - no onboard microphone
> - no IR
> - no charging (and power jack to USB)
> - USB change
> - one less LED
>=20
> Should I add this to the device tree's comment?

Not really, because...

> >=20
> > I'm a bit reluctant to merge that kind of patches usually, since that
> > would also imply that each time someone will commit something to the
> > M2-Ultra, it would automatically apply to the M2-Berry, without any
> > easy way to tell and / or test.

=2E.. this still applies.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--gef5bru62hgkzpqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlt6rW4ACgkQ0rTAlCFN
r3ScGQ/9FrHdE9AWrObaIPhRZd5VO2sFPBr/SECyAthbaX4lZgbYQK3E7ogdWVk8
g5MUEW7DIJ5FmlpDqq6qNEp2NL/XTtFgSlKmJ8JpiL8cNvfPa5GzXGkqIJnMdISu
yyN8/kxXr1McD5Vl/USxKdv/eqCimS8vfcQeFgmktIM8j9EDcO6r+BBXNFciun6R
JCPeEYWwM67DxAypXaosbw00YoAu7FXOiaVTBXsOS9YC37ZKnnH2OhkBZxZkiQ0x
GtsAo6mG1aCQloBwZ2tFBD9DEYNkFmS3Jr/+ZeHsCY0oKm/0S/mz35PhHDK+eFgD
+RRiFaE6KCu7M1E7YJ53PgoXT+RJNy/DXK7pJejwCR77TyVC7UoVpK0s/k0gc0ce
jJgOV0RxYn85FqRDJ+kBujL1N9yypMuCSHYme/KD3RvEQ2IdjGGPWFCEUPb5Pj7/
scZOe3BY8UB9Vt768gwDv1yAVZ/FwlXAk3TIwCOKnXx1puek6te//UWAqxyXntzR
FlLrOzMBfzk/DWfxl5XUghO85omb0eco8UvV5Xkycx21371LDn0/UgYpi4crhmj2
iFRiR7W9Jofw+Cs5brw6FLAoxyek2NMRMhCXYuRTLP8b6NG0R2S749/5aiIU/PTY
cx8tT4AD1APZZ6YUgfSiIY62czOJv5rcHWZfiPTqqBgNc1B3m0w=
=oeS9
-----END PGP SIGNATURE-----

--gef5bru62hgkzpqm--
