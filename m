Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32083C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12432073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12432073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbeIEMUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:20:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36344 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbeIEMUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:20:45 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 171F920795; Wed,  5 Sep 2018 09:51:47 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id D46B9206DE;
        Wed,  5 Sep 2018 09:51:36 +0200 (CEST)
Date:   Wed, 5 Sep 2018 09:51:36 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] [PATCH v4 11/11] arm64: dts: allwinner: a64:
 Enable HDMI output on A64 boards w/ HDMI
Message-ID: <20180905075136.chumwosx76o2n66l@flea>
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180904044053.15425-12-icenowy@aosc.io>
 <CAMty3ZCvpUf0nJ3WuPccP8BizBP=Uc8ChzB8SeN8fkX2iS1E_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gtusaa4loc5rodye"
Content-Disposition: inline
In-Reply-To: <CAMty3ZCvpUf0nJ3WuPccP8BizBP=Uc8ChzB8SeN8fkX2iS1E_Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gtusaa4loc5rodye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 05, 2018 at 12:56:03PM +0530, Jagan Teki wrote:
> On Tue, Sep 4, 2018 at 10:10 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
> > From: Jagan Teki <jagan@amarulasolutions.com>
> >
> > Enable all necessary device tree nodes and add connector node to device
> > trees for all supported A64 boards with HDMI.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > [Icenowy: squash all board patches altogether and change supply name]
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> > Changes in v4:
> > - Rebase some device trees.
> > Changes in v3,1:
> > - Squash all enablement patches altogether.
> > - Change supply name to match DT binding & driver change.
> > Changes for v3:
> > - Enable all pipeline components
> > Changes for v2:
> > - none
> >
> >  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 34 +++++++++++++++++++
> >  .../dts/allwinner/sun50i-a64-nanopi-a64.dts   | 34 +++++++++++++++++++
> >  .../dts/allwinner/sun50i-a64-olinuxino.dts    | 34 +++++++++++++++++++
> >  .../dts/allwinner/sun50i-a64-orangepi-win.dts | 34 +++++++++++++++++++
> >  .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 34 +++++++++++++++++++
> >  .../allwinner/sun50i-a64-sopine-baseboard.dts | 34 +++++++++++++++++++
> >  6 files changed, 204 insertions(+)
>=20
> Tested-by: Jagan Teki <jagan@amarulasolutions.com> # BPI-M64, OPI-Win,
> A64-Olinuxino, NPI-A64
>=20
> Pine64 boards look unable by saying
> [drm] Cannot find any crtc or sizes
>=20
> May be someone can confirm, it.

Then we should drop the pine64 additions until someone figures it out,
as it has been already discussed.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--gtusaa4loc5rodye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluPiwcACgkQ0rTAlCFN
r3SElg//XDj99sAXXwkPKmW6hF9CnEGV/SAmzw8P/sbjvHMQmXH1sDS4KC8F3BAk
AQvA8rQI/Scm4lS9A+6obtT+a4XXWb2icKYeee73wb68goVhPS3lbftl0EzW3IrB
sCgDhiDKlNmacwMG5qM663UgfsnusbfqEae+KTHdpyskHgz5RUPve/SmzsAPtFhV
aK42v/glNWGogb+U39CI9B1Ox9UYiwm1JKOWkCfDHV/uRwpRtan7XmmSKJLZadOq
MJXinDRuO6w4UO6eCkvL6m9Nf8npKF5lrjGOMBInISysAfDD/Tgb8gquvr2dq2G/
iDjXzVH+brqrjl8CNSUpwNleAmQ/pP4NN9zyQfP+g7d7EioIEGa2GRttxTYhoUuO
lkDI77d/zidEjW7Sr4OCRqNSfWdb3RNvHBrtevqaSLbUGwiwcudPLUkVTQnarsQr
q4Hr92d+gaZu/jyH4vw4C9U3LNv5QdUw7ITtaUjkiUD83f23LpsFwQvDhsgJh0j9
vDCISwBDG8rb22PajSCgqUl7EtXon5O5PuwAiwDw/mmU2ZCREapcfbZw4rRRMLBN
K4612S/5sxzw1DA8BZL+rG/LdaJIMwhvIdq8P3Xi0YakGvG68+fpK7Jj0cTGMxQD
MaWCa/lW1SHaCBH6wgqt89v9p0h6zlGT08P5PIzZMcfXGRezVqk=
=uU07
-----END PGP SIGNATURE-----

--gtusaa4loc5rodye--
