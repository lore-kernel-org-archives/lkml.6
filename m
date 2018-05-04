Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeEDNz2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:55:28 -0400
Received: from mail.monom.org ([188.138.9.77]:44054 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751960AbeEDNz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:55:26 -0400
From: Daniel Wagner <wagi@monom.org>
To: linux-rt-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>, Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 3/3] Linux 4.4.131-rt148-rc1
Date: Fri,  4 May 2018 15:55:16 +0200
Message-Id: <20180504135516.32601-4-wagi@monom.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180504135516.32601-1-wagi@monom.org>
References: <20180504135516.32601-1-wagi@monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index d3fa072b6b43..823843af1026 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt147
+-rt148-rc1
-- 
2.14.3
