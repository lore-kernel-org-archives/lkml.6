Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521482985-2-13153892462150612938
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521482984; b=EpvRnVy7PlT27mav6fReHXgwVaez+rij1naESm/+heB+quV
    55G5y+TnOzFDtxLuSunS7IYhAlrgv6u18lx1I/LM9WAjr8vWYd1KS6RuOjB4ABOf
    V2Yat7Aw+8agsJwUfkoo8nbnNVbLT2TeJBSYoExH8gH83vkNyu3zZY4ZpyrW2EJs
    1HL6Is3F7b4GMKQDJbjnEYZoMXyqJcmo3/GIeOlY2nP5xPeXZv+Nwp3ID+SHTayc
    lgSJnKy6ag8KZA8y17VD28MXx0KLgud+Si/vEtcNhzqTR1AwPkOkqrg7LRQAaJgr
    66AewuPdW8eGx+Na0cBvktfMoKFWUd7SUDxkvyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521482984; bh=9c2KO+iyKjFML8sXOWkXLEc1G5
    6uyf/AhplzyIihpBE=; b=YRgMNIzNprQBH24Ru+hKPWkuIs7tTzb2StiaAx4Y8y
    UFTKiBM+S9KlCo2rkG/TrDv53u4TGapUikPqTMBgI1ShnbnU+/TgGVvlUZjeUgnT
    zMJmZDdNb3U3w+WzunOvdLMC7zHNVJF8WsvDwalc8NVh6jHxEecvtKioScnm2re/
    VBLVVX7O9l7o2BHcDTXKKaVyjJv0a8gKt0kH98CWKVhqEmA6y7mnVqx4Miad0Zlw
    sSoHhFO5cUrhsD/+W7EBR/ZANLNelKCG7fUXKXyQlwiK3iMRGKegK840uUVumrRv
    SlapsumyuWDtoqm/oHlQGOSlV3ymxZXuD91phkqx+BWQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegheelheenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegheelheenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030293AbeCSSJl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:09:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41560 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030348AbeCSSJk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:09:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Aleksey Makarov <aleksey.makarov@linaro.org>,
        Joe Perches <joe@perches.com>,
        Ming Lei <ming.lei@canonical.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 23/68] braille-console: Fix value returned by _braille_console_setup
Date: Mon, 19 Mar 2018 19:06:01 +0100
Message-Id: <20180319171831.110678164@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Samuel Thibault <samuel.thibault@ens-lyon.org>


[ Upstream commit 2ed2b8621be2708c0f6d61fe9841e9ad8b9753f0 ]

commit bbeddf52adc1 ("printk: move braille console support into
separate braille.[ch] files") introduced _braille_console_setup()
to outline the braille initialization code.  There was however some
confusion over the value it was supposed to return. commit 2cfe6c4ac7ee
("printk: Fix return of braille_register_console()") tried to fix it
but failed to.

This fixes and documents the returned value according to the use
in printk.c: non-zero return means a parsing error, and thus this
console configuration should be ignored.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Joe Perches <joe@perches.com>
Cc: Ming Lei <ming.lei@canonical.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/printk/braille.c |   15 ++++++++-------
 kernel/printk/braille.h |   13 ++++++++++---
 2 files changed, 18 insertions(+), 10 deletions(-)

--- a/kernel/printk/braille.c
+++ b/kernel/printk/braille.c
@@ -2,12 +2,13 @@
 
 #include <linux/kernel.h>
 #include <linux/console.h>
+#include <linux/errno.h>
 #include <linux/string.h>
 
 #include "console_cmdline.h"
 #include "braille.h"
 
-char *_braille_console_setup(char **str, char **brl_options)
+int _braille_console_setup(char **str, char **brl_options)
 {
 	if (!memcmp(*str, "brl,", 4)) {
 		*brl_options = "";
@@ -15,14 +16,14 @@ char *_braille_console_setup(char **str,
 	} else if (!memcmp(str, "brl=", 4)) {
 		*brl_options = *str + 4;
 		*str = strchr(*brl_options, ',');
-		if (!*str)
+		if (!*str) {
 			pr_err("need port name after brl=\n");
-		else
-			*((*str)++) = 0;
-	} else
-		return NULL;
+			return -EINVAL;
+		}
+		*((*str)++) = 0;
+	}
 
-	return *str;
+	return 0;
 }
 
 int
--- a/kernel/printk/braille.h
+++ b/kernel/printk/braille.h
@@ -9,7 +9,14 @@ braille_set_options(struct console_cmdli
 	c->brl_options = brl_options;
 }
 
-char *
+/*
+ * Setup console according to braille options.
+ * Return -EINVAL on syntax error, 0 on success (or no braille option was
+ * actually given).
+ * Modifies str to point to the serial options
+ * Sets brl_options to the parsed braille options.
+ */
+int
 _braille_console_setup(char **str, char **brl_options);
 
 int
@@ -25,10 +32,10 @@ braille_set_options(struct console_cmdli
 {
 }
 
-static inline char *
+static inline int
 _braille_console_setup(char **str, char **brl_options)
 {
-	return NULL;
+	return 0;
 }
 
 static inline int
