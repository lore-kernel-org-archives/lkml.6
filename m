Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753362AbeD2Lyc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 07:54:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52574 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752415AbeD2Lyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 07:54:31 -0400
From: Colin King <colin.king@canonical.com>
To: Shuah Khan <shuah@kernel.org>,
        "Eric W . Biedermane" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: fix spelling mistake: "desciptor" -> "descriptor"
Date: Sun, 29 Apr 2018 12:54:25 +0100
Message-Id: <20180429115425.9378-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/testing/selftests/filesystems/devpts_pts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/devpts_pts.c b/tools/testing/selftests/filesystems/devpts_pts.c
index b9055e974289..ea5de8271521 100644
--- a/tools/testing/selftests/filesystems/devpts_pts.c
+++ b/tools/testing/selftests/filesystems/devpts_pts.c
@@ -279,7 +279,7 @@ int main(int argc, char *argv[])
 	int ret;
 
 	if (!isatty(STDIN_FILENO)) {
-		fprintf(stderr, "Standard input file desciptor is not attached "
+		fprintf(stderr, "Standard input file descriptor is not attached "
 				"to a terminal. Skipping test\n");
 		exit(EXIT_FAILURE);
 	}
-- 
2.17.0
