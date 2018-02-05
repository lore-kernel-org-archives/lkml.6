Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752181AbeBET6A (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 14:58:00 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37883 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752057AbeBET5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 14:57:41 -0500
X-Google-Smtp-Source: AH8x2254LbUbp1YOh0wtroMjG/Uw1hBCX7LZ+Msde4/djtZJDphkoZKF99eDlB8dtEwBSLjrMdeLwA==
From: Sangwon Hong <qpakzk@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Taeung Song <treeze.taeung@gmail.com>, Sangwon Hong <qpakzk@gmail.com>
Subject: [PATCH 2/2] perf data: Delete typos on the man page
Date: Tue,  6 Feb 2018 04:56:29 +0900
Message-Id: <1517860589-19387-2-git-send-email-qpakzk@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517860589-19387-1-git-send-email-qpakzk@gmail.com>
References: <1517860589-19387-1-git-send-email-qpakzk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
---
 tools/perf/Documentation/perf-data.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-data.txt b/tools/perf/Documentation/perf-data.txt
index 90bb4aa..b031433 100644
--- a/tools/perf/Documentation/perf-data.txt
+++ b/tools/perf/Documentation/perf-data.txt
@@ -8,7 +8,7 @@ perf-data - Data file related processing
 SYNOPSIS
 --------
 [verse]
-'perf data' [<common options>] <command> [<options>]",
+'perf data' [<common options>] <command> [<options>]
 
 DESCRIPTION
 -----------
-- 
2.7.4
