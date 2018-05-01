Return-Path: <shuah@kernel.org>
X-Google-Smtp-Source: AB8JxZp0fdC4Ax6doUhwFBz+mNyZFScsXihHzYja++YZ753R9rZTCRIWZHFY78DSeuUeV9/od4u0
ARC-Seal: i=1; a=rsa-sha256; t=1525210137; cv=none;
        d=google.com; s=arc-20160816;
        b=YVkL65l+vmKzHZxmQNiVn+L8eU0Uej3RFVOuHXSYUIlIb8YQssU1tGPn9oh0ZvJyB2
         HufeTi/4O503EOSKRr+KkMNRBqbl5cUBbzrdW2RHaOXhX5nDOOb+LbwPtQ8YPqX6fFDc
         hKjtrirSfa7lokbijmSyecCinPBlW9/9OtdHHM1BqVr5pcJDCpYJASgteap4kHyv6gMJ
         cHNmKURQfqN6ttAeqpRBjM8/5ROtRAH5A7dpNJCZs3ZF0ea8ceoHgOZFyRvQecrMW18g
         05nu1+WxcDL7lSNHhRzt0eTnpAFLyIQApopLUbc23CeU09P9lUlHpzGoK/D+6/I3MCZr
         do0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=h6/UJC6DqXyIiJiar63LtLakGjvOMnHCwhAEb3MRDRs=;
        b=Fe4PgQCT/EYoh5wIueaotgtz+j1tGk8iPhJ2/xY7Jzw0unEPrJKY/eE9qErGXqPJ3+
         x5XqLBxcaP9rUQ2urlZfCN9J6NgKJSH+H+4OQxzPUNa1Rd3ZegnsX5VAP6jaPhMPjUaK
         zu81V9BT3xUqP/OrSBcGVABomK5SNd2YSbpn+WAobQQ4DyP2E++YRQyBOQO59WoAPkY8
         rpP1Avf2snsgUytnTmXGUYnnX2LaiSNEH0NYgwgIIM1+nFzuPRnvUmp9d2Jqh3RgbV2a
         5pFg3f8+nE6uGyUuZz+RNY+rI2L/VExmPf4V+YGTu0yzZu5sxWLMtXHyL1V8s+EzW9mj
         BhtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 64.68.200.34 is neither permitted nor denied by best guess record for domain of shuah@kernel.org) smtp.mailfrom=shuah@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 64.68.200.34 is neither permitted nor denied by best guess record for domain of shuah@kernel.org) smtp.mailfrom=shuah@kernel.org
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: mchehab@kernel.org,
	davem@davemloft.net,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	linus.walleij@linaro.org,
	rdunlap@infradead.org
Cc: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update email address in MAINTAINERS entries
Date: Tue,  1 May 2018 15:28:15 -0600
Message-Id: <20180501212815.25911-1-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599298744902484799?=
X-GMAIL-MSGID: =?utf-8?q?1599298744902484799?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Updating email address in MAINTAINERS file due to IT infrastructure
changes at Samsung.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 92be777d060a..f9346c412fc6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3691,7 +3691,6 @@ F:	drivers/cpufreq/arm_big_little_dt.c
 
 CPU POWER MONITORING SUBSYSTEM
 M:	Thomas Renninger <trenn@suse.com>
-M:	Shuah Khan <shuahkh@osg.samsung.com>
 M:	Shuah Khan <shuah@kernel.org>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
@@ -7712,7 +7711,6 @@ F:	include/linux/sunrpc/
 F:	include/uapi/linux/sunrpc/
 
 KERNEL SELFTEST FRAMEWORK
-M:	Shuah Khan <shuahkh@osg.samsung.com>
 M:	Shuah Khan <shuah@kernel.org>
 L:	linux-kselftest@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
@@ -14672,7 +14670,6 @@ F:	drivers/usb/common/usb-otg-fsm.c
 
 USB OVER IP DRIVER
 M:	Valentina Manea <valentina.manea.m@gmail.com>
-M:	Shuah Khan <shuahkh@osg.samsung.com>
 M:	Shuah Khan <shuah@kernel.org>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
-- 
2.14.1
