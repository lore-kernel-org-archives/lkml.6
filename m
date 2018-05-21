Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526937469-2-2309018944248101736
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enfrro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937468; b=QkqONPI/6IrrdcO9Q4BeJZdC8kYrnIy1Ek4uXgdAV0IX+e5lmw
    tb2VVfKSyft8HC0E5+NemevNCsKnjQmeFPqRe8ctURbkNWTmFa5FiPtAJ3iY9DRD
    gWfUTgmeYZe3cm+GgeXIHGX9Ifkh3aY4s5KvOr9q61vLmSPc+smGEhO+uzXL3Uck
    54mrgM9I22Rrdr607NSYFHEXC73u8CmhIZYOeNKScu6hwMOe9OI5jFIkQ/oeECjW
    V1R3yUKriss2NTK1xQoWvJ71bKW5EBY1VsbsifpmFt0j+jh0OQGignq53qPCeDW7
    7XygIgHLwri7I3v1ANbvwYSxFMOPtUTrOlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937468; bh=/hEJwz0EQNb4jTAkJzX3jKlU5FUjMB
    58mnsAsnWY1b4=; b=PUl6XXrkiqv6AOvG5pSwq8DTyWpYxws5U1Nnabu9SjTW/h
    8G0yAvo3iDpl2K+yQ5hpMRSxbS1cj/6mrJj0B5iSI8a1ATciLJyVLvgXZAE9/GVO
    /Jd25t8CY+MW7eJ0saf6Vz8Gb1swQwxC0Il/CX7J3Z5tes1CEPMqVzTlXfrZhedF
    OXYIJ8bV1chsmPwAL2f/AI6TRy+UUTUJJyQA+Yb4xdWCMzakT45/jbVPJ3e76fVM
    9l98KZcPYLYM8YfIZ9NHeszoBrCgc8pVP6yN6FGw2dDpD0rSxTzgj7liczmj4E6L
    aqbXEILmi1h7eiJ+saz66s/gUAE15Eg3TjJ3+9lQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=PLt4L7Zm x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=PLt4L7Zm x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI5CcGyazsgG0IIGUm477lXi+4ciFrpIdre5fryjJ62lUBCir3BHaU9F23Iog8v2dxNWHzFAdDaQuhwY4CC63HI/0XhBq6TDIGJ8Tugz7OCFjhDCys8h
    ayCRwhMZhk6Lxl4CKVU6KofjdGL8qG/oooYpuwa6fAwmwtwHW9H7lFyWqo3SvheOs5RAwAY+Maj2Vc/ICLDCKUF02hZnnUtQn5oNRfyC9IFQcVkFJio7UO6K
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=cm27Pg_UAAAA:8 a=pBOR-ozoAAAA:8 a=ag1SF4gXAAAA:8 a=k5_1euZgLRBG61PYFQoA:9
    a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753314AbeEUVRn (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:17:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:32812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752771AbeEUVRj (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:17:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 56/87] proc: Provide details on speculation flaw mitigations
Date: Mon, 21 May 2018 23:11:32 +0200
Message-Id: <20180521210425.274266119@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit fae1fa0fc6cca8beee3ab8ed71d54f9a78fa3f64 upstream

As done with seccomp and no_new_privs, also show speculation flaw
mitigation state in /proc/$pid/status.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/array.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -80,6 +80,7 @@
 #include <linux/delayacct.h>
 #include <linux/seq_file.h>
 #include <linux/pid_namespace.h>
+#include <linux/prctl.h>
 #include <linux/ptrace.h>
 #include <linux/tracehook.h>
 #include <linux/string_helpers.h>
@@ -345,8 +346,29 @@ static inline void task_seccomp(struct s
 {
 #ifdef CONFIG_SECCOMP
 	seq_put_decimal_ull(m, "Seccomp:\t", p->seccomp.mode);
-	seq_putc(m, '\n');
 #endif
+	seq_printf(m, "\nSpeculation Store Bypass:\t");
+	switch (arch_prctl_spec_ctrl_get(p, PR_SPEC_STORE_BYPASS)) {
+	case -EINVAL:
+		seq_printf(m, "unknown");
+		break;
+	case PR_SPEC_NOT_AFFECTED:
+		seq_printf(m, "not vulnerable");
+		break;
+	case PR_SPEC_PRCTL | PR_SPEC_DISABLE:
+		seq_printf(m, "thread mitigated");
+		break;
+	case PR_SPEC_PRCTL | PR_SPEC_ENABLE:
+		seq_printf(m, "thread vulnerable");
+		break;
+	case PR_SPEC_DISABLE:
+		seq_printf(m, "globally mitigated");
+		break;
+	default:
+		seq_printf(m, "vulnerable");
+		break;
+	}
+	seq_putc(m, '\n');
 }
 
 static inline void task_context_switch_counts(struct seq_file *m,
