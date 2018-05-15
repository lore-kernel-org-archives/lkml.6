Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754172AbeEOQpD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:45:03 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:44503 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754053AbeEOQpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:45:02 -0400
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org
Cc: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add Q: entry to kselftest for patchwork project
Date: Tue, 15 May 2018 10:44:27 -0600
Message-Id: <20180515164427.12201-1-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new patchwork project is created to track kselftest patches. Update
the kselftest entry in the MAINTAINERS file adding Q: entry:

https://patchwork.kernel.org/project/linux-kselftest/list/

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 58b9861ccf99..ab577593d80a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7698,6 +7698,7 @@ KERNEL SELFTEST FRAMEWORK
 M:	Shuah Khan <shuah@kernel.org>
 L:	linux-kselftest@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
+Q:	https://patchwork.kernel.org/project/linux-kselftest/list/
 S:	Maintained
 F:	tools/testing/selftests/
 F:	Documentation/dev-tools/kselftest*
-- 
2.14.1
