Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034608AbeEXTia (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:38:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37909 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968846AbeEXTiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:38:22 -0400
X-Google-Smtp-Source: AB8JxZo1eUgwifJmbPF3h36RBS2GYHZBY/fznHEYWQ8L1749QWGOIVPiL20qI4VnvF5bDUfn2go0oA==
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] MAINTAINERS: add PhoenixRC Flight Controller Adapter
Date: Thu, 24 May 2018 21:37:36 +0200
Message-Id: <20180524193736.7129-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for PhoenixRC Flight Controller Adapter

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9051a9ca24a2..feb02e9568e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11117,6 +11117,12 @@ S:	Maintained
 F:	include/linux/personality.h
 F:	include/uapi/linux/personality.h
 
+PHOENIX RC FLIGHT CONTROLLER ADAPTER
+M	Marcus Folkesson <marcus.folkesson@gmail.com>
+S:	Maintained
+F:	Documentation/input/devices/pxrc.rst
+F:	drivers/input/joystick/pxrc.c
+
 PHONET PROTOCOL
 M:	Remi Denis-Courmont <courmisch@gmail.com>
 S:	Supported
-- 
2.16.2
