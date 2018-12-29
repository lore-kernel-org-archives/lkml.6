Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E45AC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3BB2087F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeL2SOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 13:14:30 -0500
Received: from wes1-so2.wedos.net ([46.28.106.16]:50746 "EHLO
        wes1-so2.wedos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbeL2SOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 13:14:30 -0500
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Dec 2018 13:14:29 EST
Received: from localhost (ip4-46-39-182-135.cust.nbox.cz [46.39.182.135])
        by wes1-so2.wedos.net (Postfix) with ESMTPSA id 43Rs1Z3P2hzr3;
        Sat, 29 Dec 2018 19:05:22 +0100 (CET)
Date:   Sat, 29 Dec 2018 19:05:18 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] doc: net: fix bad references to network drivers
Message-ID: <20181229180518.GA8680@personal>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix "reference to nonexisting document" warnings.

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

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlwnt14ACgkQgjuumfi+
HjzXyA//SaG3lvpKqzBPMNwHNlo/YCnQTyTAszJ+LFYirvojaxRF+MdDkkY4W4Ct
J+zen0VgZ2VfhDyfg6di7YCEnFL+QoC7yrBscD8vevaWtTr5Y+4G2ROR/erZINUf
neSGiBIlLVZ4wVR7GUf4T8juHUjk1sZGEScsW8fM9uw4Yze1kwsBEyqWVZyMF4ra
pSNV6KmnxgGuNspg5/DaeL16r+buGaoOA7agaKbi5WVX0AhjAPXcz4gIpM/MpBWF
zw86tiZYoQNPDlAIpvwJU531vaxcVmnLkvdJFSHua4o9iAYdabCWAi68LOR04k2z
6XNbKLQfQMEZtN2Gvl9ZeRy7bEmFV5fu09MU8qn242nscdOF1wCVOXEU42J+XwMa
k5MI6BHLehDnJn/OWIqdSpBwFrVhQ73qJXgA9bmTUKEhyrGXb6M9fOWnhZbsm/Dz
KTjajKOotooJkNHjjnAIcjCRt6XrrP0np9xXlC1VMCvLWyo40M2IwZe5KmFAwovj
BTfkYmVxrtgtojHIB1glHybZpJLMRBu97jjnBjmcuDGxxSjqdRTSk0S5XzQgrSBe
t0m51Pn4DvmUdhPK1zTRXjXYsYVu2KHGcl7HTFHbpeuosHgc+zEJkh2bGp4Zpvu6
NGP6714Qf79YvoFL2AWOmymXXjg2BmO+NkJpHObL92CGXwzTqhs=
=EXA4
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
