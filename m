Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841677-1519419039-2-764641664125569492
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519419038; b=TqbuaAjbbBHUl5lIQopjNBVobEufyqmbPsRyiHQw9J2xJvn
    hWRPKZ0E4zwjZohl5PfCoa6aKQXaepznkAsIAF8zyMEL5ILMqa0ZKN182SBWupLe
    Z54RYZ5E8OGydAAGHwRThZfT5K6snuuWfKzxKFzKWrNXL8c6VoB0Y4RA1qE+Tdr5
    71Zw30iJKcQFYfP88o1EsJYmyD+TbBgb+ojacZTCs2eNFuEAQAtbgJF9JLRO/pEY
    KPkUt65HjEvjy5EsnNCdkTEHKyh1cWhuVoEERwK6wyDmA4bjIJf+rOpv4fuZo6Gc
    qzKRDHQl7JEW1RKAoB1Ph7Ony0Zh5MMZS8isUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519419038; bh=2fHKIBBkSkJbFwEhQVh8FRE6rW
    JlfUorUPPCRgvy87E=; b=jsYesnk7x5D5L0aenFmfjAQTYX8fN+i+nkmhsavVUx
    hlI82cq2/QEM6PLZ2LPHN9kR4FmSgBbRqf5f+vdoDcgOQc/VbJK8XFlzILZ738SK
    JXiUbp5X/M22kE0VXpRUKdibvnq6JQFRmmKIDYHSxD6Xj3iadAK4DyQbuZIgQQrF
    zyOJg72zbS6WLcxVlX3Z3XT2ALvUqFVVISMwLHlmAx5Wle9iCoRSBZ8XAVtyYlDd
    KXbe1pBPZZw+pvRQxOT3Z+8GqzP8U30J6X/MOeb1g3pN0BqLx3k81ueLjj6KszCa
    wO42XXrjaayptmQYoMeflwVEW9yWp5Z5ehoV6VYXKaMg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752499AbeBWSbR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:31:17 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35076 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbeBWSbP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:31:15 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 3.18 32/58] video: fbdev/mmp: add MODULE_LICENSE
Date: Fri, 23 Feb 2018 19:26:31 +0100
Message-Id: <20180223170211.872970710@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit c1530ac5a3ce93a1f02adabc4508b5fbf862dfe2 upstream.

Kbuild complains about the lack of a license tag in this driver:

WARNING: modpost: missing MODULE_LICENSE() in drivers/video/fbdev/mmp/mmp_disp.o

This adds the license, author and description tags.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/mmp/core.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/video/fbdev/mmp/core.c
+++ b/drivers/video/fbdev/mmp/core.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/export.h>
+#include <linux/module.h>
 #include <video/mmp_disp.h>
 
 static struct mmp_overlay *path_get_overlay(struct mmp_path *path,
@@ -249,3 +250,7 @@ void mmp_unregister_path(struct mmp_path
 	mutex_unlock(&disp_lock);
 }
 EXPORT_SYMBOL_GPL(mmp_unregister_path);
+
+MODULE_AUTHOR("Zhou Zhu <zzhu3@marvell.com>");
+MODULE_DESCRIPTION("Marvell MMP display framework");
+MODULE_LICENSE("GPL");
