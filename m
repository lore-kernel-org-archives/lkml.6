Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753358AbeDLSp1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 14:45:27 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43583 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753081AbeDLSp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 14:45:26 -0400
X-Google-Smtp-Source: AIpwx48tCXb8CdbJil0R+O8aNHsNjvRcavv6O7B3cx5+9rZwE4x+9cEjbivxph2bb+prgxJixfgawg==
Date: Thu, 12 Apr 2018 20:45:03 +0200
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To: Willy Tarreau <w@1wt.eu>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: panel: Update file paths: drivers/{misc =>
 auxdisplay}/
Message-ID: <20180412184503.mva5zmw4qryo73x6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Willy Tarreau <w@1wt.eu>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f030e360f905..c42a4395b382 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10420,8 +10420,8 @@ PARALLEL LCD/KEYPAD PANEL DRIVER
 M:	Willy Tarreau <willy@haproxy.com>
 M:	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
 S:	Odd Fixes
-F:	Documentation/misc-devices/lcd-panel-cgram.txt
-F:	drivers/misc/panel.c
+F:	Documentation/auxdisplay/lcd-panel-cgram.txt
+F:	drivers/auxdisplay/panel.c
 
 PARALLEL PORT SUBSYSTEM
 M:	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
-- 
2.14.1
