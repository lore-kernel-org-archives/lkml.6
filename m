Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbeDDHRW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 03:17:22 -0400
Received: from mail.monom.org ([188.138.9.77]:49580 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750852AbeDDHRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 03:17:18 -0400
From: Daniel Wagner <wagi@monom.org>
To: linux-kernel@vger.kernel.org
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>, tom.zanussi@linux.intel.com,
        Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 7/7] Linux 4.4.126-rt141-rc1
Date: Wed,  4 Apr 2018 09:16:52 +0200
Message-Id: <20180404071652.24196-8-wagi@monom.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180404071652.24196-1-wagi@monom.org>
References: <20180404071652.24196-1-wagi@monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 09a4d4e4f010..564532c76548 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt141
+-rt141-rc1
-- 
2.14.3
