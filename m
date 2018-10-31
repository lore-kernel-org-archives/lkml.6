Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC92ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EB82080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EB82080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbeKAG7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:59:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45289 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeKAG7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:59:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9VLx99k2557981
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Oct 2018 14:59:09 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9VLx9g32557978;
        Wed, 31 Oct 2018 14:59:09 -0700
Date:   Wed, 31 Oct 2018 14:59:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-a04q6chdyjknm1hr305ulx8h@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, dsahern@gmail.com, hpa@zytor.com,
        tglx@linutronix.de, wangnan0@huawei.com, adrian.hunter@intel.com,
        jolsa@kernel.org, acme@redhat.com, namhyung@kernel.org,
        mingo@kernel.org
Reply-To: jolsa@kernel.org, acme@redhat.com, mingo@kernel.org,
          namhyung@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, hpa@zytor.com, dsahern@gmail.com,
          wangnan0@huawei.com, adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf beauty: Switch from GPL v2.0 to LGPL v2.1
Git-Commit-ID: 794f594e0c3be6199e0b3e2324280e8785806fb6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  794f594e0c3be6199e0b3e2324280e8785806fb6
Gitweb:     https://git.kernel.org/tip/794f594e0c3be6199e0b3e2324280e8785806fb6
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 24 Oct 2018 15:54:23 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 30 Oct 2018 11:46:23 -0300

perf beauty: Switch from GPL v2.0 to LGPL v2.1

The intention is to have this as a library, since it is not perf
specific at all.

I did the switch for the files where I'm the only contributor, with the
exception of a few lines changed by Jiri Olsa.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-a04q6chdyjknm1hr305ulx8h@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/clone.c                     | 3 +--
 tools/perf/trace/beauty/drm_ioctl.sh                | 1 +
 tools/perf/trace/beauty/eventfd.c                   | 2 +-
 tools/perf/trace/beauty/fcntl.c                     | 3 +--
 tools/perf/trace/beauty/flock.c                     | 2 +-
 tools/perf/trace/beauty/futex_op.c                  | 2 +-
 tools/perf/trace/beauty/futex_val3.c                | 2 +-
 tools/perf/trace/beauty/ioctl.c                     | 3 +--
 tools/perf/trace/beauty/kcmp.c                      | 3 +--
 tools/perf/trace/beauty/kcmp_type.sh                | 1 +
 tools/perf/trace/beauty/kvm_ioctl.sh                | 1 +
 tools/perf/trace/beauty/madvise_behavior.sh         | 1 +
 tools/perf/trace/beauty/mmap.c                      | 2 +-
 tools/perf/trace/beauty/mode_t.c                    | 2 +-
 tools/perf/trace/beauty/msg_flags.c                 | 2 +-
 tools/perf/trace/beauty/open_flags.c                | 2 +-
 tools/perf/trace/beauty/perf_event_open.c           | 2 +-
 tools/perf/trace/beauty/perf_ioctl.sh               | 1 +
 tools/perf/trace/beauty/pid.c                       | 3 ++-
 tools/perf/trace/beauty/pkey_alloc.c                | 3 +--
 tools/perf/trace/beauty/pkey_alloc_access_rights.sh | 1 +
 tools/perf/trace/beauty/prctl.c                     | 3 +--
 tools/perf/trace/beauty/prctl_option.sh             | 1 +
 tools/perf/trace/beauty/sched_policy.c              | 2 +-
 tools/perf/trace/beauty/seccomp.c                   | 2 +-
 tools/perf/trace/beauty/signum.c                    | 2 +-
 tools/perf/trace/beauty/sndrv_ctl_ioctl.sh          | 1 +
 tools/perf/trace/beauty/sndrv_pcm_ioctl.sh          | 1 +
 tools/perf/trace/beauty/sockaddr.c                  | 2 +-
 tools/perf/trace/beauty/socket.c                    | 2 +-
 tools/perf/trace/beauty/socket_ipproto.sh           | 1 +
 tools/perf/trace/beauty/socket_type.c               | 2 +-
 tools/perf/trace/beauty/statx.c                     | 3 +--
 tools/perf/trace/beauty/vhost_virtio_ioctl.sh       | 1 +
 tools/perf/trace/beauty/waitid_options.c            | 2 +-
 35 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/tools/perf/trace/beauty/clone.c b/tools/perf/trace/beauty/clone.c
index d64d049ab991..010406500c30 100644
--- a/tools/perf/trace/beauty/clone.c
+++ b/tools/perf/trace/beauty/clone.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.1
 /*
  * trace/beauty/cone.c
  *
  *  Copyright (C) 2017, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
- *
- * Released under the GPL v2. (and only v2, not any later version)
  */
 
 #include "trace/beauty/beauty.h"
