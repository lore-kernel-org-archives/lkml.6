Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841677-1519419046-2-6229076859916142783
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
    t=1519419045; b=RSBZgRa5HRz328c4T9y9svxLRpofSGkzRpjGDFjuvKbmIsk
    T2Db6oupp6mNtJ+gwa7SEUtCDTjtsqcQ9+i8q1E++MtGlEeJ7LTr7mw0nBHnlfVC
    iUHTzTZlBhbXBkjKGMx71U0g4qSVdlIThjX5dHCZN/x1sJ1jMYPfhPqXaJY5CPJm
    4T53lFAxeDNsPSP6Votd+yzaI+o33I2kGiN+aH9RbOxuDyx+/F4k3OSqJBCTUwD0
    qpboAB6AAExlYXWjHOdpAvKHOeYS/dHYL66TaxpvtBsFfka5D7x/hS+o7vM/qx+A
    ZL6svuqYhqZ+hSCKK8JWXsUAeTdIjSSjuSb4HwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519419045; bh=u12J1FfHXV7g1Qdozv/zqg+JQP
    LOh48NXZ1nmnaaHa4=; b=KHjerUaIMe/fDQdoDxEh+gZqGE4c/zi2IkgxxcI3bH
    ZXKkh4/gTuuuM2gBH2l6oAb5/cBFs+NNPQFNaSlD87/kQ3n44vcgyC4tgDfYehau
    SwFUptG1ronqKGBjOtK7RNXEjfR4h6gsZXFGpTSUdVtjAjtgUk+Aw7+FjM99Ts+L
    SbI74l4QUVAEkjbeXFEDx7s8H8ykqWv+HpquVUTC5dDdBtjsrtK7Srfd96firBAN
    RKJXu59mY9lyuxoxqtUJVTre/hNoIrCXxQHmZdUV7Hfc0AsPwYBbLA+Aq6oAdIPl
    NSU9Q5ira6erjisMJXpI+r8k1uj85jwFKioGqJDynVhg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752422AbeBWSbJ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:31:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34828 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbeBWSbH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:31:07 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 3.18 31/58] ASoC: ux500: add MODULE_LICENSE tag
Date: Fri, 23 Feb 2018 19:26:30 +0100
Message-Id: <20180223170211.698217312@linuxfoundation.org>
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

commit 1783c9d7cb7bc3181b9271665959b87280d98d8e upstream.

This adds MODULE_LICENSE/AUTHOR/DESCRIPTION tags to the ux500
platform drivers, to avoid these build warnings:

WARNING: modpost: missing MODULE_LICENSE() in sound/soc/ux500/snd-soc-ux500-plat-dma.o
WARNING: modpost: missing MODULE_LICENSE() in sound/soc/ux500/snd-soc-ux500-mach-mop500.o

The company no longer exists, so the email addresses of the authors
don't work any more, but I've added them anyway for consistency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/ux500/mop500.c    |    4 ++++
 sound/soc/ux500/ux500_pcm.c |    5 +++++
 2 files changed, 9 insertions(+)

--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -168,3 +168,7 @@ static struct platform_driver snd_soc_mo
 };
 
 module_platform_driver(snd_soc_mop500_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ASoC MOP500 board driver");
+MODULE_AUTHOR("Ola Lilja");
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -166,3 +166,8 @@ int ux500_pcm_unregister_platform(struct
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ux500_pcm_unregister_platform);
+
+MODULE_AUTHOR("Ola Lilja");
+MODULE_AUTHOR("Roger Nilsson");
+MODULE_DESCRIPTION("ASoC UX500 driver");
+MODULE_LICENSE("GPL v2");
