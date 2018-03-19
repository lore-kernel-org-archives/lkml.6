Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3444635-1521483543-2-17070511299197676360
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
    t=1521483543; b=Lj1rdfS7W+I626j++kxshR/OTlh3whxF7FqbnWla71eU5wT
    3FVWJ+8+jJvYX31GOm+JxWE1wBRGFDj0ANWdP2uh+zbD2O4jgAtUcWGpf+QO0f74
    UfRgi7Fuf0HUh3SVUcu+Vuj2ZPMD6S/UmNR42AZy8RKF//sMlUua9xfKOuTkJiQh
    Hqz7rdvPp8jQjaq+gXXPh60tZHWx3dz5/nrmoD/qaf2iA4RYfxpPRj+Z4UVmH3cn
    O6nlfEeikm29DTOzZRZ/xvKwUtgFHE/N5eyq4NTwHFl780k+4cuFCQsB8ToOnoFa
    wo13Gf8ke9NmtBF9ckcoHtQmjlcpiuRX6Ifrm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483543; bh=HJWMOusX0nmLN8EFzBy0D8mdeY
    2GpKoLzwPTS9HZ5q4=; b=YOfLZqXJmB1szeZ1oqTWlUTAZbqQYRKAJiXrRHaioR
    cdi6sS1VHffy/Tk6DwETv+Qr1fSYgJzHK7AZflDwk10ko/qQXLI6tbZliYCZ7mkr
    i1rMJSRRWREtPHfjL7TjrbiQzw6ynGxYb3iq3906LxgF1kyKc+gPNBYaiiDkhyNL
    RykVfP5odDKrBZu1E+v+gOOLmuwRvNfOHf9YUg1qQqkmdhuUK3uf02ualy3CKRPc
    /Tk0C+AQH667FGDWHkRfT5uUk7GkF9/nb1o15/jqhF6xSz+7Iu/8ooB//vXPdK/Z
    YUeEnG1bKC3xEiP5GcdBEAV8qS2GtbuPw05+zLXUmzBA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeftdejieenucevlhhushhtvghrufhiiigvpeduuddv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeftdejieenucevlhhushhtvghrufhiiigvpeduuddv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030540AbeCSSS4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:18:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46724 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030905AbeCSSSz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:18:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Varsha Rao <rvarsha016@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 004/241] staging: speakup: Replace BUG_ON() with WARN_ON().
Date: Mon, 19 Mar 2018 19:04:29 +0100
Message-Id: <20180319180751.358748837@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
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

From: Varsha Rao <rvarsha016@gmail.com>


[ Upstream commit d351c2db5420bb17dcd2d9aac7ddb5f64c6d04b3 ]

BUG_ON() is replaced with WARN_ON() and EINVAL is returned, when
WARN_ON() is true. This fixes the following checkpatch issue:

Avoid crashing the kernel - try using WARN_ON & recovery code rather
than BUG() or BUG_ON().

Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/speakup/kobjects.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/staging/speakup/kobjects.c
+++ b/drivers/staging/speakup/kobjects.c
@@ -834,7 +834,9 @@ static ssize_t message_show(struct kobje
 	struct msg_group_t *group = spk_find_msg_group(attr->attr.name);
 	unsigned long flags;
 
-	BUG_ON(!group);
+	if (WARN_ON(!group))
+		return -EINVAL;
+
 	spin_lock_irqsave(&speakup_info.spinlock, flags);
 	retval = message_show_helper(buf, group->start, group->end);
 	spin_unlock_irqrestore(&speakup_info.spinlock, flags);
@@ -846,7 +848,9 @@ static ssize_t message_store(struct kobj
 {
 	struct msg_group_t *group = spk_find_msg_group(attr->attr.name);
 
-	BUG_ON(!group);
+	if (WARN_ON(!group))
+		return -EINVAL;
+
 	return message_store_helper(buf, count, group);
 }
 
