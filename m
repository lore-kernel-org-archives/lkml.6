Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC85ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1F720866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1F720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dh-electronics.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeKESHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:07:15 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:54139 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeKESHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:07:14 -0500
Received: from sun05.dh.corp ([188.193.90.127]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPA (Nemesis) id
 1MkHEN-1feFGg0cP3-00ke6s; Mon, 05 Nov 2018 09:48:31 +0100
Received: from sun05.dh.corp ([188.193.90.127]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPA (Nemesis) id
 1MkHEN-1feFGg0cP3-00ke6s; Mon, 05 Nov 2018 09:48:31 +0100
Received: from sun1049.dh.corp (unknown [10.64.9.49])
        by sun05.dh.corp (Postfix) with ESMTP id D38261FA48;
        Mon,  5 Nov 2018 09:48:29 +0100 (CET)
Received: from localhost (10.64.31.3) by sun1049.dh.corp (10.64.9.49) with
 Microsoft SMTP Server id 14.3.408.0; Mon, 5 Nov 2018 09:48:35 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.de>
To:     <corbet@lwn.net>, <linux-doc@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <C.Emde@osadl.org>
Subject: [PATCH 1/2] Docs/EDID: Fixed erroneous bits of XOFFSET, XPULSE, YOFFSET and YPULSE
Date:   Mon, 5 Nov 2018 09:48:34 +0100
Message-ID: <1541407715-5417-2-git-send-email-cniedermaier@dh-electronics.de>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1541407715-5417-1-git-send-email-cniedermaier@dh-electronics.de>
References: <1541407715-5417-1-git-send-email-cniedermaier@dh-electronics.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.64.31.3]
X-Provags-ID: V03:K1:ek0VsIyVf54nywl2erJ+i6j2SW8DidCap21KjQKZ75PGeO7Ob6Y
 jqABoggXqAz6uLWltNjQ8nxn8RPBoWbJm2FrN7H9e6393hdzSB3z1GmB0kNOTwDPsCxOGGt
 /mNY6EBF/dCjPYdTqhe1USQ7l8Mbf2no1dqC2W9YJ2aNfCZItT3s5VK8BWyQYHPD4bB/lLt
 NOlu71sp3TZm2QYLuYQvA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:31c1bPxj3i4=:n6TrqbK/ABRX8nSQWK/jJZ
 /urDiCqcd/3yHR9Cgjn4mt1mPC5KIZ7EZwQnzTj1UcaiGdFGuCe1GI5jtRsDxJ5kWlxkChZHx
 T19ZUUbvwZgzJXSEizEw4EFAnC3MgFFohxFJKfy5lfHc5lJ2rdUpR1ZNmnFRbflSwwdJdFTwl
 4YN0FCRC/14eU0HN90Q9inEPJZshYgxjOBYx60JIndVNhSIKTm8qj9tXk21lBH64zj6oTXC/u
 KOhzfUrPQq7J/uqM09Qg9p9uzbnLiD3P1cE8/O+D9b1rnTqAYKCHzukiiL21l6JWsKB2o68KF
 8vNrxXgFli2kMcez/By4hsQ1x3zQkaHiXawdlZFKrNRIRGw1/p6i03tIYFWpAfroTyLapFIlS
 fYJ9RtB6JVTn4P5dYkiB2tNUppGjVXKyUSk12wI9RpmvP56lSupXUMHMFoVAmAS3ZG+1GXI3e
 CkimbMwiCH25gBce99ROixSf5tvkM7/X9GYDzz70eFvoBLfA2hscC2wHqYbA5OwKYixd5dXFK
 7Ofo+psPMRzSu/uarQvRnXI6U6sv8Y3zDnVMmJhCLNcq+MfZILYslaisbY1LcxLB3nQMBZDkM
 PhTquy72rA3zWYW1CTxBXu5+9WIDfW+o98b7tQBWCrmMaYdG1WbbDCDXbsHMgBgp03v0l//RD
 RV/N7xgcU69j6uiOpwgUryKBW6PQmoRdher5flNfuXMjcW6obAME0rbnV+HGMqYIQGXddSwVr
 zLfy6vp0aVSYZYfO8ZrghEzGC6AKs6pUeEUjP848+6qICZB7lYwkPS/FJSmTcW1rXEWH9wXAq
 4S084mKyH4jyeNZQ11vD6TGSVxR9jmujsj+qQth1ww2uWAUbGM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem was found when EDID data sets for displays other
than the provided samples were generated. The patch has
no effect on the provided samples that still match the data
used in drivers/gpu/drm/drm_edid_load.c.

The provided samples use small values for XOFFSET, XPULSE,
YOFFSET and YPULSE, where the error doesn't occur. This fix
corrects the use of that values in case of high values, because
the most significant bits were treated incorrectly.

So in edid.S msbs4 should use bit 8 and 9 of XOFFSET and XPULS.
For YOFFSET and YPULSE msbs4 should use bit 4 and 5.

lsbs2 was introduced for a better overview, without
functional change.

Removing also the useless value 63 of all files, because
it is added in the *.S description files and then it is
subtracted in edid.S.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.de>
Reviewed-by: Carsten Emde <C.Emde@osadl.org>
---
 Documentation/EDID/1024x768.S  |  4 ++--
 Documentation/EDID/1280x1024.S |  4 ++--
 Documentation/EDID/1600x1200.S |  4 ++--
 Documentation/EDID/1680x1050.S |  4 ++--
 Documentation/EDID/1920x1080.S |  4 ++--
 Documentation/EDID/800x600.S   |  4 ++--
 Documentation/EDID/HOWTO.txt   |  4 ++--
 Documentation/EDID/edid.S      | 10 ++++++----
 8 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/Documentation/EDID/1024x768.S b/Documentation/EDID/1024x768.S
index 6f3e4b7..ff4013e 100644
--- a/Documentation/EDID/1024x768.S
+++ b/Documentation/EDID/1024x768.S
@@ -31,8 +31,8 @@
 #define YBLANK 38
 #define XOFFSET 8
 #define XPULSE 144
-#define YOFFSET (63+3)
-#define YPULSE (63+6)
+#define YOFFSET 3
+#define YPULSE 6
 #define DPI 72
 #define VFREQ 60 /* Hz */
 #define TIMING_NAME "Linux XGA"
diff --git a/Documentation/EDID/1280x1024.S b/Documentation/EDID/1280x1024.S
index bd9bef2a..ce0e85b 100644
--- a/Documentation/EDID/1280x1024.S
+++ b/Documentation/EDID/1280x1024.S
@@ -31,8 +31,8 @@
 #define YBLANK 42
 #define XOFFSET 48
 #define XPULSE 112
-#define YOFFSET (63+1)
-#define YPULSE (63+3)
+#define YOFFSET 1
+#define YPULSE 3
 #define DPI 72
 #define VFREQ 60 /* Hz */
 #define TIMING_NAME "Linux SXGA"
diff --git a/Documentation/EDID/1600x1200.S b/Documentation/EDID/1600x1200.S
index a45101c..5eeb751 100644
--- a/Documentation/EDID/1600x1200.S
+++ b/Documentation/EDID/1600x1200.S
@@ -31,8 +31,8 @@
 #define YBLANK 50
 #define XOFFSET 64
 #define XPULSE 192
-#define YOFFSET (63+1)
-#define YPULSE (63+3)
+#define YOFFSET 1
+#define YPULSE 3
 #define DPI 72
 #define VFREQ 60 /* Hz */
 #define TIMING_NAME "Linux UXGA"
diff --git a/Documentation/EDID/1680x1050.S b/Documentation/EDID/1680x1050.S
index b0d7c69..ec67950 100644
--- a/Documentation/EDID/1680x1050.S
+++ b/Documentation/EDID/1680x1050.S
@@ -31,8 +31,8 @@
 #define YBLANK 39
 #define XOFFSET 104
 #define XPULSE 176
-#define YOFFSET (63+3)
-#define YPULSE (63+6)
+#define YOFFSET 3
+#define YPULSE 6
 #define DPI 96
 #define VFREQ 60 /* Hz */
 #define TIMING_NAME "Linux WSXGA"
diff --git a/Documentation/EDID/1920x1080.S b/Documentation/EDID/1920x1080.S
index 3084355e..e0657af 100644
--- a/Documentation/EDID/1920x1080.S
+++ b/Documentation/EDID/1920x1080.S
@@ -31,8 +31,8 @@
 #define YBLANK 45
 #define XOFFSET 88
 #define XPULSE 44
-#define YOFFSET (63+4)
-#define YPULSE (63+5)
+#define YOFFSET 4
+#define YPULSE 5
 #define DPI 96
 #define VFREQ 60 /* Hz */
 #define TIMING_NAME "Linux FHD"
diff --git a/Documentation/EDID/800x600.S b/Documentation/EDID/800x600.S
index 6644e26..b6853b2 100644
--- a/Documentation/EDID/800x600.S
+++ b/Documentation/EDID/800x600.S
@@ -28,8 +28,8 @@
 #define YBLANK 28
 #define XOFFSET 40
 #define XPULSE 128
-#define YOFFSET (63+1)
-#define YPULSE (63+4)
+#define YOFFSET 1
+#define YPULSE 4
 #define DPI 72
 #define VFREQ 60 /* Hz */
 #define TIMING_NAME "Linux SVGA"
diff --git a/Documentation/EDID/HOWTO.txt b/Documentation/EDID/HOWTO.txt
index 835db33..7d05a7d 100644
--- a/Documentation/EDID/HOWTO.txt
+++ b/Documentation/EDID/HOWTO.txt
@@ -45,8 +45,8 @@ EDID:
 
 #define YPIX vdisp
 #define YBLANK vtotal-vdisp
-#define YOFFSET (63+(vsyncstart-vdisp))
-#define YPULSE (63+(vsyncend-vsyncstart))
+#define YOFFSET vsyncstart-vdisp
+#define YPULSE vsyncend-vsyncstart
 
 The CRC value in the last line
   #define CRC 0x55
diff --git a/Documentation/EDID/edid.S b/Documentation/EDID/edid.S
index ef082dc..c3d1381 100644
--- a/Documentation/EDID/edid.S
+++ b/Documentation/EDID/edid.S
@@ -47,9 +47,11 @@
 #define mfgname2id(v1,v2,v3) \
 	((((v1-'@')&0x1f)<<10)+(((v2-'@')&0x1f)<<5)+((v3-'@')&0x1f))
 #define swap16(v1) ((v1>>8)+((v1&0xff)<<8))
+#define lsbs2(v1,v2) (((v1&0x0f)<<4)+(v2&0x0f))
 #define msbs2(v1,v2) ((((v1>>8)&0x0f)<<4)+((v2>>8)&0x0f))
 #define msbs4(v1,v2,v3,v4) \
-	(((v1&0x03)>>2)+((v2&0x03)>>4)+((v3&0x03)>>6)+((v4&0x03)>>8))
+	((((v1>>8)&0x03)<<6)+(((v2>>8)&0x03)<<4)+\
+	(((v3>>4)&0x03)<<2)+((v4>>4)&0x03))
 #define pixdpi2mm(pix,dpi) ((pix*25)/dpi)
 #define xsize pixdpi2mm(XPIX,DPI)
 #define ysize pixdpi2mm(YPIX,DPI)
@@ -200,9 +202,9 @@ y_msbs:		.byte	msbs2(YPIX,YBLANK)
 x_snc_off_lsb:	.byte	XOFFSET&0xff
 /* Horizontal sync pulse width pixels 8 lsbits (0-1023) */
 x_snc_pls_lsb:	.byte	XPULSE&0xff
-/* Bits 7-4 	Vertical sync offset lines 4 lsbits -63)
-   Bits 3-0 	Vertical sync pulse width lines 4 lsbits -63) */
-y_snc_lsb:	.byte	((YOFFSET-63)<<4)+(YPULSE-63)
+/* Bits 7-4 	Vertical sync offset lines 4 lsbits (0-63)
+   Bits 3-0 	Vertical sync pulse width lines 4 lsbits (0-63) */
+y_snc_lsb:	.byte	lsbs2(YOFFSET, YPULSE)
 /* Bits 7-6 	Horizontal sync offset pixels 2 msbits
    Bits 5-4 	Horizontal sync pulse width pixels 2 msbits
    Bits 3-2 	Vertical sync offset lines 2 msbits
-- 
2.1.4

