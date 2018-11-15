Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D10FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509A5223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509A5223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388566AbeKPBPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:15:12 -0500
Received: from mail.bootlin.com ([62.4.15.54]:45104 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387833AbeKPBPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:15:12 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0777A20D72; Thu, 15 Nov 2018 16:06:59 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id CF68320893;
        Thu, 15 Nov 2018 16:06:58 +0100 (CET)
Date:   Thu, 15 Nov 2018 16:06:58 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: dts: allwinner: h6: fix EMAC compatible string
 sequence
Message-ID: <20181115150658.ctlapreik2alvmwl@flea>
References: <20181115031551.11756-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b4c3kpe4dazfz7k4"
Content-Disposition: inline
In-Reply-To: <20181115031551.11756-1-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b4c3kpe4dazfz7k4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 11:15:51AM +0800, Icenowy Zheng wrote:
> The SoC-specific compatible should come before the fallback compatible
> string when multiple compatible strings are present, but the sequence is
> wrong currently on H6 EMAC node (A64 fallback before H6 compatible).
>=20
> Fix the sequence.
>=20
> Fixes: c8ced5516d23 ("arm64: allwinner: h6: add EMAC device nodes")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--b4c3kpe4dazfz7k4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+2LkgAKCRDj7w1vZxhR
xXERAQDeA5fP6uGHa10H1FpeBN26erU+N1xlZplcT0ciC/2NawD+Ib//Kz4CmCbl
aMI3cKfR1yuQIvheKWz9diZYfTJUJQI=
=1/KE
-----END PGP SIGNATURE-----

--b4c3kpe4dazfz7k4--
