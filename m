Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E54C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E9B20661
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfAHX47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:56:59 -0500
Received: from wes1-so2.wedos.net ([46.28.106.16]:40512 "EHLO
        wes1-so2.wedos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbfAHX46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:56:58 -0500
Received: from localhost (ip4-46-39-182-135.cust.nbox.cz [46.39.182.135])
        by wes1-so2.wedos.net (Postfix) with ESMTPSA id 43Z8Lb6RfFzWy;
        Wed,  9 Jan 2019 00:56:55 +0100 (CET)
Date:   Wed, 9 Jan 2019 00:56:51 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 1/1] doc: trace: fix reference to cpuidle documentation file
Message-ID: <f9650f8f9d085a47caf3db1baa41310d6646ae00.1546991610.git.ottosabart@seberm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Old cpuidle/sysfs.txt file was replaced in aa5eee355b46. So, refer to
an updated file.

Fixes: aa5eee355b46 ("Documentation: admin-guide: PM: Add cpuidle document")
Signed-off-by: Otto Sabart <ottosabart@seberm.com>
---
 Documentation/trace/coresight-cpu-debug.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/coresight-cpu-debug.txt b/Documentation/tr=
ace/coresight-cpu-debug.txt
index 89ab09e78e8d..f07e38094b40 100644
--- a/Documentation/trace/coresight-cpu-debug.txt
+++ b/Documentation/trace/coresight-cpu-debug.txt
@@ -165,7 +165,7 @@ Do some work...
 The same can also be done from an application program.
=20
 Disable specific CPU's specific idle state from cpuidle sysfs (see
-Documentation/cpuidle/sysfs.txt):
+Documentation/admin-guide/pm/cpuidle.rst):
 # echo 1 > /sys/devices/system/cpu/cpu$cpu/cpuidle/state$state/disable
=20
=20
--=20
2.17.2


--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlw1OMMACgkQgjuumfi+
Hjy1gQ//RuHvTrIJhx27Rt8Wiula8M+FF34Y5bxFzXGbY3QSBTK5TnzlKdusnBU7
hVvg+ICmFQp477MvMjD4y8Y7RDen1p02rY8GgyKnnMfKpSp+bUG9gpa6F52uMPR3
iIXzGb7YjMx/0u7sgsVup65BQGPJsebvLdSE79usHAdjAsqDdh1wy5DdIHQ2LIW2
BxhZmKa7zy3bHgdCIWWj16VjTqSJzVblQfhD/2Tidtvgkty2f471BCgWABaS/q6q
jYQ5IavmDzR91GefuVPqgaFK20MKNFdiBc5fQgcLpTUv/nm1MD7go1NNgCgxphO4
8Hpj8bJJtNpIO/xYcLBawyf9/etuhagC0okeGK87mcn7Rm5vQEhftpUom4pidlE4
t8EZTpYQktPO+NM/FPZHkwi2zJeUQto73gXrrdtf7aBCCO1XA4N/iVQqORQPHsvh
gn85ejVgETwxJ3h5SW8zYBRx3jBv0ndi2EZfsiQguuWcWD2iDnzYFxh1YIJ37/0f
s/bi8MgXMKJFARpH1o+smmt5aPQ/JyPc9VES3bfn2LeeHN6LlXT0TRBHsSdfWF/Q
RLHmty89NAHAiIzvqQK4Y5EHxDK6Qgl/RtzGSbPe/O3fL8d31dlApxxReMW+cxUe
eL+e7gnqJu1007g9XwinErnY53JmDG/pmgItZeqWgn/BqoED2mQ=
=pfPL
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
