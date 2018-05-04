Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeEDR7t (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:59:49 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:53562 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeEDR7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:59:46 -0400
X-Google-Smtp-Source: AB8JxZrbMbP/6w8f1bWM/2iuEvt3+Zem6a222CkbX5zsQ6qbBPrBw1oEqkqlNzG0YCzu42RkKTmpaSkQyQ==
MIME-Version: 1.0
Date: Fri,  4 May 2018 19:59:35 +0200
Message-Id: <20180504175935.104085-1-jannh@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH] x86/vdso: remove unused file
From: Jann Horn <jannh@google.com>
To: luto@amacapital.net, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        jannh@google.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit da861e18eccc ("x86, vdso: Get rid of the fake section mechanism")
left this file behind; nothing is using it anymore.

Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/entry/vdso/vdso32/vdso-fakesections.c | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 arch/x86/entry/vdso/vdso32/vdso-fakesections.c

diff --git a/arch/x86/entry/vdso/vdso32/vdso-fakesections.c b/arch/x86/entry/vdso/vdso32/vdso-fakesections.c
deleted file mode 100644
index 541468e25265..000000000000
--- a/arch/x86/entry/vdso/vdso32/vdso-fakesections.c
+++ /dev/null
@@ -1 +0,0 @@
-#include "../vdso-fakesections.c"
-- 
2.17.0.441.gb46fe60e1d-goog
