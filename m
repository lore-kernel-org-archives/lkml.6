Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbeCUMaR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 08:30:17 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43213 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbeCUM3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 08:29:42 -0400
X-Google-Smtp-Source: AG47ELtTqDa+qreFY5Qv9MGBB+0a2TvnIRWVa0BKA1h3yV7Du75qzKSHD5/Ulz20C0XPbfXBR3rHkQ==
From: Geliang Tang <geliangtang@gmail.com>
To: Kees Cook <keescook@chromium.org>, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] pstore: set PSTORE_842_COMPRESS tristate
Date: Wed, 21 Mar 2018 20:29:33 +0800
Message-Id: <450da262faf14e08f3ee9a9cb2e0a26a76f5cc9e.1521634787.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <9c9416b2dff19f05fb4c35879aaa83d11ff72c92.1521626182.git.geliangtang@gmail.com>
References: <9c9416b2dff19f05fb4c35879aaa83d11ff72c92.1521626182.git.geliangtang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sets PSTORE_842_COMPRESS 'tristate' like other pstore
compression algorithms in Kconfig.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 fs/pstore/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 09c19ef91526..a80c9bc0fbfc 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -44,7 +44,7 @@ config PSTORE_LZ4HC_COMPRESS
 	  This option enables LZ4HC (high compression) mode algorithm.
 
 config PSTORE_842_COMPRESS
-	bool "842 compression"
+	tristate "842 compression"
 	depends on PSTORE
 	select CRYPTO_842
 	help
-- 
2.14.1
