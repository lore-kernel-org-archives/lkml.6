Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELs229D8sqLlmQhuXJBP12ANEqOG4ZeLzTPNj1SwAwUWlK3+WvRQy2Mu7b8mixyq9y7luwwU
ARC-Seal: i=1; a=rsa-sha256; t=1521210240; cv=none;
        d=google.com; s=arc-20160816;
        b=M44X6myxwfjnH8ARpbVs6+G2RjWhTqUe3DRpobT/ZOqqiTj/gv7ZO6zU1hn+3CiZaX
         GBoIRjdTSu21JNWEbsDnVLuf2hvixOBsrcn8CcOJAnBPor6tLQaJkEszCBQ/bk7zKweJ
         3Axj0s5xZopHt9JeDjI/38gthfBMMosY0Za0YCp8UdFvBuHVfxNF8zGhDjjiLnHN71u2
         VyqKcPR12kZwfnOhCKPYpRh1UIlV2wLKIl0iYEO2uJZDJYUPIX7Et4wVrNjaNx172G07
         doDbaK1nxXWv3HBpdQm/tcOvJvcqdPDQKEPqsxM4u9Bt/Biq0e9MYEyIPDFOWoekDniJ
         vi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=MWsPStqbJVuV/PhYKzPUeQtewYaTSxWuDBmlQvwOsAA=;
        b=p2fNXBqWMPO1U9btuHo64LaeXkfVoz2qLYtYwsQ4E8lFCtmZYuMTNEf8796Flx4DlB
         bp/PcfCn4toAw91614USRGdiUPBe/aCIFzHILhpAepjQupZeCQCbTMgwa97rmpIzfXlZ
         Um1oMnT+Z7Y05u2Fb540uk4lQT8jBmrdWiKDa1U5YdgTFuLYFiiOEvf7k0FZDISvVv7m
         PpREf2cUkLCpXhV6vT9K+KTCV6ThpXdEUVN62j99JHtTk7z0F4ulZlA36u21PUgGrfbv
         Tkx346oIspizoPK+WCmi46VecOpQOBw49SZqOUqKmpm/agwAZ7gJWMLUhdwheDPcsL7z
         dkhw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752995AbeCPOXp (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 10:23:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43861 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752380AbeCPOXo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 10:23:44 -0400
From: Colin King <colin.king@canonical.com>
To: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests: fix spelling mistake: "desciptor" -> "descriptor"
Date: Fri, 16 Mar 2018 14:23:40 +0000
Message-Id: <20180316142340.11346-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595104549569019067?=
X-GMAIL-MSGID: =?utf-8?q?1595104549569019067?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in error message text and re-adjust
break in literal string to fit into 80 char wide format.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/testing/selftests/filesystems/devpts_pts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/filesystems/devpts_pts.c b/tools/testing/selftests/filesystems/devpts_pts.c
index b9055e974289..32addb696150 100644
--- a/tools/testing/selftests/filesystems/devpts_pts.c
+++ b/tools/testing/selftests/filesystems/devpts_pts.c
@@ -279,8 +279,8 @@ int main(int argc, char *argv[])
 	int ret;
 
 	if (!isatty(STDIN_FILENO)) {
-		fprintf(stderr, "Standard input file desciptor is not attached "
-				"to a terminal. Skipping test\n");
+		fprintf(stderr, "Standard input file descriptor is not "
+				"attached to a terminal. Skipping test\n");
 		exit(EXIT_FAILURE);
 	}
 
-- 
2.15.1

