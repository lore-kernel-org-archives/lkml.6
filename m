Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751640AbeBUXom (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 18:44:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751104AbeBUXlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 18:41:00 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB84121795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From: James Hogan <jhogan@kernel.org>
To: linux-metag@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 02/13] docs: Remove metag docs
Date: Wed, 21 Feb 2018 23:38:14 +0000
Message-Id: <20180221233825.10024-3-jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180221233825.10024-1-jhogan@kernel.org>
References: <20180221233825.10024-1-jhogan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that arch/metag/ has been removed, remove Meta architecture specific
documentation from the Documentation/ directory.

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-metag@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 Documentation/00-INDEX                           |   2 -
 Documentation/admin-guide/kernel-parameters.txt  |   4 -
 Documentation/devicetree/bindings/metag/meta.txt |  30 ---
 Documentation/metag/00-INDEX                     |   4 -
 Documentation/metag/kernel-ABI.txt               | 256 -----------------------
 5 files changed, 296 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/metag/meta.txt
 delete mode 100644 Documentation/metag/00-INDEX
 delete mode 100644 Documentation/metag/kernel-ABI.txt

diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index 7f3a0728ccf2..eae1e7193f50 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -276,8 +276,6 @@ memory-hotplug.txt
 	- Hotpluggable memory support, how to use and current status.
 men-chameleon-bus.txt
 	- info on MEN chameleon bus.
-metag/
-	- directory with info about Linux on Meta architecture.
 mic/
 	- Intel Many Integrated Core (MIC) architecture device driver.
 mips/
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1d1d53f85ddd..30a8d0635898 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1347,10 +1347,6 @@
 			       If specified, z/VM IUCV HVC accepts connections
 			       from listed z/VM user IDs only.
 
-	hwthread_map=	[METAG] Comma-separated list of Linux cpu id to
-			        hardware thread id mappings.
-				Format: <cpu>:<hwthread>
-
 	keep_bootcon	[KNL]
 			Do not unregister boot console at start. This is only
 			useful for debugging when something happens in the window
diff --git a/Documentation/devicetree/bindings/metag/meta.txt b/Documentation/devicetree/bindings/metag/meta.txt
deleted file mode 100644
index f4457f57ab08..000000000000
diff --git a/Documentation/metag/00-INDEX b/Documentation/metag/00-INDEX
deleted file mode 100644
index db11c513bd5c..000000000000
diff --git a/Documentation/metag/kernel-ABI.txt b/Documentation/metag/kernel-ABI.txt
deleted file mode 100644
index 628216603198..000000000000
-- 
2.13.6
