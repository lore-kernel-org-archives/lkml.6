Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966222AbeE2Suz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:50:55 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40556 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966058AbeE2Suq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:50:46 -0400
X-Google-Smtp-Source: AB8JxZoGXOpccjglz156adc+h0HamElAReE5+qxmSb41T57ZLiyUGy+DJvNhfbcq6WrPFuLxGYT+pQ==
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
Subject: [PATCH v3 3/3] MAINTAINERS: add USB CCID Gadget Device
Date: Tue, 29 May 2018 20:50:21 +0200
Message-Id: <20180529185021.13738-3-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180529185021.13738-1-marcus.folkesson@gmail.com>
References: <20180529185021.13738-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for USB CCID Gadget Device

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v3:
    	- No changes
    v2:
    	- No changes

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
