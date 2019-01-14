Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15039C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E5A20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfANL4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:56:41 -0500
Received: from wes1-so1-b.wedos.net ([46.28.106.43]:58209 "EHLO
        wes1-so1.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726339AbfANL4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:56:41 -0500
Received: from localhost (ovpn-brq.redhat.com [213.175.37.11])
        by wes1-so1.wedos.net (Postfix) with ESMTPSA id 43dX4k38YVz2fC;
        Mon, 14 Jan 2019 12:56:38 +0100 (CET)
Date:   Mon, 14 Jan 2019 12:56:36 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/1 RESEND] doc: net: fix bad references to network drivers
Message-ID: <f6af749d99cf7dd9e5ba90824d0fe898ae69c793.1547466751.git.ottosabart@seberm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix "reference to nonexisting document" warnings.

Fixes: b255e500c8dc ("net: documentation: build a directory structure
for drivers")
Signed-off-by: Otto Sabart <ottosabart@seberm.com>
---
 Documentation/networking/index.rst | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/networking/index.rst b/Documentation/networking/=
index.rst
index 6a47629ef8ed..59e86de662cd 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -11,19 +11,19 @@ Contents:
    batman-adv
    can
    can_ucan_protocol
-   dpaa2/index
-   e100
-   e1000
-   e1000e
-   fm10k
-   igb
-   igbvf
-   ixgb
-   ixgbe
-   ixgbevf
-   i40e
-   iavf
-   ice
+   device_drivers/freescale/dpaa2/index
+   device_drivers/intel/e100
+   device_drivers/intel/e1000
+   device_drivers/intel/e1000e
+   device_drivers/intel/fm10k
+   device_drivers/intel/igb
+   device_drivers/intel/igbvf
+   device_drivers/intel/ixgb
+   device_drivers/intel/ixgbe
+   device_drivers/intel/ixgbevf
+   device_drivers/intel/i40e
+   device_drivers/intel/iavf
+   device_drivers/intel/ice
    kapi
    z8530book
    msg_zerocopy
--=20
2.17.2


--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlw8ePIACgkQgjuumfi+
HjxgLw/+LVoxtrmmkC9y6jPbUymOiZnGUokAg7pf8ts10rCDfUMKBdvlDst5JybH
FJ8v35LQ8YdpCQdtneLBcrQ0ZtbWfZA4RgFOr0TAu7bGLDVZ1vFqx1pR3mHflHhm
vq9Y/V40XITnXQY1hSKB8UoA7A/tGSoXyCyF30oQX/QfZlnlO9h4xPJmX5Ncz+YT
92DWXw3maWf3UiBbS7q4L3H5dyOtsKXWcLgtRbaEZSOFjMovAY9r5Wp7SqeMxxJK
7cRnV8b1TjQc/jUQATFjhk4n2FCYHJIoswGE222RpfkONMTOJvRuKjDHfqd1NCPc
E+enVQSxlhLDRg4OtUfgtueU4+uT+OtIGct54fOHndQ7q2gi8htzYyWNF4Hlk9aI
NnnwjzGsdJy1OpPDpi66yesugUShH6/m893QN9MjXioV6ooP7Sh+/f1iy5kxMhZL
UKGr2GQbHIrswcE0Y4FLcIP9rs3ZwIa0nJwuZ79Jvnb15q2CRTGoMdABmxifOtzM
W2a3Sg7bUx/iysVz1zmzjq0We97pqxr7J1IWju6rhFiEqFvURf54Wa/Bb1xxdrmZ
eLA5GfLFgL/Odx8lqaNrLUGt2FTEIG0fMt2y5tyBctDNnAdGTaG58YaoRdjQO8kI
YAVWE3wwhCbOYv0lJ31G7EQf4pFUm6GZ8FU923DApjkmqyuqFhE=
=XjHW
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
