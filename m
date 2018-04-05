Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbeDEVVk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 17:21:40 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35166 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbeDEVVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 17:21:36 -0400
X-Google-Smtp-Source: AIpwx4+bz37pSR4OK6iqV+LTPp8LQQ1vucDNd3xoqCYyG4ogNExoit0PDhGSIToeitLPpWYK1ZyPDQ==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: richard@nod.at, jdike@addtoit.com,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH] um: Add HAVE_DEBUG_BUGVERBOSE.
Date: Thu,  5 Apr 2018 18:21:02 -0300
Message-Id: <1522963262-14640-1-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This option restores the DEBUG_BUGVERBOSE functionality as it was
previous to commit 9a93848fe787 ("x86/debug: Implement __WARN() using
UD0").

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 arch/um/Kconfig.common | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
index c68add8..bf2a70f 100644
--- a/arch/um/Kconfig.common
+++ b/arch/um/Kconfig.common
@@ -8,6 +8,7 @@ config UML
 	select HAVE_UID16
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_DEBUG_KMEMLEAK
+	select HAVE_DEBUG_BUGVERBOSE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CLOCKEVENTS
-- 
2.7.4
