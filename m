Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490082-1521484524-2-5141839324528338577
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
    t=1521484524; b=JwNJCAX4SzSEi2GNo6pxH7wBhJh0sX9KkdjY20H5xgRAem4
    RBYstw0IQrmZFkie5hvX2liqTdDDM3kCvyRC/yg65nChH2xpihnfhZ54U6EGo4Jq
    rxBdefNOueTxzl8thEUu2I+Sr8lZJYRjzrpuA/uv8Fv/+LkZYtut75maqdhgtdbQ
    tdINBF2Edp/KFWKJ7afY4jvvAOQjDAqNEteT3A4YJVMSQvl5Hsd47pO/LAXlilNe
    m5qjaehXu1rUHuB9MDJQnZ+5BkzBJQhnLRKlnLrzcs2CzjXlDmO5akQoqQ8BHIRY
    4vj2hM0y2eB6EUvEExQz8e/TO8z+Vrp/BHUvxUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484524; bh=TpUEAS1TDI6xpcnd0edlwZ5Yho
    Q1X3Np0X766yAJbu0=; b=hQZDCvpJzbIbd4PQgh4uF45gr8vDtUo/B0OQhwMNmr
    5w4h1heBGqBAGn4cA3E8G5Ns0D6m3NXl5Lw8DhhGnxbKp0Kq9wzgFLkJh5AWq5Rj
    l5wczWnMV8oMwXMD3VKESwps5qbzKqN8Su9Bnk5SKOtZ65WuBJvJy8KnToRjZNzT
    KS1B03YqzK6QcEL+PcVuZKyAF2VMoveB8mO1F5dgyHfp19xHuzYDAck5m3EHVc1f
    cJXwVrqa6sQDftHBuawv9I9GKShoO5YNnY3XFaeKSPhZXGY1i4AKfluQMtXgSMA/
    Oh5bjeM9nTusNyf/Y8Csw3llCw2+lomtE0Tl819VIJMw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefudduieenucevlhhushhtvghrufhiiigvpeduvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefudduieenucevlhhushhtvghrufhiiigvpeduvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032166AbeCSSdH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:33:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54146 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032160AbeCSSdE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:33:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 4.15 51/52] phy: phy-brcm-usb-init: DRD mode can cause crash on startup
Date: Mon, 19 Mar 2018 19:08:49 +0100
Message-Id: <20180319180737.751421102@linuxfoundation.org>
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

commit 0aa0c12262fd848c48448c39ff6c1c097be00dd4 upstream.

This is caused by a bug in the BDC core. When the BDC core comes
out of reset and it's not selected, it gets a backup clock. When
the BDC core is selected, it get's the main clock. If HOST mode
is then selected the BDC core has the main clock shut off but
the backup clock is not restored.

The failure scenario and cause are as follows:
- DRD mode is active
- Device mode is selected first in bootloader
- When host mode is now selected, the clock to the BDC is cut off.
- BDC registers are inaccessible and therefore the BDC driver
  crashes upon Linux boot.

The fix is to have the phy driver always force a BDC reset on
startup.

Fixes: 49859e55e364 ("phy: usb: phy-brcm-usb: Add Broadcom STB USB phy driver")
Signed-off-by: Al Cooper <alcooperx@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/phy/broadcom/phy-brcm-usb-init.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/phy/broadcom/phy-brcm-usb-init.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.c
@@ -917,6 +917,7 @@ void brcm_usb_init_common(struct brcm_us
 			USB_CTRL_UNSET_FAMILY(params, USB_PM, BDC_SOFT_RESETB);
 			break;
 		default:
+			USB_CTRL_UNSET_FAMILY(params, USB_PM, BDC_SOFT_RESETB);
 			USB_CTRL_SET_FAMILY(params, USB_PM, BDC_SOFT_RESETB);
 		break;
 		}
