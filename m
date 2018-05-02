Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbeEBPA0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:00:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53673 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbeEBPAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:00:12 -0400
From: Colin King <colin.king@canonical.com>
To: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: media_tests: fix spelling mistake: "iternations" -> "iterations"
Date: Wed,  2 May 2018 16:00:10 +0100
Message-Id: <20180502150010.32333-1-colin.king@canonical.com>
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
 tools/testing/selftests/media_tests/media_device_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/media_tests/media_device_test.c b/tools/testing/selftests/media_tests/media_device_test.c
index 421a367e4bb3..d8bb1e15d1d9 100644
--- a/tools/testing/selftests/media_tests/media_device_test.c
+++ b/tools/testing/selftests/media_tests/media_device_test.c
@@ -88,7 +88,7 @@ int main(int argc, char **argv)
 	       "other Oops in the dmesg. Enable KaSan kernel\n"
 	       "config option for use-after-free error detection.\n\n");
 
-	printf("Running test for %d iternations\n", count);
+	printf("Running test for %d iterations\n", count);
 
 	while (count > 0) {
 		ret = ioctl(fd, MEDIA_IOC_DEVICE_INFO, &mdi);
-- 
2.17.0
