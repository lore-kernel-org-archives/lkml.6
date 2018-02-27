Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbeB0WRc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:17:32 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37945 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbeB0WRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:17:30 -0500
X-Google-Smtp-Source: AG47ELtzVuyrKMlerEWCUj05qo70DaM0SMZZ80zdBLzqzeXXiThKAwk5jvrNIGNE9zaokCghChc9IQ==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: zohar@linux.vnet.ibm.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, hernan@vanguardiasur.com.ar
Subject: [PATCH 2/2] security: evm: Constify *integrity_status_msg[]
Date: Tue, 27 Feb 2018 19:17:00 -0300
Message-Id: <1519769820-20365-2-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519769820-20365-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1519769820-20365-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: This is compile only tested.
There is no gain from doing this except for some self-documenting.

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 security/integrity/evm/evm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 826926d..7a968fa 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -30,7 +30,7 @@
 
 int evm_initialized;
 
-static char *integrity_status_msg[] = {
+static const char * const integrity_status_msg[] = {
 	"pass", "pass_immutable", "fail", "no_label", "no_xattrs", "unknown"
 };
 int evm_hmac_attrs;
-- 
2.7.4
