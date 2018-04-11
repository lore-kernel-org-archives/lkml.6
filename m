Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933391AbeDKUT6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 16:19:58 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:45041 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932581AbeDKUTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 16:19:55 -0400
X-Google-Smtp-Source: AIpwx4/NGmH2E/khPrMol1Re0Y3B0OCenaSu1zPPI2QvgNq68boWTRzPZNtMtkk+OwxLROU7vGUWMg==
Date: Wed, 11 Apr 2018 23:19:50 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: [PATCH] proc: fixup =?iso-8859-1?Q?=A9_sig?= =?iso-8859-1?Q?n?=
Message-ID: <20180411201950.GA12904@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew's scripts butchered it :-(

Add copyright in two files before they get autorubberstamped.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/proc-loadavg-001.c        |    2 +-
 tools/testing/selftests/proc/proc-self-map-files-001.c |    2 +-
 tools/testing/selftests/proc/proc-self-map-files-002.c |    2 +-
 tools/testing/selftests/proc/proc-self-syscall.c       |   15 +++++++++++++++
 tools/testing/selftests/proc/proc-self-wchan.c         |   15 +++++++++++++++
 tools/testing/selftests/proc/proc-uptime-001.c         |    2 +-
 tools/testing/selftests/proc/proc-uptime-002.c         |    2 +-
 tools/testing/selftests/proc/proc-uptime.h             |    2 +-
 tools/testing/selftests/proc/read.c                    |    2 +-
 9 files changed, 37 insertions(+), 7 deletions(-)

--- a/tools/testing/selftests/proc/proc-loadavg-001.c
+++ b/tools/testing/selftests/proc/proc-loadavg-001.c
@@ -1,5 +1,5 @@
 /*
- * Copyright _ 2018 Alexey Dobriyan <adobriyan@gmail.com>
+ * Copyright © 2018 Alexey Dobriyan <adobriyan@gmail.com>
  *
  * Permission to use, copy, modify, and distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
--- a/tools/testing/selftests/proc/proc-self-map-files-001.c
+++ b/tools/testing/selftests/proc/proc-self-map-files-001.c
@@ -1,5 +1,5 @@
 /*
- * Copyright _ 2018 Alexey Dobriyan <adobriyan@gmail.com>
+ * Copyright © 2018 Alexey Dobriyan <adobriyan@gmail.com>
  *
  * Permission to use, copy, modify, and distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
--- a/tools/testing/selftests/proc/proc-self-map-files-002.c
+++ b/tools/testing/selftests/proc/proc-self-map-files-002.c
@@ -1,5 +1,5 @@
 /*
- * Copyright _ 2018 Alexey Dobriyan <adobriyan@gmail.com>
+ * Copyright © 2018 Alexey Dobriyan <adobriyan@gmail.com>
  *
  * Permission to use, copy, modify, and distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
--- a/tools/testing/selftests/proc/proc-self-syscall.c
+++ b/tools/testing/selftests/proc/proc-self-syscall.c
@@ -1,3 +1,18 @@
+/*
+ * Copyright © 2018 Alexey Dobriyan <adobriyan@gmail.com>
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
 #define _GNU_SOURCE
 #include <unistd.h>
 #include <sys/syscall.h>
--- a/tools/testing/selftests/proc/proc-self-wchan.c
+++ b/tools/testing/selftests/proc/proc-self-wchan.c
@@ -1,3 +1,18 @@
+/*
+ * Copyright © 2018 Alexey Dobriyan <adobriyan@gmail.com>
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
--- a/tools/testing/selftests/proc/proc-uptime-001.c
+++ b/tools/testing/selftests/proc/proc-uptime-001.c
@@ -1,5 +1,5 @@
 /*
- * Copyright _ 2018 Alexey Dobriyan <adobriyan@gmail.com>
+ * Copyright © 2018 Alexey Dobriyan <adobriyan@gmail.com>
  *
  * Permission to use, copy, modify, and distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
--- a/tools/testing/selftests/proc/proc-uptime-002.c
+++ b/tools/testing/selftests/proc/proc-uptime-002.c
@@ -1,5 +1,5 @@
 /*
- * Copyright _ 2018 Alexey Dobriyan <adobriyan@gmail.com>
+ * Copyright © 2018 Alexey Dobriyan <adobriyan@gmail.com>
  *
  * Permission to use, copy, modify, and distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
--- a/tools/testing/selftests/proc/proc-uptime.h
+++ b/tools/testing/selftests/proc/proc-uptime.h
@@ -1,5 +1,5 @@
 /*
- * Copyright _ 2018 Alexey Dobriyan <adobriyan@gmail.com>
+ * Copyright © 2018 Alexey Dobriyan <adobriyan@gmail.com>
  *
  * Permission to use, copy, modify, and distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
--- a/tools/testing/selftests/proc/read.c
+++ b/tools/testing/selftests/proc/read.c
@@ -1,5 +1,5 @@
 /*
- * Copyright _ 2018 Alexey Dobriyan <adobriyan@gmail.com>
+ * Copyright © 2018 Alexey Dobriyan <adobriyan@gmail.com>
  *
  * Permission to use, copy, modify, and distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
