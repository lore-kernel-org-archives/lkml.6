Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490082-1521484555-2-1930306492614117827
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UPPERCASE_50_75 0.008,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521484555; b=CXZZ6LhR0BvunjOwlZHo/RYVhlfSOHEn0JKoKYGQEvjozqJ
    WaPlz7A0o5uf4MivcY5e28Atd4eRYvNmEjEQnAWscssrr2ZJGuU70i/XuHaL6Gtc
    HLamzO/QWwHipnAKsU2odEcMxCcGD4VCyno8smO4yL97/ngG3niUWqLtI21qCMzF
    U62C7IRyP1OkakTHB/XIhIOiAhWLhiByNTQulHvqqPKHkdSxFNcGMnAXNShWl/ck
    rSXHLuSN8Zmm/Ckt5tBpRldOqfRpArxvB8IE3Jh5wVtFGR/p0Wm/W0XaCwSrstoD
    flwkpgSZ952scjd38t06kqEceX4UJRmz1rYmLFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484555; bh=ewZY0aeJ+qhtG99hE4lZ8FqCGy
    IgplgzGrSSYTKumSo=; b=dqPcRjRJfxSV59cgL6Hck4uh94DboDJKm3s4mR9WOW
    xdlBgolKGBNtLSV76hIRHAhSDnXs8CxTxpJvlhONuozzxxADYDIYCU00iR3fgvAE
    fbDT9vE760qU24u1MqLE8xAgSh1GwN/8a5U+34/VdGmZKGulpuVA2pJSzl+qDV1q
    kzDEWSpIh9iL2viNEcjQIXyApXk7GWHJtLni6gq/c7jF/ss++ynweiuh6oufmxCw
    eeR9XCP266nMRKA7F3AlzNsjVdG1POAi2doA2sPJFohrX89NIjMcyVyhHO76vmVg
    H4xxHATs8gWZvWYtMNt8ILG5DHNkHodaTDo5PH+iHWWQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjedvudenucevlhhushhtvghrufhiiigvpedvhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjedvudenucevlhhushhtvghrufhiiigvpedvhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935711AbeCSSfs (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:35:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54130 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032132AbeCSSdC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:33:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 4.15 50/52] phy: phy-brcm-usb-init: Some Low Speed keyboards fail on 7271
Date: Mon, 19 Mar 2018 19:08:48 +0100
Message-Id: <20180319180737.711929771@linuxfoundation.org>
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

commit 279a0cd0e02aa1e506d9acf94a7ecb530821359c upstream.

Enable the the Low Speed Keep Alive signal on the 7271b0 by setting
the LS_KEEP_ALIVE bit in the USB CTRL OBRIDGE register otherwise
some Dell Low Speed keyboards fail.

Also do a little cleanup of the EBRIDGE ESTOP_SCB_REQ bit. Since
this is only used on one platform, remove it from the platform
tables and just use "if (family == ").

Fixes: 49859e55e364 ("phy: usb: phy-brcm-usb: Add Broadcom STB USB phy driver")
Signed-off-by: Al Cooper <alcooperx@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/phy/broadcom/phy-brcm-usb-init.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

--- a/drivers/phy/broadcom/phy-brcm-usb-init.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.c
@@ -50,6 +50,8 @@
 #define   USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK		0x80000000 /* option */
 #define USB_CTRL_EBRIDGE		0x0c
 #define   USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK		0x00020000 /* option */
+#define USB_CTRL_OBRIDGE		0x10
+#define   USB_CTRL_OBRIDGE_LS_KEEP_ALIVE_MASK		0x08000000
 #define USB_CTRL_MDIO			0x14
 #define USB_CTRL_MDIO2			0x18
 #define USB_CTRL_UTMI_CTL_1		0x2c
