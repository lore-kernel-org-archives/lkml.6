Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BE0C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F0F208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F0F208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbeG0OVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:21:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36555 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728384AbeG0OVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:21:19 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3FE942073D; Fri, 27 Jul 2018 14:59:22 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1127020618;
        Fri, 27 Jul 2018 14:59:12 +0200 (CEST)
Date:   Fri, 27 Jul 2018 14:59:12 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3.1 00/10] arm64: allwinner: Add A64 DE2 HDMI support
Message-ID: <20180727125912.e5js7krmthto6gmz@flea>
References: <20180726171257.6688-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="anrqhmutbeiy5itt"
Content-Disposition: inline
In-Reply-To: <20180726171257.6688-1-icenowy@aosc.io>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--anrqhmutbeiy5itt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27, 2018 at 01:12:47AM +0800, Icenowy Zheng wrote:
> Allwinner A64 has display engine pipeline like other Allwinner SOC's A83T=
/H3/H5.
>=20
> A64 behaviour similar to Allwinner A83T where
> Mixer0 =3D> TCON0 =3D> LVDS/RGB/MIPI-DSI
> Mixer1 =3D> TCON1 =3D> HDMI
> as per Display System Block Diagram from the A64 user manual.
>=20
> This is third patch-set followed with previous RFC[1], first and second
> series[2][3] and merely concentrated on HDMI pipeline through TCON1 and
> rest will add eventually.
>=20
> I just rebased and slightly re-integrated the patchset according to the
> requirments of the maintainer, and added the mixer0->tcon0 pipeline.
> The further maintainship of the patchset still needs to be discussed
> between I and Jagan.

Beside the comment on the pine64, it looks good to me. Can you
resubmit those patches after rc1 is out?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--anrqhmutbeiy5itt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltbFx8ACgkQ0rTAlCFN
r3Rh4w//YULFl9J+chHjxWnvahKtcxglkDFlvK0R3Ht0O0wkegqgZci5c425DsnK
1ISyKxPobr41n6NRuwAje2hqwZte2DoSM3E/TQ749KtzcJGqJHc6jk07+t5oz7CT
JKi3xip659H/78FOhE/gXxc6XfgKVT+YzH2FbBAJL/Q8wid0O3INJiy+3oqX0ffV
RUtk23mAMLPe74ku8lvJKxlISZxaapB8W5515IN7oqJBoOfvTJVapQB2Mc/GJXN/
VsfbDvKKeYLUH9nd+no7iLVkbsb4Jr4byU2pxDCol/jh/t/91AXi7pbLaL4rzfko
XNiQzohYBbYoTnVIjmxVgYiL8bCI4MUFJ1FH0MCQiP2w0c4bxVSVKZEXzXIqtPaL
GfZDKGKYUHqiUz8+4LKgV6oNi2xhpD10dXS2H30Rd7rcpbQN9ROibBrdf+0iIvay
I0+upoQSS1AQcgUGyREum0dQq3QA0dqFeAV76LxXIntcXt2IZ4hw30GwDNBqhi3D
v/q2NceMeYxM12aAzVg9pkZwY6XGjn9ftdmvXzLLr2OR8+h22Y75dhA7FSEzEPLz
chxk4lAOyQWDezye0o0+wbEQXii7jxb/E3QLb7JF2EZ6awEG+7aakAuySkG1HJsG
518FmSA41GV4a/Wtc2+xrThNOr1MIBtgEFiZYzn/V4Kf4bRiV84=
=/5kr
-----END PGP SIGNATURE-----

--anrqhmutbeiy5itt--
