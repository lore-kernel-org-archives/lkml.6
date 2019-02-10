Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAFCC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955D021736
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfBJRNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:13:20 -0500
Received: from mout.gmx.net ([212.227.17.22]:45519 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbfBJRNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:13:19 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MAQMg-1gmr2z3i2M-00BdVO; Sun, 10
 Feb 2019 18:13:12 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        Michael Rodin <michael-git@rodin.online>,
        Minghui Liu <minghui.liu.95@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: process: Remove outdated info about -git patches
Date:   Sun, 10 Feb 2019 18:12:59 +0100
Message-Id: <20190210171300.29613-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ne/n2nt2NCY/z5BBLwg6CsLy2INPVZTMxvGaaVuhr1aRBLw1Fv5
 bI0XQgf0b9mSUicf8Sv9ZuvamGPRRVJB40cN5GzoOoRxz+U9gkmYOKxFGQ8TBLOEdocbG8I
 dBC/5otkJsEEaF17d2J83pQx/XsG5raUm5nz2yEGm2DvaSs+iJ2ENSERvky3KzoROwSRsTy
 gSkWVwIWgjamn6VPXW9MA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yPCI9k78WLM=:PqNRkwg683gaFu2U6TL5SB
 OiLi25fOfsaHlAFExC3hrqQwC7QCw39uWKUli/RAX64Q5tGSWI/uUXgPsxjiFRDM7gdMYjWSM
 GVCw+GrHGYtvIKbtBmiYqj5nb7RKX30PlVSpYmnH9N+ipFDWwtw6UZvgWJWmMroAn1zp1Sk53
 6oe6iVTqx7nqo1n3Tl3j074tcT0GzkbTty4YPFcSkszXRbNPEmxDPCA9zKTXD1yIv/cl3Nc45
 eHVy80VOeY7JaAW/7/SroQgMwLvDxn+ueFpSL8SKgL7sxWTFIlLk3UEJm1f1aKw5qubbPhzS3
 wGLWcQF6jvx7rw/MA5qcvJl2/N4s529cQ1vBV5RLvuy2ctKl5czkBV2VI2auX0qZULSHEzPmR
 CgQ19IofXF/oNxZD+9dM5jaqP1VfgZOaWHVfyJGgHG6h+jVWILpBxbLY4VZ/b14svqSFEkGBa
 4f0+fqiY5JgquR9YH+kU1E3M4K4uBbAkf5IgJ6tWokA8XDFv7BCajDNJEpJgi3Ow5u937oYHg
 Q0URg+PIH18xGkrykjJAMWz7WSSKWsBQB17OWI9KS+cEdhcg+SjZMGOCMkOwUGFemPOBuOBDa
 Ff75c/S3jDVJq5zEoiTqic460de5PCSHcfXQ+jO0gsWz5+xTu0b3eKw0Hg20EOE7THhhmlxK9
 3rbsitX3pOh+yoXIMR7+63kyb973Msq/C9IOhjkkyx4kkANlR74+BZ2DCE5vhmYVEQJd1OHt1
 ee6BI5Tr/oqAbgT7vzm2ZPDYKDZe8v4rHSbqBG178PL9kH6xcO/L3yoRLENtMuT+WCt+eG87G
 DUTN7biGzsciXtJo0Tm6wwJw3BlXjZ2Qy9F0k43xxP9iMdq3+r/RYqdB805VhwTfMLp2Lt6Le
 +YjcUql0XHqA+SoV0Hw9/z4UPJTIor9s5WZPohZ88HQAIntBVgJn+XgVwuyBvhqtPOdbsYjtg
 fi71LihaioA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As can be seen by clicking around the timeline on web.archive.org[1],
there were no -git patches/tarballs on kernel.org since release 3.1.

[1]: https://web.archive.org/web/20111103073843/http://www.kernel.org/

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 Documentation/process/howto.rst | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index 58b2f46c4f98..00c8ddd2ed2c 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -302,15 +302,6 @@ The file :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rule
 in the kernel tree documents what kinds of changes are acceptable for
 the -stable tree, and how the release process works.
 
-4.x -git patches
-~~~~~~~~~~~~~~~~
-
-These are daily snapshots of Linus' kernel tree which are managed in a
-git repository (hence the name.) These patches are usually released
-daily and represent the current state of Linus' tree.  They are more
-experimental than -rc kernels since they are generated automatically
-without even a cursory glance to see if they are sane.
-
 Subsystem Specific kernel trees and patches
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.20.1

