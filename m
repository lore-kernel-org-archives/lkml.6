Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752732AbeFDHap (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:30:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752359AbeFDG7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:59:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.9 19/29] tools include: Include missing headers for fls() and types in linux/log2.h
Date: Mon,  4 Jun 2018 08:58:15 +0200
Message-Id: <20180604065802.911198949@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065802.157744637@linuxfoundation.org>
References: <20180604065802.157744637@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
 tools/include/linux/log2.h |    3 +++
 1 file changed, 3 insertions(+)

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
