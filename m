Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830A9C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465DA20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465DA20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbeLFNFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:05:16 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34210 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbeLFNFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:05:16 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 212D6809C1; Thu,  6 Dec 2018 14:05:11 +0100 (CET)
Date:   Thu, 6 Dec 2018 14:05:13 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     andrew@lunn.ch, vivien.didelot@savoirfairelinux.com,
        netdev@vger.kernel.org, f.fainelli@gmail.com
Cc:     buytenh@marvell.com, buytenh@wantstofly.org, nico@marvell.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] dsa device tree bindings: fix typo and wrong example
Message-ID: <20181206130513.GE22343@amd>
References: <20181115195111.GA9946@amd>
 <20181206130051.GA22343@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Dzs2zDY0zgkG72+7"
Content-Disposition: inline
In-Reply-To: <20181206130051.GA22343@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dzs2zDY0zgkG72+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

   =20
Fix typo and fix compatible value that is not actually permitted by the
description in the example.
  =20
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/Documentation/devicetree/bindings/net/dsa/marvell.txt b/Docume=
ntation/devicetree/bindings/net/dsa/marvell.txt
index feb007af13cb..abf1be036ac5 100644
--- a/Documentation/devicetree/bindings/net/dsa/marvell.txt
+++ b/Documentation/devicetree/bindings/net/dsa/marvell.txt
@@ -41,7 +41,7 @@ Optional properties:
 - mdio			: Container of PHY and devices on the switches MDIO
 			  bus.
 - mdio?		: Container of PHYs and devices on the external MDIO
-			  bus. The node must contains a compatible string of
+			  bus. The node must contain a compatible string of
 			  "marvell,mv88e6xxx-mdio-external"
=20
 Example:
@@ -80,7 +80,7 @@ Example:
 		#interrupt-cells =3D <2>;
=20
 		switch0: switch@0 {
-			compatible =3D "marvell,mv88e6390";
+			compatible =3D "marvell,mv88e6190";
 			reg =3D <0>;
 			reset-gpios =3D <&gpio5 1 GPIO_ACTIVE_LOW>;
=20


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Dzs2zDY0zgkG72+7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwJHokACgkQMOfwapXb+vLyigCeLkj/l6l1yqQPcXbuCB2AXFQ8
upEAoL/9VzntmKoO2Ni1Y+ujCJXloBlo
=L8yU
-----END PGP SIGNATURE-----

--Dzs2zDY0zgkG72+7--
