Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758496AbeD0TcI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 15:32:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33858 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757590AbeD0TcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 15:32:07 -0400
From: Colin King <colin.king@canonical.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf: fix spelling mistake: "builid" -> "buildid"
Date: Fri, 27 Apr 2018 20:31:58 +0100
Message-Id: <20180427193158.17932-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in error message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/perf/util/genelf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
index c540d47583e7..aafbe54fd3fa 100644
--- a/tools/perf/util/genelf.c
+++ b/tools/perf/util/genelf.c
@@ -114,7 +114,7 @@ gen_build_id(struct buildid_note *note,
 
 	fd = open("/dev/urandom", O_RDONLY);
 	if (fd == -1)
-		err(1, "cannot access /dev/urandom for builid");
+		err(1, "cannot access /dev/urandom for buildid");
 
 	sret = read(fd, note->build_id, sz);
 
-- 
2.17.0