diff --git a/tools/perf/trace/beauty/drm_ioctl.sh b/tools/perf/trace/beauty/drm_ioctl.sh
index 9d3816815e60..9aa94fd523a9 100755
--- a/tools/perf/trace/beauty/drm_ioctl.sh
+++ b/tools/perf/trace/beauty/drm_ioctl.sh
@@ -1,4 +1,5 @@
 #!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
 
 [ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/drm/
 
diff --git a/tools/perf/trace/beauty/eventfd.c b/tools/perf/trace/beauty/eventfd.c
index 5d6a477a6400..db5b9b492113 100644
--- a/tools/perf/trace/beauty/eventfd.c
+++ b/tools/perf/trace/beauty/eventfd.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: LGPL-2.1
 #ifndef EFD_SEMAPHORE
 #define EFD_SEMAPHORE		1
 #endif
diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/fcntl.c
index 9e8900c13cb1..e6de31674e24 100644
--- a/tools/perf/trace/beauty/fcntl.c
+++ b/tools/perf/trace/beauty/fcntl.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.1
 /*
  * trace/beauty/fcntl.c
  *
  *  Copyright (C) 2017, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
- *
- * Released under the GPL v2. (and only v2, not any later version)
  */
 
 #include "trace/beauty/beauty.h"
diff --git a/tools/perf/trace/beauty/flock.c b/tools/perf/trace/beauty/flock.c
index c4ff6ad30b06..cf02ae5f0ba6 100644
--- a/tools/perf/trace/beauty/flock.c
+++ b/tools/perf/trace/beauty/flock.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: LGPL-2.1
 
 #include "trace/beauty/beauty.h"
 #include <linux/kernel.h>
diff --git a/tools/perf/trace/beauty/futex_op.c b/tools/perf/trace/beauty/futex_op.c
index 61850fbc85ff..1136bde56406 100644
--- a/tools/perf/trace/beauty/futex_op.c
+++ b/tools/perf/trace/beauty/futex_op.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: LGPL-2.1
 #include <linux/futex.h>
 
 #ifndef FUTEX_WAIT_BITSET
diff --git a/tools/perf/trace/beauty/futex_val3.c b/tools/perf/trace/beauty/futex_val3.c
index 26f6b3253511..138b7d588a70 100644
--- a/tools/perf/trace/beauty/futex_val3.c
+++ b/tools/perf/trace/beauty/futex_val3.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: LGPL-2.1
 #include <linux/futex.h>
 
 #ifndef FUTEX_BITSET_MATCH_ANY
diff --git a/tools/perf/trace/beauty/ioctl.c b/tools/perf/trace/beauty/ioctl.c
index 1be3b4cf0827..5d2a7fd8d407 100644
--- a/tools/perf/trace/beauty/ioctl.c
+++ b/tools/perf/trace/beauty/ioctl.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.1
 /*
  * trace/beauty/ioctl.c
  *
  *  Copyright (C) 2017, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
- *
- * Released under the GPL v2. (and only v2, not any later version)
  */
 
 #include "trace/beauty/beauty.h"
diff --git a/tools/perf/trace/beauty/kcmp.c b/tools/perf/trace/beauty/kcmp.c
index f62040eb9d5c..b276a274f203 100644
--- a/tools/perf/trace/beauty/kcmp.c
+++ b/tools/perf/trace/beauty/kcmp.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.1
 /*
  * trace/beauty/kcmp.c
  *
  *  Copyright (C) 2017, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
- *
- * Released under the GPL v2. (and only v2, not any later version)
  */
 
 #include "trace/beauty/beauty.h"
diff --git a/tools/perf/trace/beauty/kcmp_type.sh b/tools/perf/trace/beauty/kcmp_type.sh
index a3c304caa336..df8b17486d57 100755
--- a/tools/perf/trace/beauty/kcmp_type.sh
+++ b/tools/perf/trace/beauty/kcmp_type.sh
@@ -1,4 +1,5 @@
 #!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
 
 [ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
diff --git a/tools/perf/trace/beauty/kvm_ioctl.sh b/tools/perf/trace/beauty/kvm_ioctl.sh
index c4699fd46bb6..4ce54f5bf756 100755
--- a/tools/perf/trace/beauty/kvm_ioctl.sh
+++ b/tools/perf/trace/beauty/kvm_ioctl.sh
@@ -1,4 +1,5 @@
 #!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
 
 [ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
diff --git a/tools/perf/trace/beauty/madvise_behavior.sh b/tools/perf/trace/beauty/madvise_behavior.sh
index 431639eb4d29..4527d290cdfc 100755
--- a/tools/perf/trace/beauty/madvise_behavior.sh
+++ b/tools/perf/trace/beauty/madvise_behavior.sh
@@ -1,4 +1,5 @@
 #!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
 
 [ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/asm-generic/
 
diff --git a/tools/perf/trace/beauty/mmap.c b/tools/perf/trace/beauty/mmap.c
index 9f68077b241b..0605593552c6 100644
--- a/tools/perf/trace/beauty/mmap.c
+++ b/tools/perf/trace/beauty/mmap.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: LGPL-2.1
 #include <uapi/linux/mman.h>
 
 static size_t syscall_arg__scnprintf_mmap_prot(char *bf, size_t size,
diff --git a/tools/perf/trace/beauty/mode_t.c b/tools/perf/trace/beauty/mode_t.c
index d929ad7dd97b..6879d36d3004 100644
--- a/tools/perf/trace/beauty/mode_t.c
+++ b/tools/perf/trace/beauty/mode_t.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: LGPL-2.1
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
diff --git a/tools/perf/trace/beauty/msg_flags.c b/tools/perf/trace/beauty/msg_flags.c
index c064d6aae659..1b9d6306d274 100644
--- a/tools/perf/trace/beauty/msg_flags.c
+++ b/tools/perf/trace/beauty/msg_flags.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: LGPL-2.1
 #include <sys/types.h>
 #include <sys/socket.h>
 
diff --git a/tools/perf/trace/beauty/open_flags.c b/tools/perf/trace/beauty/open_flags.c
index 6aec6178a99d..cc673fec9184 100644
--- a/tools/perf/trace/beauty/open_flags.c
+++ b/tools/perf/trace/beauty/open_flags.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: LGPL-2.1
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
diff --git a/tools/perf/trace/beauty/perf_event_open.c b/tools/perf/trace/beauty/perf_event_open.c
index 2bafd7c995ff..981185c1974b 100644
--- a/tools/perf/trace/beauty/perf_event_open.c
+++ b/tools/perf/trace/beauty/perf_event_open.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: LGPL-2.1
 #ifndef PERF_FLAG_FD_NO_GROUP
 # define PERF_FLAG_FD_NO_GROUP		(1UL << 0)
 #endif
diff --git a/tools/perf/trace/beauty/perf_ioctl.sh b/tools/perf/trace/beauty/perf_ioctl.sh
index 6492c74df928..9aabd9743ef6 100755
--- a/tools/perf/trace/beauty/perf_ioctl.sh
+++ b/tools/perf/trace/beauty/perf_ioctl.sh
@@ -1,4 +1,5 @@
 #!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
 
 [ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
diff --git a/tools/perf/trace/beauty/pid.c b/tools/perf/trace/beauty/pid.c
index 0313df342830..1a6acc46807b 100644
--- a/tools/perf/trace/beauty/pid.c
+++ b/tools/perf/trace/beauty/pid.c
@@ -1,4 +1,5 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: LGPL-2.1
+
 size_t syscall_arg__scnprintf_pid(char *bf, size_t size, struct syscall_arg *arg)
 {
 	int pid = arg->val;
diff --git a/tools/perf/trace/beauty/pkey_alloc.c b/tools/perf/trace/beauty/pkey_alloc.c
index 2ba784a3734a..d3e5188a9bef 100644
--- a/tools/perf/trace/beauty/pkey_alloc.c
+++ b/tools/perf/trace/beauty/pkey_alloc.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.1
 /*
  * trace/beauty/pkey_alloc.c
  *
  *  Copyright (C) 2017, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
- *
- * Released under the GPL v2. (and only v2, not any later version)
  */
 
 #include "trace/beauty/beauty.h"
diff --git a/tools/perf/trace/beauty/pkey_alloc_access_rights.sh b/tools/perf/trace/beauty/pkey_alloc_access_rights.sh
index e0a51aeb20b2..f8f1b560cf8a 100755
--- a/tools/perf/trace/beauty/pkey_alloc_access_rights.sh
+++ b/tools/perf/trace/beauty/pkey_alloc_access_rights.sh
@@ -1,4 +1,5 @@
 #!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
 
 [ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/asm-generic/
 
diff --git a/tools/perf/trace/beauty/prctl.c b/tools/perf/trace/beauty/prctl.c
index 246130dad6c4..be7a5d395975 100644
--- a/tools/perf/trace/beauty/prctl.c
+++ b/tools/perf/trace/beauty/prctl.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.1
 /*
  * trace/beauty/prctl.c
  *
  *  Copyright (C) 2017, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
- *
- * Released under the GPL v2. (and only v2, not any later version)
  */
 
 #include "trace/beauty/beauty.h"
diff --git a/tools/perf/trace/beauty/prctl_option.sh b/tools/perf/trace/beauty/prctl_option.sh
index f24722146ebe..d32f8f1124af 100755
--- a/tools/perf/trace/beauty/prctl_option.sh
+++ b/tools/perf/trace/beauty/prctl_option.sh
@@ -1,4 +1,5 @@
 #!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
 
 [ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
diff --git a/tools/perf/trace/beauty/sched_policy.c b/tools/perf/trace/beauty/sched_policy.c
index ba5096ae76b6..48f2b5c9aa3e 100644
--- a/tools/perf/trace/beauty/sched_policy.c
+++ b/tools/perf/trace/beauty/sched_policy.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: LGPL-2.1
 #include <sched.h>
 
 /*
diff --git a/tools/perf/trace/beauty/seccomp.c b/tools/perf/trace/beauty/seccomp.c
index b7097fd5fed9..e36156b19c70 100644
--- a/tools/perf/trace/beauty/seccomp.c
+++ b/tools/perf/trace/beauty/seccomp.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: LGPL-2.1
 #ifndef SECCOMP_SET_MODE_STRICT
 #define SECCOMP_SET_MODE_STRICT 0
 #endif
diff --git a/tools/perf/trace/beauty/signum.c b/tools/perf/trace/beauty/signum.c
index bde18a53f090..587fec545b8a 100644
--- a/tools/perf/trace/beauty/signum.c
+++ b/tools/perf/trace/beauty/signum.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: LGPL-2.1
 #include <signal.h>
 
 static size_t syscall_arg__scnprintf_signum(char *bf, size_t size, struct syscall_arg *arg)
diff --git a/tools/perf/trace/beauty/sndrv_ctl_ioctl.sh b/tools/perf/trace/beauty/sndrv_ctl_ioctl.sh
index eb511bb5fbd3..e0803b957593 100755
--- a/tools/perf/trace/beauty/sndrv_ctl_ioctl.sh
+++ b/tools/perf/trace/beauty/sndrv_ctl_ioctl.sh
@@ -1,4 +1,5 @@
 #!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
 
 [ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/sound/
 
diff --git a/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh b/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
index 6818392968b2..7a464a7bf913 100755
--- a/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
+++ b/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
@@ -1,4 +1,5 @@
 #!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
 
 [ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/sound/
 
diff --git a/tools/perf/trace/beauty/sockaddr.c b/tools/perf/trace/beauty/sockaddr.c
index 71a79f72d9d9..9410ad230f10 100644
--- a/tools/perf/trace/beauty/sockaddr.c
+++ b/tools/perf/trace/beauty/sockaddr.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: LGPL-2.1
 // Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
 
 #include "trace/beauty/beauty.h"
diff --git a/tools/perf/trace/beauty/socket.c b/tools/perf/trace/beauty/socket.c
index 65227269384b..d971a2596417 100644
--- a/tools/perf/trace/beauty/socket.c
+++ b/tools/perf/trace/beauty/socket.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: LGPL-2.1
 /*
  * trace/beauty/socket.c
  *
diff --git a/tools/perf/trace/beauty/socket_ipproto.sh b/tools/perf/trace/beauty/socket_ipproto.sh
index a3cc24633bec..de0f2f29017f 100755
--- a/tools/perf/trace/beauty/socket_ipproto.sh
+++ b/tools/perf/trace/beauty/socket_ipproto.sh
@@ -1,4 +1,5 @@
 #!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
 
 [ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
diff --git a/tools/perf/trace/beauty/socket_type.c b/tools/perf/trace/beauty/socket_type.c
index bca26aef4a77..a63a9a332aa0 100644
--- a/tools/perf/trace/beauty/socket_type.c
+++ b/tools/perf/trace/beauty/socket_type.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: LGPL-2.1
 #include <sys/types.h>
 #include <sys/socket.h>
 
diff --git a/tools/perf/trace/beauty/statx.c b/tools/perf/trace/beauty/statx.c
index 5643b692af4c..630f2760dd66 100644
--- a/tools/perf/trace/beauty/statx.c
+++ b/tools/perf/trace/beauty/statx.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.1
 /*
  * trace/beauty/statx.c
  *
  *  Copyright (C) 2017, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
- *
- * Released under the GPL v2. (and only v2, not any later version)
  */
 
 #include "trace/beauty/beauty.h"
diff --git a/tools/perf/trace/beauty/vhost_virtio_ioctl.sh b/tools/perf/trace/beauty/vhost_virtio_ioctl.sh
index 0f6a5197d0be..439773daaf77 100755
--- a/tools/perf/trace/beauty/vhost_virtio_ioctl.sh
+++ b/tools/perf/trace/beauty/vhost_virtio_ioctl.sh
@@ -1,4 +1,5 @@
 #!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
 
 [ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
diff --git a/tools/perf/trace/beauty/waitid_options.c b/tools/perf/trace/beauty/waitid_options.c
index 8465281a093d..42ff58ad613b 100644
--- a/tools/perf/trace/beauty/waitid_options.c
+++ b/tools/perf/trace/beauty/waitid_options.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: LGPL-2.1
 #include <sys/types.h>
 #include <sys/wait.h>
 