@@ -116,7 +118,6 @@ enum {
 	USB_CTRL_SETUP_STRAP_IPP_SEL_SELECTOR,
 	USB_CTRL_SETUP_OC3_DISABLE_SELECTOR,
 	USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_SELECTOR,
-	USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_SELECTOR,
 	USB_CTRL_USB_PM_BDC_SOFT_RESETB_SELECTOR,
 	USB_CTRL_USB_PM_XHC_SOFT_RESETB_SELECTOR,
 	USB_CTRL_USB_PM_USB_PWRDN_SELECTOR,
@@ -203,7 +204,6 @@ usb_reg_bits_map_table[BRCM_FAMILY_COUNT
 		USB_CTRL_SETUP_STRAP_IPP_SEL_MASK,
 		USB_CTRL_SETUP_OC3_DISABLE_MASK,
 		0, /* USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK */
-		USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK,
 		0, /* USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK */
 		USB_CTRL_USB_PM_XHC_SOFT_RESETB_MASK,
 		USB_CTRL_USB_PM_USB_PWRDN_MASK,
@@ -225,7 +225,6 @@ usb_reg_bits_map_table[BRCM_FAMILY_COUNT
 		0, /* USB_CTRL_SETUP_STRAP_IPP_SEL_MASK */
 		USB_CTRL_SETUP_OC3_DISABLE_MASK,
 		USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK,
-		USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK,
 		0, /* USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK */
 		USB_CTRL_USB_PM_XHC_SOFT_RESETB_VAR_MASK,
 		0, /* USB_CTRL_USB_PM_USB_PWRDN_MASK */
@@ -247,7 +246,6 @@ usb_reg_bits_map_table[BRCM_FAMILY_COUNT
 		USB_CTRL_SETUP_STRAP_IPP_SEL_MASK,
 		USB_CTRL_SETUP_OC3_DISABLE_MASK,
 		0, /* USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK */
-		USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK,
 		USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK,
 		USB_CTRL_USB_PM_XHC_SOFT_RESETB_MASK,
 		USB_CTRL_USB_PM_USB_PWRDN_MASK,
@@ -269,7 +267,6 @@ usb_reg_bits_map_table[BRCM_FAMILY_COUNT
 		0, /* USB_CTRL_SETUP_STRAP_IPP_SEL_MASK */
 		USB_CTRL_SETUP_OC3_DISABLE_MASK,
 		USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK,
-		USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK,
 		0, /* USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK */
 		USB_CTRL_USB_PM_XHC_SOFT_RESETB_VAR_MASK,
 		0, /* USB_CTRL_USB_PM_USB_PWRDN_MASK */
@@ -291,7 +288,6 @@ usb_reg_bits_map_table[BRCM_FAMILY_COUNT
 		0, /* USB_CTRL_SETUP_STRAP_IPP_SEL_MASK */
 		USB_CTRL_SETUP_OC3_DISABLE_MASK,
 		0, /* USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK */
-		USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK,
 		0, /* USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK */
 		USB_CTRL_USB_PM_XHC_SOFT_RESETB_VAR_MASK,
 		USB_CTRL_USB_PM_USB_PWRDN_MASK,
@@ -313,7 +309,6 @@ usb_reg_bits_map_table[BRCM_FAMILY_COUNT
 		0, /* USB_CTRL_SETUP_STRAP_IPP_SEL_MASK */
 		0, /* USB_CTRL_SETUP_OC3_DISABLE_MASK */
 		USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK,
-		0, /* USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK */
 		0, /* USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK */
 		0, /* USB_CTRL_USB_PM_XHC_SOFT_RESETB_MASK */
 		0, /* USB_CTRL_USB_PM_USB_PWRDN_MASK */
@@ -335,7 +330,6 @@ usb_reg_bits_map_table[BRCM_FAMILY_COUNT
 		USB_CTRL_SETUP_STRAP_IPP_SEL_MASK,
 		USB_CTRL_SETUP_OC3_DISABLE_MASK,
 		0, /* USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK */
-		0, /* USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK */
 		USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK,
 		USB_CTRL_USB_PM_XHC_SOFT_RESETB_MASK,
 		USB_CTRL_USB_PM_USB_PWRDN_MASK,
@@ -357,7 +351,6 @@ usb_reg_bits_map_table[BRCM_FAMILY_COUNT
 		0, /* USB_CTRL_SETUP_STRAP_IPP_SEL_MASK */
 		USB_CTRL_SETUP_OC3_DISABLE_MASK,
 		USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK,
-		0, /* USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK */
 		0, /* USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK */
 		0, /* USB_CTRL_USB_PM_XHC_SOFT_RESETB_MASK */
 		0, /* USB_CTRL_USB_PM_USB_PWRDN_MASK */
@@ -379,7 +372,6 @@ usb_reg_bits_map_table[BRCM_FAMILY_COUNT
 		USB_CTRL_SETUP_STRAP_IPP_SEL_MASK,
 		USB_CTRL_SETUP_OC3_DISABLE_MASK,
 		0, /* USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK */
-		USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK,
 		USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK,
 		USB_CTRL_USB_PM_XHC_SOFT_RESETB_MASK,
 		USB_CTRL_USB_PM_USB_PWRDN_MASK,
@@ -401,7 +393,6 @@ usb_reg_bits_map_table[BRCM_FAMILY_COUNT
 		USB_CTRL_SETUP_STRAP_IPP_SEL_MASK,
 		USB_CTRL_SETUP_OC3_DISABLE_MASK,
 		0, /* USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK */
-		USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK,
 		USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK,
 		USB_CTRL_USB_PM_XHC_SOFT_RESETB_MASK,
 		USB_CTRL_USB_PM_USB_PWRDN_MASK,
@@ -952,13 +943,17 @@ void brcm_usb_init_eohci(struct brcm_usb
 		 * Don't enable this so the memory controller doesn't read
 		 * into memory holes. NOTE: This bit is low true on 7366C0.
 		 */
-		USB_CTRL_SET_FAMILY(params, EBRIDGE, ESTOP_SCB_REQ);
+		USB_CTRL_SET(ctrl, EBRIDGE, ESTOP_SCB_REQ);
 
 	/* Setup the endian bits */
 	reg = brcmusb_readl(USB_CTRL_REG(ctrl, SETUP));
 	reg &= ~USB_CTRL_SETUP_ENDIAN_BITS;
 	reg |= USB_CTRL_MASK_FAMILY(params, SETUP, ENDIAN);
 	brcmusb_writel(reg, USB_CTRL_REG(ctrl, SETUP));
+
+	if (params->selected_family == BRCM_FAMILY_7271A0)
+		/* Enable LS keep alive fix for certain keyboards */
+		USB_CTRL_SET(ctrl, OBRIDGE, LS_KEEP_ALIVE);
 }
 
 void brcm_usb_init_xhci(struct brcm_usb_init_params *params)
