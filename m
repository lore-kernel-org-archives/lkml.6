Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-730071-1518944944-2-14105256332360103980
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518944943; b=i3CEs9Fe+ZG3WWjlew8UEI1VBtmvsBFRHeMKKyZFtfq8yWX
    OMdu4Dzns6SObpdNtybh31Si82X9mVQgTpCOyBjtCGTAh4b6HeACxIW/BNZhBzcx
    7vxRMqD57FF5kM1ImOiWJG1Gx6yVo3iyrsGCqgBcEjG1+K7VhLM0ZM1ZCnm+nMcA
    57ODF2JxRTiOzViq9EqR2T/bz/cOJCjt8avH8J8PDxsIq9JLNQMGLmI4nRw4bxPg
    1mmedNFES+ySqEJy1HyZISe/axs0qCcwFjy793uXmfsHXgFVwfBpWqTgST1Hz42+
    sjQd45FPDzxaKNxwXY2ToPmLV3S6koBja6jftCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518944943;
    bh=uK4NOtQ9gNCZmCIGVvUL0kdO4YAuP/E1wa9NBx5im7E=; b=ZW0hWtT3r4sy
    zCCy7KOGy1UzQuMlBw/cLYsQksx6sY6qDuhpHSiIFCgAM7nJCGX6r1L1C77uZrEg
    VL4v2KqolIeUTDgNE8dmtioX+nb8C9wZgsbQjyN0MNBen19P1G77LAdTjc5cFV1/
    327ls+8EXlxF8pHd+UXHuzrv8hvT3lZHfQKxjgpLsU8n5bCbYU4HfAcRUe4pj5RH
    jBvvptiNeFjlbe1+Bin6KhPXfmT/XtfCi6fHAkP//1G1tWA3rj/++KU++EsjEJvT
    5AGaaXVuaMb7cglXm1Deu+t1JjI5l5GfNQepYgGhT0J1pbe2kaKQk+c3ku3ro8tV
    PS64onRnmw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbeBRJIn (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Feb 2018 04:08:43 -0500
Received: from mga12.intel.com ([192.55.52.136]:12868 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751187AbeBRJI1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 18 Feb 2018 04:08:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,529,1511856000";
   d="scan'208";a="28919133"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>, stable@vger.kernel.org
Subject: [char-misc 2/2] mei: me: add cannon point device ids for 4th device
Date: Sun, 18 Feb 2018 11:05:16 +0200
Message-Id: <20180218090516.21077-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180218090516.21077-1-tomas.winkler@intel.com>
References: <20180218090516.21077-1-tomas.winkler@intel.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add cannon point device ids for 4th (itouch) device.

Cc: <stable@vger.kernel.org> 4.14+
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw-me-regs.h | 2 ++
 drivers/misc/mei/pci-me.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index bda3bd8f3141..e4b10b2d1a08 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -133,7 +133,9 @@
 #define MEI_DEV_ID_KBP_2      0xA2BB  /* Kaby Point 2 */
 
 #define MEI_DEV_ID_CNP_LP     0x9DE0  /* Cannon Point LP */
+#define MEI_DEV_ID_CNP_LP_4   0x9DE4  /* Cannon Point LP 4 (iTouch) */
 #define MEI_DEV_ID_CNP_H      0xA360  /* Cannon Point H */
+#define MEI_DEV_ID_CNP_H_4    0xA364  /* Cannon Point H 4 (iTouch) */
 
 /*
  * MEI HW Section
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index f915000e5bf9..ea4e152270a3 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -99,7 +99,9 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{MEI_PCI_DEVICE(MEI_DEV_ID_KBP_2, MEI_ME_PCH8_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_LP, MEI_ME_PCH8_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_LP_4, MEI_ME_PCH8_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_H, MEI_ME_PCH8_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_H_4, MEI_ME_PCH8_CFG)},
 
 	/* required last entry */
 	{0, }
-- 
2.14.3
