Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeECJJX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 05:09:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38975 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbeECJJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 05:09:15 -0400
From: Colin King <colin.king@canonical.com>
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpupower: fix spelling mistake: "logilename" -> "logfilename"
Date: Thu,  3 May 2018 10:09:10 +0100
Message-Id: <20180503090910.29144-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dprintf message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/power/cpupower/bench/parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
index 9b65f052081f..9ba8a44ad2a7 100644
--- a/tools/power/cpupower/bench/parse.c
+++ b/tools/power/cpupower/bench/parse.c
@@ -104,7 +104,7 @@ FILE *prepare_output(const char *dirname)
 			dirname, time(NULL));
 	}
 
-	dprintf("logilename: %s\n", filename);
+	dprintf("logfilename: %s\n", filename);
 
 	output = fopen(filename, "w+");
 	if (output == NULL) {
-- 
2.17.0
