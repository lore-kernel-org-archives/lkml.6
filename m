Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AE4C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4BE20685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfAITJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:09:46 -0500
Received: from wes1-so2-b.wedos.net ([46.28.106.45]:60422 "EHLO
        wes1-so2.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726469AbfAITJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:09:46 -0500
Received: from localhost (ip4-46-39-182-135.cust.nbox.cz [46.39.182.135])
        by wes1-so2.wedos.net (Postfix) with ESMTPSA id 43Zdwn2h7hzrC;
        Wed,  9 Jan 2019 20:09:45 +0100 (CET)
Date:   Wed, 9 Jan 2019 20:09:42 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Subject: [PATCH 1/1] MAINTAINERS: fix bad file reference into Documentation
Message-ID: <4b57943b57cb76af841015ec0ca04fd15f7e081f.1547060579.git.ottosabart@seberm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There is no `samsung,exynos5250-trng.txt` file in the documentation and
I do not think it ever existed.

Signed-off-by: Otto Sabart <ottosabart@seberm.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32d444476a90..609451bf2b1a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13309,7 +13309,6 @@ M:	=C5=81ukasz Stelmach <l.stelmach@samsung.com>
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
 F:	drivers/char/hw_random/exynos-trng.c
-F:	Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt
=20
 SAMSUNG FRAMEBUFFER DRIVER
 M:	Jingoo Han <jingoohan1@gmail.com>
--=20
2.17.2


--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlw2RvYACgkQgjuumfi+
HjwQ3xAAmobs8XSkOhZ8R/FmlhJU3V5gU+B/EiLh3fBiuOR0/OqX2zQEa8I9uNE6
nJcaZN+Eqi75OfJq9jr4hD3RRiVEuEjMxyRlmMEXayn3bqNlstaXPqUkB7Dwtqh4
h1+JSE4FkzNW1CNCpyPi5L+SDJUv24/3ayiuiXeTGgSPjqNd3JtJBSfXCEFPwYuN
DIue2oz9I1mnicgzExxs6MYpvu+G32Mi1eBbHOShwubTan0rxBXVOVi88ocjMh1j
D4coMtnLTRAg7diW6xOt4DkW9TikWPNXLFj0kfLw9XNjsXKho72QpPvpuJrTHISX
QEdnUsTc4zI07wsPRYUJnSrN4gxpIzj7HoKUvySEe5KKmiXBcXS16U6pgnu6K0fr
CJeRskOAVLOvzrOJ+O1V+6A1TmO95q5XQl29VCOz33pHXuqTQFWKIVZJK5KLrMvn
6AGwWfzwW2CO2DaaDmIPwiqsguTXlZ0Q2RCeL/LqEFwqLkebtUSPisQnFNqGiMnn
HPHiCIS3vKhDRRcf7v7asWx7Ehy1TXdjyQlHO8/dNKbgghEi2FA10xWA5zPF7Cul
+ICelCispICK02Ja7ab6OBLEW1OEzmdWN/JwyEqry4PvMXpBQ4SJA+ofExGx7JUg
q59maZNOorfS1dw8+6EyE1gyB4ZHQL64ddmTH7pKbn+w7hfEqDY=
=HybD
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
