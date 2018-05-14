Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-402196-1526281440-2-7912114120528287829
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526281440; b=iNe1gwCy+QLS0jKPZXRqls9N+litPbuECUNrEGeqlLk2QSjQU3
    Xdpcx1C5n9y+xB8+iOV+CMTH/z5SToWI5xAUzAqeV2yh00nLRQ3KkYawUbhkuh7s
    tu/Si0zh9L7nhWohrLtPx+QNuJmlUD/cPeNFWQwkmKBeoMZ6Pg1LDbrv9u90mIMN
    sAg8QpxarktthmcJ4ATVxTL7RUSbdfTu9NQvPTznuSPtOL5wBwSJfxpS9bOA9Yif
    fPZmNVIm8u9Y7+qtP12K3qHe4y1fzusOsUk00kBhVc+fEbbyh7a23HK3ZC+HkNAQ
    LPxp0GJTPCZlv8gYPwjZbkpueBpD9lJSWToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526281440; bh=6BcRXT7Ky3bg04kHtjFMcCN36jEHPT
    LchPKmDHgtnok=; b=IeAKUkVhvG2fwzEIRrTFykElPUHm/8LQyftUpyEYsG7u9V
    yjx6+hi/QDxjcjPPHdqKmZMjOqbUDRHQVkgDY+OavwzIYiNfeNQv0JUmm2v9c78Q
    k/GQSP7ah/kUHj8gCKDSlBJioMIFcIJi5WmqF6xWw48tWpWwTy0xfbobkeCerrzG
    X7WamOHNig2rhRPnHYGtiKsNKYajnMnmahmjq5/DA6bCeg/+3Q0i3ugeMz7MNCES
    HL5qereIzpUK/PdDqv1z5+nahSYxqC7d8I7Ob+I5j1z9NAjVpB5Fo4RUL8+WCfP5
    GVZoaOu8Ne5a+9OD4+K1gfNPDt5k5HBJ7YQjHWEQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=2GPwfu+S x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=2GPwfu+S x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEQHR/0VW3uqXqnSzKSi5zwW477aqW/ZGcJIbzlYoqM9+VGg0ufcCL6UWlM3/t95xnHCIexOdCcbm3/e0u5c2XHzs9dJ5x+QeCyAa9Ne0mHEPUvU8+Ox
    3tqA1fkSlMVftf/vJJ8s0Cbu6WaLLQJwqSDTK1XbrC7Lkb2SWzWVa09nRlVlJBd93/rjnPZ9Y070hhy4JCTuIcM41Cwvs08jjF+4+rWQXAlB8AuNkfsboCO/
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=Dei6p5SHAAAA:8 a=ag1SF4gXAAAA:8
    a=wZEJlFEmUFyI5RccdPIA:9 a=mEtu9yAtk2m4jspc:21 a=gIK4B3dAEqZ1CeIe:21
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=M-Yerj1wOn-OpK7r_3ei:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754000AbeENHAS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 03:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754121AbeENHAO (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 03:00:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeremy Cline <jcline@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.16 58/72] Bluetooth: btusb: Only check needs_reset_resume DMI table for QCA rome chipsets
Date: Mon, 14 May 2018 08:49:15 +0200
Message-Id: <20180514064827.064934511@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit fc54910280eb38bde923cdf0898e74687d8e6989 upstream.

Jeremy Cline correctly points out in rhbz#1514836 that a device where the
QCA rome chipset needs the USB_QUIRK_RESET_RESUME quirk, may also ship
with a different wifi/bt chipset in some configurations.

If that is the case then we are needlessly penalizing those other chipsets
with a reset-resume quirk, typically causing 0.4W extra power use because
this disables runtime-pm.

This commit moves the DMI table check to a btusb_check_needs_reset_resume()
helper (so that we can easily also call it for other chipsets) and calls
this new helper only for QCA_ROME chipsets for now.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
Cc: stable@vger.kernel.org
Cc: Jeremy Cline <jcline@redhat.com>
Suggested-by: Jeremy Cline <jcline@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/btusb.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2846,6 +2846,12 @@ static int btusb_config_oob_wake(struct
 }
 #endif
 
+static void btusb_check_needs_reset_resume(struct usb_interface *intf)
+{
+	if (dmi_check_system(btusb_needs_reset_resume_table))
+		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
+}
+
 static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
@@ -2968,9 +2974,6 @@ static int btusb_probe(struct usb_interf
 	hdev->send   = btusb_send_frame;
 	hdev->notify = btusb_notify;
 
-	if (dmi_check_system(btusb_needs_reset_resume_table))
-		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
-
 #ifdef CONFIG_PM
 	err = btusb_config_oob_wake(hdev);
 	if (err)
@@ -3109,6 +3112,7 @@ static int btusb_probe(struct usb_interf
 			hdev->setup = btusb_setup_csr;
 
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+		btusb_check_needs_reset_resume(intf);
 	}
 
 	if (id->driver_info & BTUSB_SNIFFER) {
