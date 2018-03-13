Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3504153-1520956255-2-16652785107960820244
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520956255; b=hPHO+CfQWvmv1nvbcduOA5c6655nezqT2iqxwR16nGyMLXN
    DME2n1yuNPFVHVSYiCcLF938dEtoO/YffC8nHTfA98b0WTuPm88d7roBS9fZCZoD
    972SAC6lN52OEnxgtTHIIqoolyEqRkpenLLAgGUaaj9f/XGWklCCAMUjnutyHVv/
    J70OCY+OpGtCgaq8TIY93jLa610mhBkrk6PD44MvhtK7VIEceY6eMnvmqAjOSvm7
    1AxyP8j+t9e7SCZEWEyb4+LneyxFCi0jLdW1yFKZAdwv5CJlsTW0XQyUejGusdDV
    c6Bme8QwlPu553BoAXHfQOy7ALOrfzL6MkDSTSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1520956255; bh=QvmGux6T71i84c07NYTsnUiGNZ
    1dr3mhDecFEyL3DXE=; b=wyb0XRbPAunbrAMQmZb27aqlOMk9t36bSC1w3lxOl9
    B4y0hG42QtgyxoZcPXAm8vnrZ0HXaawJSa4wJOD/r3uvcq/WnmGqQpgXIPU5V15W
    DrkYU470IlELjm7HpItgHno7RjGfGxBY71Jso7H/4yMp3jEKGTqnRMWxBH6pH/CS
    Qg1/MIVP26GOVTR/LKkYvCl7oiCPXmB5YQhOUbcVjULWUDLQkE4yjeC8B1AoDaEi
    NdsQYs08Ni0SG2vKut1d2F7bkb89hNMqXUfw+cXugdSuHZD1b4Ldv/sF9T/bJjfl
    xVtlnp50Fpts1lPZPVZA04FIHo28eChsTsWz3aXQfpmg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964789AbeCMPuj (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:50:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33188 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934795AbeCMPu0 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 13 Mar 2018 11:50:26 -0400
From: Colin King <colin.king@canonical.com>
To: John Youn <johnyoun@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][usb-next] usb: dwc2: ix spelling mistake: "genereted" -> "generated"
Date: Tue, 13 Mar 2018 15:50:24 +0000
Message-Id: <20180313155024.1195-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_warn warning message text.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/dwc2/hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index dcfda5eb4cac..190f95964000 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -5433,7 +5433,7 @@ int dwc2_host_enter_hibernation(struct dwc2_hsotg *hsotg)
 
 	/* Wait for the HPRT0.PrtSusp register field to be set */
 	if (dwc2_hsotg_wait_bit_set(hsotg, HPRT0, HPRT0_SUSP, 300))
-		dev_warn(hsotg->dev, "Suspend wasn't genereted\n");
+		dev_warn(hsotg->dev, "Suspend wasn't generated\n");
 
 	/*
 	 * We need to disable interrupts to prevent servicing of any IRQ
-- 
2.15.1

