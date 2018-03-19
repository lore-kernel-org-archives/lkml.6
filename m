Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490358-1521484535-2-4636160636198915485
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-asciica,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521484535; b=dO2DrbDDgm5AVeTU1Fbso6E/8pLQjCtpE6ij5Ld8fdhgkFi
    hx6NWNzzoxAUSIF3zfHtY7GDp/9qGtZm5HqvO4s3uDkTsWhReLguHyrNyD1wgE05
    nei1YJZd4rE72WZmOR92fnX7CnWoWrT8pyYVrCsERXxa1BSnOueUANsf8Sork/0j
    1SozFPS5LST6wMZp0B12v8CHN7VfoLSchMBn9onp7OTQ1hUJcLYhMsQGfhDc98NQ
    BT0Hj4+b9UCwb7Lq8w0s3y1WU04640h/IH/PWk66XNHaLYtC50TI3YhTFKYV8ScF
    VZaKpFoatn1WmZYpqJBKY13qEaa+jYScqAWT8Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484535; bh=m5aMRAwnjMuK+D54B4SS0Jyuyz
    uYIhC51+MbAOj6NOY=; b=p/qT8GlFoQe0gAqbkGSSgO+ekQu06H/WjlY1zRwjQv
    tkiwUKFTY2r0didaPWU9iESc5iy9eJZTjJwGyfsx7Qq6/E6MhYvttqcqDjlBdvaP
    4WUZ7hcklBT4vOY2HuHVgzIS9FdQMGpYyKxvm6W803MaXFmFH7Vm7Gk187QGp9Hj
    zRGmvrBwhwn91OGAszYb4o+9V6TaUaHBJN+HncwvpWRxkAEXr3sRec+Amny++tN3
    lZq1niHKFftYU4ri/oQNxjPgJ0Jkp1PpbqKFhrf7foVW78jQuXTUathz8iUC6Vb1
    GX4Y8jtGf5tMoKi8RoTZE62MhmbGR+5i32EyFIklAUKA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeftdejvdenucevlhhushhtvghrufhiiigvpedvje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeftdejvdenucevlhhushhtvghrufhiiigvpedvje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934348AbeCSSfV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:35:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54154 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032165AbeCSSdH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:33:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 4.15 52/52] phy: phy-brcm-usb-init: Power down USB 3.0 PHY when XHCI disabled
Date: Mon, 19 Mar 2018 19:08:50 +0100
Message-Id: <20180319180737.806032743@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
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

From: Al Cooper <al.cooper@broadcom.com>

commit cd6f769fdea7ff7d77a6cc97658c60ca0b836d0e upstream.

Set PHY3_IDDQ_OVERRIDE in the xhci uninit routine. This will save
additional power when the XHCI driver is not enabled.

Fixes: 49859e55e364 ("phy: usb: phy-brcm-usb: Add Broadcom STB USB phy driver")
Signed-off-by: Al Cooper <alcooperx@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/phy/broadcom/phy-brcm-usb-init.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/phy/broadcom/phy-brcm-usb-init.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.c
@@ -73,6 +73,7 @@
 #define   USB_CTRL_USB30_CTL1_USB3_IPP_MASK		0x20000000 /* option */
 #define USB_CTRL_USB30_PCTL		0x70
 #define   USB_CTRL_USB30_PCTL_PHY3_SOFT_RESETB_MASK	0x00000002
+#define   USB_CTRL_USB30_PCTL_PHY3_IDDQ_OVERRIDE_MASK	0x00008000
 #define   USB_CTRL_USB30_PCTL_PHY3_SOFT_RESETB_P1_MASK	0x00020000
 #define USB_CTRL_USB_DEVICE_CTL1	0x90
 #define   USB_CTRL_USB_DEVICE_CTL1_PORT_MODE_MASK	0x00000003 /* option */
@@ -999,6 +1000,7 @@ void brcm_usb_uninit_eohci(struct brcm_u
 void brcm_usb_uninit_xhci(struct brcm_usb_init_params *params)
 {
 	brcmusb_xhci_soft_reset(params, 1);
+	USB_CTRL_SET(params->ctrl_regs, USB30_PCTL, PHY3_IDDQ_OVERRIDE);
 }
 
 void brcm_usb_set_family_map(struct brcm_usb_init_params *params)
