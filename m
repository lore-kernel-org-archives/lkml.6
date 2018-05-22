Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbeEVHcZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:32:25 -0400
Received: from mout.perfora.net ([74.208.4.197]:38853 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751425AbeEVHcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:32:18 -0400
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org, pombredanne@nexb.com
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 7/9] staging: rtl8723bs: Fix spelling/grammar errors in comment.
Date: Tue, 22 May 2018 00:26:35 -0700
Message-Id: <20180522072637.9782-7-quytelda@tamalin.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522072637.9782-1-quytelda@tamalin.org>
References: <20180522072637.9782-1-quytelda@tamalin.org>
X-Provags-ID: V03:K1:avQZV2TTpjVPd8mVkoOo7tas4swLV5Xn3GeZALgGO7QRylCerCu
 zpm2goWzYQWaJfzJbYWRKy8ksodbZpEEHCFx/OA0H/fNRM2TJSyQQPIgj4+VKGOVSphRd1i
 xd1tqje5Y8iZs+cGGw2/RmG8YyalWjlzd38IsjL2oXhqm7Qe66c0OTiUWzS1VWUr4Ra5P4p
 EsCZSzc7mq1Yqq6pEwSnQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PggnfpIkFIA=:OYzm6NPltW2glemQhui7ZT
 m43c1TOW6a8aiChnJK+3sPMpPReACwfrA7YaFFLKEJZGLl1cKucMSWxTVdzndy4BkV0qxLtcl
 SAPM2AW9IKnwQF7A9LqsAm+LcF9akUs4GXhm6MEHsTZAV1IUnAThLN9Q2ZOtY5wce8IzZki6w
 ls2G2/pcwWD6+brFSysbdtfkoQ0snRwgTId4oL34txKcZP9JOFvEzNJ859A7MlUotV/KsrlPh
 4r8X3rieYsmxeItZq9BE+G+Q+Ty2mWKfhnmE8WIb88LTWZfrBc/HNnM9xkSzkKMkLiJAAkQdi
 xsusbAs0B6zxnCbIYwH/l4eDq+pH9GnlRl+J5p5q+9OPd61T5/DZUm9iGLnsmsOyl6BrtDqLY
 UrR5btB7TM0vrrveTuXopkoFLiaWsZhZxCIKr4/tmML/RATjt/XVJXOmRzIe0gpCJqS7jA1CU
 GcOnizztYl9zEj0QWEe4DZVjdJpXyaz1HVxJkFdU8FpDzxDwj3bIzXG0ip3xoaXEivthgtrHZ
 YOG9xtI4tKMbz0Q+L8jrNZX5qbRRGmxPBv8RCmnfXYrP45hnkDNtP0JxyB6p0VSmKfQI+024q
 YaEbvdYfnvrx/cacxRAuv+pVc3D4UP7l6tqKpL6+AFbCgq8AI4G6i+VceIjPcIL/tIbCYSXF8
 TzgXL3R4N+8Hp7S7HM0Ll6ieSUZcuwD/MiBRP9vq3td6XjNCaCg4i3HNr0ZcqTX7Oe2w=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the spelling/grammar errors in the comment block describing
the 'Function' member of 'struct rt_firmware_hdr'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/include/rtl8723b_hal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
index 42f467abc6b5..8897deb963c7 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
@@ -59,8 +59,8 @@ struct rt_firmware_hdr {
 	__le16 Signature;  /* 92C0: test chip; 92C, 88C0: test chip;
 			    * 88C1: MP A-cut; 92C1: MP A-cut */
 	u8 Category;	   /* AP/NIC and USB/PCI */
-	u8 Function;	   /* Reserved for different FW function indcation, for
-			    * further use when driver needs to download
+	u8 Function;	   /* Reserved for different FW function indications,
+			    * for further use when driver needs to download
 			    * different FW in different conditions. */
 	__le16 Version;    /* FW Version */
 	__le16 Subversion; /* FW Subversion, default 0x00 */
-- 
2.17.0
