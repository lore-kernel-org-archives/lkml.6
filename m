Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeEGPlK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 11:41:10 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44696 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752196AbeEGPlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 11:41:08 -0400
X-Google-Smtp-Source: AB8JxZqgPtFsL6lwS3GnX1xLM9bVTHV7X1ESBjv5NTIqBstm/qKeKU4faUFO2Jv6CXV47KcNiG7wgg==
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH] certificate handling: Update references to the documentation
Date: Mon,  7 May 2018 17:40:55 +0200
Message-Id: <1525707655-3542-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 94e980cc45f2b2 ("Documentation/module-signing.txt: convert to
ReST markup") converted the .txt doc. to ReST markup, but it did not
update the references to the doc. (including in MAINTAINERS).

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 MAINTAINERS   | 2 +-
 certs/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index df6e9bb2559af..803d4b4ff5f1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3347,7 +3347,7 @@ M:	David Howells <dhowells@redhat.com>
 M:	David Woodhouse <dwmw2@infradead.org>
 L:	keyrings@vger.kernel.org
 S:	Maintained
-F:	Documentation/module-signing.txt
+F:	Documentation/admin-guide/module-signing.rst
 F:	certs/
 F:	scripts/sign-file.c
 F:	scripts/extract-cert.c
diff --git a/certs/Kconfig b/certs/Kconfig
index 5f7663df6e8e3..c94e93d8bccf0 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -13,7 +13,7 @@ config MODULE_SIG_KEY
 
          If this option is unchanged from its default "certs/signing_key.pem",
          then the kernel will automatically generate the private key and
-         certificate as described in Documentation/module-signing.txt
+         certificate as described in Documentation/admin-guide/module-signing.rst
 
 config SYSTEM_TRUSTED_KEYRING
 	bool "Provide system-wide ring of trusted keys"
-- 
2.7.4
