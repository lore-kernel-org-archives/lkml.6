Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C524C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC5A206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC5A206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbeKTS0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:26:01 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49268 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeKTS0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:26:01 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 59FE5207B0; Tue, 20 Nov 2018 08:58:13 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2E0EF20745;
        Tue, 20 Nov 2018 08:58:03 +0100 (CET)
Date:   Tue, 20 Nov 2018 08:58:03 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/3] arm64: dts: allwinner: h6: orangepi: Enable USB 2.0
 and LEDs
Message-ID: <20181120075803.6735awl2zd5ak2fo@flea>
References: <20181120065311.30009-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qndgcgymmap35tri"
Content-Disposition: inline
In-Reply-To: <20181120065311.30009-1-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qndgcgymmap35tri
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 20, 2018 at 02:53:08PM +0800, Chen-Yu Tsai wrote:
> Hi,
>=20
> This small series enables USB 2.0 and LEDs on the Orange Pi Lite 2 and
> Orange Pi One Plus. The two features are unrelated, but included in the
> same series as the patch contexts overlap.
>=20
> Patch one adds a fixed regulator to represent the board-wide 5V rail.
> While not strictly necessary, this helps define the relationship between
> regulators.
>=20
> Patch two enables USB 2.0 host and OTG. Note that VBUS on both ports are
> directly tied to the 5V rail, without any power switches or current
> limiters.
>=20
> Patch three add device nodes for the two LEDs. These LEDs are driven
> directly by the GPIO pins, without a current limiting resistor. At the
> default drive strength, the LEDs are quite bright.

Applied all three patches, thanks!

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--qndgcgymmap35tri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/O+iwAKCRDj7w1vZxhR
xZ3AAPsFC8kMp8Uxd5tj0Ipt4mbbGZ9pyPDEwTSbz9Ic+87CKwD+NlAmH3P3Lc0K
5AOCcs5OmpVxZ4AzJLZhW3UrccjCDgI=
=9eHS
-----END PGP SIGNATURE-----

--qndgcgymmap35tri--
