Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeFCMbg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751476AbeFCM2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:28:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 19/29] tools include: Include missing headers for fls() and types in linux/log2.h
Date: Sun,  3 Jun 2018 14:26:42 +0200
Message-Id: <20180603122652.17453-20-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180603122652.17453-1-gregkh@linuxfoundation.org>
References: <20180603122652.17453-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit a12a4e023a55f058178afea1ada3ce7bf4db94c3 upstream.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-7wj865zidu5ylf87i6i7v6z7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/include/linux/log2.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/linux/log2.h b/tools/include/linux/log2.h
index d5677d39c1e4..0325cefc2220 100644
--- a/tools/include/linux/log2.h
+++ b/tools/include/linux/log2.h
@@ -12,6 +12,9 @@
 #ifndef _TOOLS_LINUX_LOG2_H
 #define _TOOLS_LINUX_LOG2_H
 
+#include <linux/bitops.h>
+#include <linux/types.h>
+
 /*
  * non-constant log of base 2 calculators
  * - the arch may override these in asm/bitops.h if they can be implemented
-- 
2.17.1
