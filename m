Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CB8C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 20:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE7D2148E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 20:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfBCUAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 15:00:25 -0500
Received: from wes1-so2.wedos.net ([46.28.106.16]:59250 "EHLO
        wes1-so2.wedos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbfBCUAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 15:00:24 -0500
Received: from localhost (ip4-46-39-182-135.cust.nbox.cz [46.39.182.135])
        by wes1-so2.wedos.net (Postfix) with ESMTPSA id 43t1sf2nPszvK;
        Sun,  3 Feb 2019 21:00:22 +0100 (CET)
Date:   Sun, 3 Feb 2019 21:00:19 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/1] doc: kernel-parameters.txt: fix documentation of
 elevator parameter
Message-ID: <6775e969738a795c578dbc3072f3bebcd6cf7247.1549223107.git.ottosabart@seberm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Legacy IO schedulers (cfq, deadline and noop) were removed in
f382fb0bcef4.

The documentation for deadline was retained because it carries over to
mq-deadline as well, but location of the doc file was changed over time.

The old iosched algorithms were removed from elevator=3D kernel parameter
and mq-deadline, kyber and bfq were added with a reference to their
documentation.

Fixes: f382fb0bcef4 ("block: remove legacy IO schedulers")
Signed-off-by: Otto Sabart <ottosabart@seberm.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
index b799bcf67d7b..2238fb3c7dcf 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1182,9 +1182,10 @@
 			arch/x86/kernel/cpu/cpufreq/elanfreq.c.
=20
 	elevator=3D	[IOSCHED]
-			Format: {"cfq" | "deadline" | "noop"}
-			See Documentation/block/cfq-iosched.txt and
-			Documentation/block/deadline-iosched.txt for details.
+			Format: { "mq-deadline" | "kyber" | "bfq" }
+			See Documentation/block/deadline-iosched.txt,
+			Documentation/block/kyber-iosched.txt and
+			Documentation/block/bfq-iosched.txt for details.
=20
 	elfcorehdr=3D[size[KMG]@]offset[KMG] [IA64,PPC,SH,X86,S390]
 			Specifies physical address of start of kernel core
--=20
2.17.2


--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlxXSE4ACgkQgjuumfi+
HjxFGQ//UBS1wEua/ZrvxRxfVgMyP0irPMoF4T9Jlgh4OEHz4HBAqH5L9eJrxWur
T63zvGElC1qkt0Yrw4gHxVq2vPD70okzSXTMgOTKH2haxPRIukCiTBzCuRlGhSDn
i6t+hMsSpKRJ+n0hHDh13nH6Qae0VxGp6MXmclQZtZry+jEQJTRZiVT/8V10Z65Q
wKzd/Z161wlre0REgzICLpM1fp8JvbiIjBaJwio+ai2uRxcG6+AgwlLK+q2892qg
sM0Ic1txR15A0v/YSrFce8wyWnxfcKky0rF5J3DinWI/MY6MonPG2cYGaGizGDaw
xp4VapD36iTbUVmqKxa4mjRIHWaaTMTqdkn/P+6ssVNnK8svk2E/VTxvgrKjbZYd
vmThTipj4mYJtmNPpNxpp4kUBkv+QNMLx1DADJz4bJ9ybylzzlGBuA6ot5RIu+LT
rkRHPJal6Z7YbVjDo2LqLHjc+0B7vFYQ8jf1YbV2d6q5MpzrzE+GIDbnAYg+VXyA
ObVh1v5DMivmUggT2J+4i0fhCKUmTr7+LDEiT7M0GvZsHFHhuqzx5CZBFlWypqZy
OhRxZi/3YUCbWmL7mIWjdLcJDwXdz3ZsxMpU9QNNVZVcxE7NzvJHswBR4d6Vp2Xq
7GlxyON9P1AA4DUPK/mZZOnXVvrquwnLALaRaRAnrY1dg3bgDPI=
=nh6T
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
