Return-Path: <giulio.benetti@micronovasrl.com>
X-Google-Smtp-Source: AB8JxZqwL0H9YVqIcxeysywO61OK5pV9OgFTvxThpzioULF2/kUzK5SdZ4HF8Jw5J75hw1Yiwfk7
ARC-Seal: i=1; a=rsa-sha256; t=1526481589; cv=none;
        d=google.com; s=arc-20160816;
        b=JJUJHXErq5Mb0Jk47830t7vTmst3q13Z4J06fuY8dQ0+M4giWOI7SQLxcgHZWFofmS
         Vwc4ZzmdMcIW8OSC56zq0AV5wsTki6W0PYhH/XB45MxZPCXeYSXZSlFG48ICfjsjsFbC
         WHFnNLrD6auci0WoR5kEDZN0ML4bi0p/M5+q7xxjcaWdifDwB1ZVqb2rdoP9du7vR9s9
         0u5ZhwxbsunNR1WDAITqhF51BQwOXzVFwGWwfEeBkotYXBVuuIfLSAg2BPiMGMXXFCi+
         MlQwNoI15PZSuwBDKRXyQ4mee0LYAF6IKM/zNYtj0HtPUUDQFbxQ6oBF5uvbWzNjDPAV
         TJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=8Ix9FprIeGd7P3Wn9r7YcBwvNczwAu6mylcZogwa3bM=;
        b=HUEwr5fL1fosCopGuSeYfm9wVL1Tzy45UgbiVmToj0pVduRiHnsA8uAaR/hEvwwCjf
         NGh1CQAup70Vu3j21k9PhEn6Yq25antWsB1ANkPNeE05heXW1XpXv7Rg1ZcTiujN/Md8
         +NxpwyB+ml7kR27uLLCPm3395VP5XrcNZL/1iycdQN9fmawywijGhXBKcvz8fh7R6Yqx
         Zpbc/6WDajexHLXxPKOFxl+DQIR06EGF5O0yInZ6gBGEKcIwtObtHGtVx08Z+dEYldL1
         0irdlKONOZgZhmr+ZDufhLvO1IPKS+4sds+BA98BdbJwYHXF6l6fhexW9r8kiUFRQR0b
         koYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=temperror (no key for signature) header.i=@micronovasrl.com header.s=dkim header.b=GD94HV9u;
       spf=pass (google.com: domain of giulio.benetti@micronovasrl.com designates 212.103.203.10 as permitted sender) smtp.mailfrom=giulio.benetti@micronovasrl.com
Authentication-Results: mx.google.com;
       dkim=temperror (no key for signature) header.i=@micronovasrl.com header.s=dkim header.b=GD94HV9u;
       spf=pass (google.com: domain of giulio.benetti@micronovasrl.com designates 212.103.203.10 as permitted sender) smtp.mailfrom=giulio.benetti@micronovasrl.com
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
To: tglx@linutronix.de
Cc: pombredanne@nexb.com,
	gregkh@linuxfoundation.org,
	kstewart@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH] tty: fix typo in ASYNCB_FOURPORT comment
Date: Wed, 16 May 2018 16:39:31 +0200
Message-Id: <20180516143931.89679-1-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600631959743697096?=
X-GMAIL-MSGID: =?utf-8?q?1600631959743697096?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 include/uapi/linux/tty_flags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/tty_flags.h b/include/uapi/linux/tty_flags.h
index 6ac609a00dea..900a32e63424 100644
--- a/include/uapi/linux/tty_flags.h
+++ b/include/uapi/linux/tty_flags.h
@@ -13,7 +13,7 @@
  */
 #define ASYNCB_HUP_NOTIFY	 0 /* Notify getty on hangups and closes
 				    * on the callout port */
-#define ASYNCB_FOURPORT		 1 /* Set OU1, OUT2 per AST Fourport settings */
+#define ASYNCB_FOURPORT		 1 /* Set OUT1, OUT2 per AST Fourport settings */
 #define ASYNCB_SAK		 2 /* Secure Attention Key (Orange book) */
 #define ASYNCB_SPLIT_TERMIOS	 3 /* [x] Separate termios for dialin/callout */
 #define ASYNCB_SPD_HI		 4 /* Use 57600 instead of 38400 bps */
-- 
2.17.0
