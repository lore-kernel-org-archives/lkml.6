Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032988AbeEXTxS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:53:18 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51601 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967986AbeEXTxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:53:15 -0400
X-Google-Smtp-Source: ADUXVKIlnGDGPisGHi/ZVVnVqekRjx26AD1sHLHvKtb1jsF11W4WEAYQQpecMVrECx6gOOqKaFw1lA==
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v2] MAINTAINERS: add PhoenixRC Flight Controller Adapter
Date: Thu, 24 May 2018 21:52:59 +0200
Message-Id: <20180524195259.15280-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for PhoenixRC Flight Controller Adapter

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v2:
    	Add proper mailing list

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ce5062dc028..d8b5d9f810e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11103,6 +11103,13 @@ S:	Maintained
 F:	include/linux/personality.h
 F:	include/uapi/linux/personality.h
 
+PHOENIX RC FLIGHT CONTROLLER ADAPTER
+M:	Marcus Folkesson <marcus.folkesson@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/input/devices/pxrc.rst
+F:	drivers/input/joystick/pxrc.c
+
 PHONET PROTOCOL
 M:	Remi Denis-Courmont <courmisch@gmail.com>
 S:	Supported
-- 
2.16.2
