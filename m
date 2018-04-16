Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753073AbeDPGoD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 02:44:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33711 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeDPGoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 02:44:02 -0400
Date: Sun, 15 Apr 2018 23:43:39 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-edbi4r2pvzn7no6ebxbtczng@git.kernel.org>
Cc: dsahern@gmail.com, mingo@kernel.org, wcohen@redhat.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
        hpa@zytor.com, andi@firstfloor.org, namhyung@kernel.org,
        acme@redhat.com, tglx@linutronix.de
Reply-To: eranian@google.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        namhyung@kernel.org, andi@firstfloor.org, tglx@linutronix.de,
        acme@redhat.com, mingo@kernel.org, dsahern@gmail.com,
        wcohen@redhat.com, jolsa@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf jvmti: Give hints about package names needed
 to build
Git-Commit-ID: e14b733c5dc62f574b4dbc045b2cc52b03d83d4c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e14b733c5dc62f574b4dbc045b2cc52b03d83d4c
Gitweb:     https://git.kernel.org/tip/e14b733c5dc62f574b4dbc045b2cc52b03d83d4c
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 11 Apr 2018 12:08:53 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 12 Apr 2018 10:33:17 -0300

perf jvmti: Give hints about package names needed to build

Give as examples of package names to install to have this built for
fedora and debian, to help the user a bit.

The part from 'e.g.:' onwards:

  No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel

Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-edbi4r2pvzn7no6ebxbtczng@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c7abd83a8e19..6b307e97dc57 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -847,7 +847,7 @@ ifndef NO_JVMTI
   ifeq ($(feature-jvmti), 1)
     $(call detected_var,JDIR)
   else
-    $(warning No openjdk development package found, please install JDK package)
+    $(warning No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel)
     NO_JVMTI := 1
   endif
 endif
