Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF940C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E07320859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfAITHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:07:02 -0500
Received: from wes1-so2-b.wedos.net ([46.28.106.45]:35202 "EHLO
        wes1-so2.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726581AbfAITHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:07:01 -0500
Received: from localhost (ip4-46-39-182-135.cust.nbox.cz [46.39.182.135])
        by wes1-so2.wedos.net (Postfix) with ESMTPSA id 43ZdsZ1Ls9zq7;
        Wed,  9 Jan 2019 20:06:58 +0100 (CET)
Date:   Wed, 9 Jan 2019 20:06:54 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 1/1] doc: pinctrl: fix bad reference to pinctrl.txt file
Message-ID: <10552cb9ce3067c4b4cf8c25ed6a20c498478549.1547060185.git.ottosabart@seberm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The pinctrl.txt file was converted into reStructuredText and moved into
driver-api folder. This patch updates the broken reference.

Fixes: 5a9b73832e9e ("pinctrl.txt: move it to the driver-api book")
Signed-off-by: Otto Sabart <ottosabart@seberm.com>
---
 include/linux/mfd/madera/pdata.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mfd/madera/pdata.h b/include/linux/mfd/madera/pd=
ata.h
index 8dc852402dbb..dd00ab824e5b 100644
--- a/include/linux/mfd/madera/pdata.h
+++ b/include/linux/mfd/madera/pdata.h
@@ -34,7 +34,8 @@ struct madera_codec_pdata;
  * @micvdd:	    Substruct of pdata for the MICVDD regulator
  * @irq_flags:	    Mode for primary IRQ (defaults to active low)
  * @gpio_base:	    Base GPIO number
- * @gpio_configs:   Array of GPIO configurations (See Documentation/pinctr=
l.txt)
+ * @gpio_configs:   Array of GPIO configurations (See
+ *		    Documentation/driver-api/pinctl.rst)
  * @n_gpio_configs: Number of entries in gpio_configs
  * @gpsw:	    General purpose switch mode setting. Depends on the external
  *		    hardware connected to the switch. (See the SW1_MODE field
--=20
2.17.2


--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlw2RksACgkQgjuumfi+
HjytEQ/8CPzKD+P4FgjrN+4kOdlVkwdP/kLrX+6Wuq3AVSoUiseQJpYi0zIfgbYI
/QPjjZE4b/DDXxK9LFg5eGLWq2jwU7yqExUI5687mZFmZsgKX8FmTnu9rHo+BuzN
1KQflePI/UL1s0JA1pnf3BzQb/C8mEJchtUN3032wp3JL+5YMHK/CDTCXdZnmKZO
ZdwWwiNc2lJAaCL3IjpfyIAqAgyBmC28xLclGul8jEh4N2luL3Vv6pTpnBeEiB6i
QHCwnGz9yqi9uhjzPemV8c96R9e0mQ3kdWLiY3Q4r+NT6JwmxcaUOg4ipgi3JI+s
QsHehLXolFVGduHyQ4jyGvWipgJ5StZ3VyZOsdFNEzDjgZo7nKLHccpriVB8uupm
QI0aYkzeiexfslRww44OUw9VHkm6pfyg8fNh2CNSXVx50/JRE3efp5gH8/rHjbEE
2XgHMnEx0g2keXZ5GMVpnW1l6IBEFZ5aMDEkfCZbM66+CMQB2rYReIraLSmsHCYf
62pSQv5zohQAmkVPvyFX9Od27qu4VcFjJTQZ+WsXw+2erwvDNTQYoXsZDI8+pAFc
/wSGpOnf9ik1V8TYf5aKinv2PpFawmQwfSRzmx0zBP83id1ZMDpHC6pCeMFpjAmT
qPsxqeu5P2ESh1HTAFLOWOY8ZFWnFBQ7U0qPCYLZfAtjXvTCswM=
=VNSo
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
