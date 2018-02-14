Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161539AbeBNRrX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:47:23 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54962 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161313AbeBNRrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:47:22 -0500
X-Google-Smtp-Source: AH8x224wxGHkDcJF+Fkzzv+hE+DwUx3yGFArwdqelzpBg4hPwn+xH33/fi7O+/aJ4IM7VIff06l2Rw==
From: Matteo Croce <mcroce@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Matt Mackall <mpm@selenic.com>,
        Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH] bloat-o-meter: fix typo in help
Date: Wed, 14 Feb 2018 18:47:18 +0100
Message-Id: <20180214174718.4445-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the bloat-o-meter script has two typos in the help, fix both.

Fixes: 192efb7a1f9b ("bloat-o-meter: provide 3 different arguments for data, function and All")
Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 scripts/bloat-o-meter | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/bloat-o-meter b/scripts/bloat-o-meter
index 94b664817ad9..d84a5674e95e 100755
--- a/scripts/bloat-o-meter
+++ b/scripts/bloat-o-meter
@@ -15,7 +15,7 @@ signal(SIGPIPE, SIG_DFL)
 if len(sys.argv) < 3:
     sys.stderr.write("usage: %s [option] file1 file2\n" % sys.argv[0])
     sys.stderr.write("The options are:\n")
-    sys.stderr.write("-c	cateogrize output based on symbole type\n")
+    sys.stderr.write("-c	categorize output based on symbol type\n")
     sys.stderr.write("-d	Show delta of Data Section\n")
     sys.stderr.write("-t	Show delta of text Section\n")
     sys.exit(-1)
-- 
2.14.3
