Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490358-1521484545-2-15576161662429814173
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
    t=1521484544; b=J3VmRO1JLrXu+IhMvH1LweaVvYzaUG8HYBK17qq/vGoghHR
    voujCXB1Qvx/+d+qd2ztQdE/tEjIjSVQCLRYLEw7z4AW2tVFFQge+SBGgrT0389T
    cPnzdqm45sBeGDFgzSL+Nhdh+RUhYW/9iCiACjPcZ+NcV5riHLtLzL28eJ8dnM7F
    6EYAVkEqIqw+x2bXuOoQm7G8SrEGcH4u90hAuhtxvcpYM8okWEF12cZMqtSkpAWC
    dhJ0GHR1W6NoU6rp8Q4lzQL5DVlr58hWEf382Zo3fVgHn7klIZWSPseo09MhrHjH
    m5d6REQYsDm4ISz1F41UICY62j0p+9pWtGsD1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484544; bh=O/bzCgYoVdQeGEFqq8Tz8arUJF
    t/WRXTdsivyn9m8+U=; b=JqrzKQthKR2KF3AkB5IJ9olRHqYs5wAEny3rFQx4wO
    u0mB/efiUVT+AyJ/QJ90zerjpxCu2cU6iBg1ICxRWZvGy98R/menxFY9ThT/5rQl
    6wHHovTD9AVKYqUQmztH8Dz/mI7RHuMprA7UfM3wR343HsCzeyaJhTMxoelV/Gba
    AVNv5nSUMqCIlRQ8QvcCkYSBaugoV/VoeNTX35j3nOO71opFVLE5xBVAdy+NbMlP
    Z74vbQqn2t7zWxQo0Lk3B6mhjPhuYqSeiWXKZQVkvNQ4YaLj73rvwpHXDTHxy+dJ
    nFTw16n0WpuHFIZ13bK9sVZzuXR74Dp5u5dGdaz7YBxA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedvkedvjeenucevlhhushhtvghrufhiiigvpeefud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedvkedvjeenucevlhhushhtvghrufhiiigvpeefud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032155AbeCSSdC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:33:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54122 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032135AbeCSSc7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:32:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 4.15 49/52] phy: phy-brcm-usb: Fix two DT properties to match bindings doc
Date: Mon, 19 Mar 2018 19:08:47 +0100
Message-Id: <20180319180737.661657538@linuxfoundation.org>
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

From: Al Cooper <alcooperx@gmail.com>

commit 5e498ff117c19fd80181b5bb09ecb024b552ece8 upstream.

Change "brcm,has_xhci" and "brcm,has_eohci" device tree properties
to the preferred "brcm,has-xhci" and "brcm,has-eohci". This also
matches the existing device tree bindings document.

Fixes: 49859e55e364 ("phy: usb: phy-brcm-usb: Add Broadcom STB USB phy driver")
Signed-off-by: Al Cooper <alcooperx@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/phy/broadcom/phy-brcm-usb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -338,9 +338,9 @@ static int brcm_usb_phy_probe(struct pla
 			      ARRAY_SIZE(brcm_dr_mode_to_name),
 			mode, &priv->ini.mode);
 	}
-	if (of_property_read_bool(dn, "brcm,has_xhci"))
+	if (of_property_read_bool(dn, "brcm,has-xhci"))
 		priv->has_xhci = true;
-	if (of_property_read_bool(dn, "brcm,has_eohci"))
+	if (of_property_read_bool(dn, "brcm,has-eohci"))
 		priv->has_eohci = true;
 
 	err = brcm_usb_phy_dvr_init(dev, priv, dn);
