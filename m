Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032517AbeEZVUO (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 17:20:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37032 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032377AbeEZVUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 17:20:02 -0400
X-Google-Smtp-Source: ADUXVKKnj68AMD4gioHP1DQ3SQvRqyIWy3qtS4zr7nx+jNOSQ4J+FrkXkZiNR8MFjwxF/7Z6iuDfpQ==
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Felipe Balbi <balbi@kernel.org>,
        davem@davemloft.net,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v2 3/3] MAINTAINERS: add USB CCID Gadget Device
Date: Sat, 26 May 2018 23:19:40 +0200
Message-Id: <20180526211940.25474-3-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180526211940.25474-1-marcus.folkesson@gmail.com>
References: <20180526211940.25474-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for USB CCID Gadget Device

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 078fd80f664f..e77c3d2bec89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14541,6 +14541,14 @@ L:	linux-scsi@vger.kernel.org
 S:	Maintained
 F:	drivers/usb/storage/uas.c
 
+USB CCID GADGET
+M:	Marcus Folkesson <marcus.folkesson@gmail.com>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	drivers/usb/gadget/function/f_ccid.*
+F:	include/uapi/linux/usb/ccid.h
+F:	Documentation/usb/gadget_ccid.rst
+
 USB CDC ETHERNET DRIVER
 M:	Oliver Neukum <oliver@neukum.org>
 L:	linux-usb@vger.kernel.org
-- 
2.16.2
