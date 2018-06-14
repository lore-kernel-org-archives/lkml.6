Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 21AD8C004E4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24F1208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24F1208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964833AbeFNBGM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 21:06:12 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:52683 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935796AbeFNBGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 21:06:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id D5483214E8;
        Thu, 14 Jun 2018 01:06:09 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NB5pbIwvXkW9; Thu, 14 Jun 2018 01:06:09 +0000 (UTC)
Received: from localhost.localdomain (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id DBA1E211F9;
        Thu, 14 Jun 2018 01:06:00 +0000 (UTC)
From:   "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To:     tom.hromatka@oracle.com, gregkh@linuxfoundation.org,
        allen.pais@oracle.com, davem@davemloft.net
Cc:     "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: sparc64: Add missing SPDX License Identifiers
Date:   Wed, 13 Jun 2018 19:05:59 -0600
Message-Id: <20180614010559.5144-1-shuah@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing SPDX License Identifiers to Makefile(s).

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/sparc64/Makefile         | 1 +
 tools/testing/selftests/sparc64/drivers/Makefile | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sparc64/Makefile b/tools/testing/selftests/sparc64/Makefile
index 76b2206932c3..a19531dba4dc 100644
--- a/tools/testing/selftests/sparc64/Makefile
+++ b/tools/testing/selftests/sparc64/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/x86_64/x86/)
 
diff --git a/tools/testing/selftests/sparc64/drivers/Makefile b/tools/testing/selftests/sparc64/drivers/Makefile
index 6264f40bbdbc..deb0df415565 100644
--- a/tools/testing/selftests/sparc64/drivers/Makefile
+++ b/tools/testing/selftests/sparc64/drivers/Makefile
@@ -1,4 +1,4 @@
-
+# SPDX-License-Identifier: GPL-2.0
 INCLUDEDIR := -I.
 CFLAGS := $(CFLAGS) $(INCLUDEDIR) -Wall -O2 -g
 
-- 
2.17.0

