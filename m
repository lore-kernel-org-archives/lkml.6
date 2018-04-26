Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755614AbeDZKe5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:34:57 -0400
Received: from foss.arm.com ([217.140.101.70]:51153 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755314AbeDZKeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:34:12 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        longman@redhat.com, will.deacon@arm.com
Subject: [PATCH v3 14/14] MAINTAINERS: Add myself as a co-maintainer for LOCKING PRIMITIVES
Date: Thu, 26 Apr 2018 11:34:28 +0100
Message-Id: <1524738868-31318-15-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
References: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been heavily involved with concurrency and memory ordering stuff
(see ATOMIC INFRASTRUCTURE and LINUX KERNEL MEMORY CONSISTENCY MODEL)
and with arm64 now using qrwlock with a view to using qspinlock in the
near future, I'm going to continue being involved with the core locking
primitives. Reflect this by adding myself as a co-maintainer alongside
Ingo and Peter.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 92be777d060a..2509c20a979e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8328,6 +8328,7 @@ F:	Documentation/admin-guide/LSM/LoadPin.rst
 LOCKING PRIMITIVES
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Ingo Molnar <mingo@redhat.com>
+M:	Will Deacon <will.deacon@arm.com>
 L:	linux-kernel@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
 S:	Maintained
-- 
2.1.4
