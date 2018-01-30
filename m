Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753395AbeA3U4P (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:56:15 -0500
Received: from home.regit.org ([37.187.126.138]:37358 "EHLO home.regit.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752866AbeA3Uzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:55:32 -0500
From: Eric Leblond <eric@regit.org>
To: daniel@iogearbox.net
Cc: alexei.starovoitov@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Leblond <eric@regit.org>
Subject: [PATCH bpf-next v8 4/5] libbpf: add missing SPDX-License-Identifier
Date: Tue, 30 Jan 2018 21:55:03 +0100
Message-Id: <20180130205504.20826-4-eric@regit.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180130205504.20826-1-eric@regit.org>
References: <a26f90e9-5028-f8a9-a1e6-83a6c46b4e0b@iogearbox.net>
 <20180130205504.20826-1-eric@regit.org>
X-Spam-Score: -1.0 (-)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eric Leblond <eric@regit.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/bpf.c    | 2 ++
 tools/lib/bpf/bpf.h    | 2 ++
 tools/lib/bpf/libbpf.c | 2 ++
 tools/lib/bpf/libbpf.h | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 9c88f6e4156d..592a58a2b681 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: LGPL-2.1
+
 /*
  * common eBPF ELF operations.
  *
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 9f44c196931e..8d18fb73d7fb 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: LGPL-2.1 */
+
 /*
  * common eBPF ELF operations.
  *
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c60122d3ea85..71ddc481f349 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: LGPL-2.1
+
 /*
  * Common eBPF ELF object loading operations.
  *
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index e42f96900318..f85906533cdd 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: LGPL-2.1 */
+
 /*
  * Common eBPF ELF object loading operations.
  *
-- 
2.15.1
