Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1546708-1519219107-2-3375784785393453490
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
    t=1519219106; b=KoXo9t1bs5qCOg9IDD0HJn8iBLRm1uxc/X8DQmkjT7W3gh2
    /i2j5naNP310MeZmp0XjQOxczUOgMQnSJAr7Ly/gVMHfQxfxKWTYXSv4YwCT880A
    3UyLowtqy+g7fKtV8f2EvvvymI9oRm8erV4YHVhu5MhdYzuBEE/5zeS+9nBQervo
    fbwnDzxzgWRBe6bKcGkGD6kIYOQemj+eCc7KfuRHVBsWI0t8dZFIhyrmLZMCGl2E
    KbZC+ryuerYddPV5SdLb0uGbzDEsfzVKbvuKK0xt1VWIA2VwqrezIHMa5x0u3hY3
    mVTVaAhFe/jH2bOZOt2fT1T1UCZF30yv0w5Ujqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519219106; bh=2NX3dnaT+lA3w/g6OvOgf4Xd16
    ygpWMr/LZFe7EMEt4=; b=JgADDtSQbiL5sRpHnLc/pVj+dP+ZwO4BMX+RLmRUPe
    APGt4En74gZSzFHnsGIEqTZbekkllBrZ6wM1m0LWnjL5KFtiF5j5d4CnmXmI73K0
    UVp4diwxD4PPLgtcaKMof9jXsIn0ipyKbape0nbDfwCJqHtzgSwudJhUVDacVH50
    qqhMVfxs4dgL+dGhO9yBtQmkIJ/P8OJvEqjVQeo3qHI701xpfQ4p6Fu1JwFpMIgf
    4RH58x8rWORCaqR5VOX5znENR5CqtqO4pjozliSU+hF8cIW/NmoFXy1Ii6BLAA5N
    5Fu4rQHId/tF67oj3bSq1x6ZTX+7+6DKTpAm4ldC1h2g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965643AbeBUNMp (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:12:45 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45808 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965623AbeBUNMo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:12:44 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.15 155/163] ARM: pxa/tosa-bt: add MODULE_LICENSE tag
Date: Wed, 21 Feb 2018 13:49:44 +0100
Message-Id: <20180221124538.547075576@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 3343647813fdf0f2409fbf5816ee3e0622168079 upstream.

Without this tag, we get a build warning:

WARNING: modpost: missing MODULE_LICENSE() in arch/arm/mach-pxa/tosa-bt.o

For completeness, I'm also adding author and description fields.

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-pxa/tosa-bt.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/arm/mach-pxa/tosa-bt.c
+++ b/arch/arm/mach-pxa/tosa-bt.c
@@ -132,3 +132,7 @@ static struct platform_driver tosa_bt_dr
 	},
 };
 module_platform_driver(tosa_bt_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Dmitry Baryshkov");
+MODULE_DESCRIPTION("Bluetooth built-in chip control");
