Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0E3C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A682220874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A682220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbeGXOHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:07:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60306 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbeGXOHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:07:10 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1A46E20943; Tue, 24 Jul 2018 15:00:45 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id DCE7220884;
        Tue, 24 Jul 2018 15:00:34 +0200 (CEST)
Date:   Tue, 24 Jul 2018 15:00:35 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Emmanuel Vadot <manu@freebsd.org>
Cc:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, catalin.marinas@arm.com,
        will.deacon@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] nvmem: sunxi-sid: add support for H5's SID
 controller
Message-ID: <20180724130035.cll6mdqiqjbglotj@flea>
References: <20180724101522.68165-1-manu@freebsd.org>
 <20180724101522.68165-4-manu@freebsd.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nm3mmu4m4ctttuip"
Content-Disposition: inline
In-Reply-To: <20180724101522.68165-4-manu@freebsd.org>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nm3mmu4m4ctttuip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 24, 2018 at 12:15:21PM +0200, Emmanuel Vadot wrote:
> The H5 SoC have a SID controller that looks like the one in A64, but
> in case we find some difference in the futur at a binding for it.
>=20
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>

The prefix in your commit title should start with dt-bindings: ...

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--nm3mmu4m4ctttuip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltXIvIACgkQ0rTAlCFN
r3S2Ww//SZXZFeHH0RfRbLisSsuK1uOTqOmE+jhFVncjJ/8tJ07hLBN321sPnED0
e3sG8H2w8ZddGLPFoGpLnIr6kC0Q0pA/Igp1V0yLMo+IVdSMKUNeg8qWkYbX/0sR
CZ1yGIn8TOjkUYlxuMTgKNUQYAtBoK16YCh5+6zszIYUWiw4lKojfjV7XXiHw19D
et8Qk4GOVsTVf98Ae4NIFuHh9nkr/eaZHH6GTI4N9kYCo8GCymEbQXLZd26GjIu8
RqNi5sWqc/XowXGeUz8Hao6mNQKiiP4kR9CEWBhCPrrcg1TOXewgV7rdAqT+T/sL
b14O5m7ewhY4Cd4ti/O/zuUB+UZoYjcAoYuJzH10aImbGEfTgsITkOMZiAqRBcI/
nfmjBv7XyJiqufZNBAQMDKnl0nQicKT4Gk7L4n15onS6Hw95OJBMbhiEka/Q1y0z
WB6XdEk5Qo/HoWbRYgA98xpfe6whjmSAxGAeXR/KMrL6jcib2QKYPmp20XSBM/oY
8BHclVOclH1/E7nV26Wm5Hv8yuzrXDBEGYaxawEE4lRi2Xzv8Z5vwhFb5XaAsOiD
tuDzX+JwRwoxl8k/mes32Aylzzxlzxk3YqAduB5wvvTiVewCsaRmRl0A5Uf9opI2
XWttK00vtT9gxAcWAwG/HAx1MI6hG40AUk1IcCww5tBipUT1Gy8=
=Ataw
-----END PGP SIGNATURE-----

--nm3mmu4m4ctttuip--
