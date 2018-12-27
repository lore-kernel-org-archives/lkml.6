Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB2AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C4421479
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbeL0Txj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 14:53:39 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59267 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbeL0Txj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 14:53:39 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 37926806DE; Thu, 27 Dec 2018 20:53:33 +0100 (CET)
Date:   Thu, 27 Dec 2018 20:53:37 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lee Jones <lee.jones@linaro.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] mfd/ti-lmu: fix typo
Message-ID: <20181227195337.GA12008@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix typo in comment.
   =20
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/include/linux/mfd/ti-lmu.h b/include/linux/mfd/ti-lmu.h
index 1ef51ed..06b2a9b 100644
--- a/include/linux/mfd/ti-lmu.h
+++ b/include/linux/mfd/ti-lmu.h
@@ -75,7 +75,7 @@ enum lm363x_regulator_id {
  * struct ti_lmu
  *
  * @dev:	Parent device pointer
- * @regmap:	Used for i2c communcation on accessing registers
+ * @regmap:	Used for i2c communication on accessing registers
  * @en_gpio:	GPIO for HWEN pin [Optional]
  * @notifier:	Notifier for reporting hwmon event
  */

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwlLcEACgkQMOfwapXb+vKifQCeKhSkhYt7nQr4se58AiTwjKxs
JaMAoJ6Z5Mk+MGEE568TNbAU9kHLfk/i
=WuBY
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
