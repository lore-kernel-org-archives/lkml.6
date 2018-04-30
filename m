Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1851310-1525116433-2-7506062712367632398
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525116432; b=R6E/mnB7tQ7xw2Em+IwaxV96WwnIDXH9XPfxlE68zvWoAGJWiR
    Q6FUSmAY/IUdLEnSavB3pJMqlYny4begl+vfgIxAGxMHN/qq+DmcpVxojcn7w11d
    EKOh9utqLiDlhg3zCZVcQRV88qVgGEMscwAbVSMwZsmKVuVLjHnaSKZHpsvHQBZC
    8ypNe5k1jpTnpw82GH38tM570ltHGIi14B+ns8Dyry8XvBa715yHywDLUQQ0wdbt
    eFmje+NdpOsMxsZ+wbqoTviLBeqoibac6/wXDcKTpIcq7PX6aPP8GE9csl5L14G7
    89JUxvECVOy2mnPNVaq+gVZ9zk1eKRwMcemw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525116432; bh=WSgUP3V4vupqVuj4rxpQ7x2Jn6/TRs
    17Akmn9oKG/v8=; b=mf20iC69q6gZgHtb/XOE4hCQLb33xSyH9BITubjBKPzvKh
    +KsGniHEgO8znHYao+IQwXftry+SV0c4e9qZTxu7rBqGIHXDjAUEvrI3ugFtdd43
    J0+8mtUG11cEYXnjllJSR/GBuRsLhOtzs71ByHoHKscal5LU60CcgcGNtr+bHXIi
    xYjRd7uFZ/hw3aFbfT/JqSVWCgmVEtIM9N5RlKCC3EDzInfIALThjzAQmdQ67xCQ
    vOOScz+9zoJtQnk1bql7RR7ajlIA6cBcr19sGs5RwbnB/FX7zTTDftjdteNnOayy
    13sbmdkDP4ECo+mhNVdS6JjRC+9AucA2tD9IBGwQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKmmqiB0bi+Tcn+epvtzduXW1JXfTDOrenfkvr6ecFKlH0Ezz+/uzlKHF9xUDbNbEzQT4b5iht4hV6PWMc4LRxPYr2iOpAvypejeJ8SIQh/Y0q0PJjPt
    IRaaEORJV2ZbNxt+L86GBipXNCABxcEUusITIOFHbjZjlyjqL7A0Ta7/gAh0vqnklPy7/eVTcoC3TLSrPngLlTcC6tNAe3VhfPmOQTxdZ6zLtkuopeR/qT1c
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=dKd0YINDE1TEVGpYFogA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755234AbeD3T1J (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:27:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932148AbeD3T1J (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:27:09 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDB922DC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.14 08/91] random: rate limit unseeded randomness warnings
Date: Mon, 30 Apr 2018 12:23:50 -0700
Message-Id: <20180430184004.649780470@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 4e00b339e264802851aff8e73cde7d24b57b18ce upstream.

On systems without sufficient boot randomness, no point spamming dmesg.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/random.c |   39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -261,6 +261,7 @@
 #include <linux/ptrace.h>
 #include <linux/workqueue.h>
 #include <linux/irq.h>
+#include <linux/ratelimit.h>
 #include <linux/syscalls.h>
 #include <linux/completion.h>
 #include <linux/uuid.h>
@@ -438,6 +439,16 @@ static void _crng_backtrack_protect(stru
 static void process_random_ready_list(void);
 static void _get_random_bytes(void *buf, int nbytes);
 
+static struct ratelimit_state unseeded_warning =
+	RATELIMIT_STATE_INIT("warn_unseeded_randomness", HZ, 3);
+static struct ratelimit_state urandom_warning =
+	RATELIMIT_STATE_INIT("warn_urandom_randomness", HZ, 3);
+
+static int ratelimit_disable __read_mostly;
+
+module_param_named(ratelimit_disable, ratelimit_disable, int, 0644);
+MODULE_PARM_DESC(ratelimit_disable, "Disable random ratelimit suppression");
+
 /**********************************************************************
  *
  * OS independent entropy store.   Here are the functions which handle
@@ -931,6 +942,18 @@ static void crng_reseed(struct crng_stat
 		process_random_ready_list();
 		wake_up_interruptible(&crng_init_wait);
 		pr_notice("random: crng init done\n");
+		if (unseeded_warning.missed) {
+			pr_notice("random: %d get_random_xx warning(s) missed "
+				  "due to ratelimiting\n",
+				  unseeded_warning.missed);
+			unseeded_warning.missed = 0;
+		}
+		if (urandom_warning.missed) {
+			pr_notice("random: %d urandom warning(s) missed "
+				  "due to ratelimiting\n",
+				  urandom_warning.missed);
+			urandom_warning.missed = 0;
+		}
 	}
 }
 
@@ -1574,8 +1597,9 @@ static void _warn_unseeded_randomness(co
 #ifndef CONFIG_WARN_ALL_UNSEEDED_RANDOM
 	print_once = true;
 #endif
-	pr_notice("random: %s called from %pS with crng_init=%d\n",
-		  func_name, caller, crng_init);
+	if (__ratelimit(&unseeded_warning))
+		pr_notice("random: %s called from %pS with crng_init=%d\n",
+			  func_name, caller, crng_init);
 }
 
 /*
@@ -1769,6 +1793,10 @@ static int rand_initialize(void)
 	init_std_data(&blocking_pool);
 	crng_initialize(&primary_crng);
 	crng_global_init_time = jiffies;
+	if (ratelimit_disable) {
+		urandom_warning.interval = 0;
+		unseeded_warning.interval = 0;
+	}
 	return 0;
 }
 early_initcall(rand_initialize);
@@ -1836,9 +1864,10 @@ urandom_read(struct file *file, char __u
 
 	if (!crng_ready() && maxwarn > 0) {
 		maxwarn--;
-		printk(KERN_NOTICE "random: %s: uninitialized urandom read "
-		       "(%zd bytes read)\n",
-		       current->comm, nbytes);
+		if (__ratelimit(&urandom_warning))
+			printk(KERN_NOTICE "random: %s: uninitialized "
+			       "urandom read (%zd bytes read)\n",
+			       current->comm, nbytes);
 		spin_lock_irqsave(&primary_crng.lock, flags);
 		crng_init_cnt = 0;
 		spin_unlock_irqrestore(&primary_crng.lock, flags);
