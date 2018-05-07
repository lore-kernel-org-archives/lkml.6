Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752010AbeEGJXu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 05:23:50 -0400
Received: from osg.samsung.com ([64.30.133.232]:61215 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751899AbeEGJWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 05:22:54 -0400
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Linux Media Mailing List <linux-media@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: v4l2-dev.h: document VFL_TYPE_MAX
Date: Mon,  7 May 2018 06:22:38 -0300
Message-Id: <0293dccdddd73007013831d7e65834a05827e3f8.1525684917.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup this Sphinx warning:
   read./include/media/v4l2-dev.h:42: warning: Enum value 'VFL_TYPE_MAX' not described in enum 'vfl_devnode_type'

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 include/media/v4l2-dev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/media/v4l2-dev.h b/include/media/v4l2-dev.h
index f60cf9cf3b9c..9e73d7e2cee0 100644
--- a/include/media/v4l2-dev.h
+++ b/include/media/v4l2-dev.h
@@ -30,6 +30,8 @@
  * @VFL_TYPE_SUBDEV:	for V4L2 subdevices
  * @VFL_TYPE_SDR:	for Software Defined Radio tuners
  * @VFL_TYPE_TOUCH:	for touch sensors
+ *
+ * @VFL_TYPE_MAX:	number of elements of &enum vfl_devnode_type
  */
 enum vfl_devnode_type {
 	VFL_TYPE_GRABBER	= 0,
-- 
2.17.0
