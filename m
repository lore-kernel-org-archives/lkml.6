Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A5EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5DF20859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfAITHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:07:50 -0500
Received: from wes1-so2-b.wedos.net ([46.28.106.45]:43957 "EHLO
        wes1-so2.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726469AbfAITHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:07:50 -0500
Received: from localhost (ip4-46-39-182-135.cust.nbox.cz [46.39.182.135])
        by wes1-so2.wedos.net (Postfix) with ESMTPSA id 43ZdtW5RxkzqC;
        Wed,  9 Jan 2019 20:07:47 +0100 (CET)
Date:   Wed, 9 Jan 2019 20:07:41 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/1] doc: gpio-mvebu: fix broken reference to
 cp110-system-controller0.txt file
Message-ID: <8fd140950dd0bb859f9a48d8b25fb919cbb3cc6b.1547059503.git.ottosabart@seberm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The cp110-system-controller0.txt file was renamed to
cp110-system-controller.txt.

Fixes: 4aa5496980e4 ("dt-bindings: cp110: rename cp110 syscon file")
Signed-off-by: Otto Sabart <ottosabart@seberm.com>
---
 Documentation/devicetree/bindings/gpio/gpio-mvebu.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt b/Docume=
ntation/devicetree/bindings/gpio/gpio-mvebu.txt
index 38ca2201e8ae..2e097b57f170 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
@@ -14,8 +14,6 @@ Required properties:
=20
     "marvell,armada-8k-gpio" should be used for the Armada 7K and 8K
     SoCs (either from AP or CP), see
-    Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0=
=2Etxt
-    and
     Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.=
txt
     for specific details about the offset property.
=20
--=20
2.17.2


--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlw2Rn4ACgkQgjuumfi+
Hjxfiw/9Fk7Ox0asGlTrDCjLScq8iEd1p1iAgMz26Ut5NKHWaKqBEGajxQIhQnUN
utxLjTWH8QDcGItpbzvTYcnKrF+mRhcpDvHZ/O8dhac5ZYA7qcA/106aRB/MSogh
u3/GeVNokIGUtXi8xepJvm9vmYnhdgqOild8hxc9Frr1x26ORpgPBbWurcf7YFZJ
SET3fv86kPjPWaLakjT67ULGPhhX5RxJv8M4QllsyLJfvBntrxH5ACMovdTciV8A
PBEWQQ1gMlD4cCnrvviuG/ySZig0JCG2DcYWaZsp8yOw+zYFExavgSHkoxESFC/P
1UoVldOmp5QKGOMYfrD4SjysZJnaLhsw/kJVGDwTiHtXc5iYd95Jercp47Vmd8TJ
u2bkmgEIVlCkAiMjZBuYlxr0HI6kISe55V+FqCtco3q8/ZUQCnUOsL3gkFDMtepq
2fvD9Lw9Crr3lrcnCZVLJYMAZ8oKxNSQCuMCZjMiHeJyE7T1yNJbK80QruG4tKO1
k504yGakideglEWAXUJaKuevEBGALwxLBZu+EkMFdBHPGLcbALNcfAIhbdniX6lQ
o6+XZkHxrU4hxnyZtnFJTucPSQ1oLcCqgEF5PtasXnhCmTWF6wGsc0EN4tWWIq0E
pWvNLfoaHb4CS4PeDSP04GA63D1A6t7FSH+fHmhswgUS2PpoQ1U=
=/a7b
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
