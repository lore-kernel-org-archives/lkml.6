Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527159402-2-12104332324951067408
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527159402; b=aLQqzhVaHL7UjenSAcqUvJl9/ZygNsskbOW22DLceOCn9+muBw
    FcTWaLJi+NHj7+S/GgyHSrQtfMAcBLKKAa92T4lZ6cwCMPrxz7jf3VKjSlq5p6Y2
    csgtZB+XCDlQS3SWbULIQxMXflroIriKAg5JApFTU1DRO6+6e0PQAUiycTc70HX9
    5lVDRUys6DkdXiuvxHKS0vUrxe4AcMPu3kQlTnSA5NRRs/7c/MBc4US8alMAt+F4
    K/hAjaPW5ydzxKOL2BcsyKpDSm+AbZpOfZ4hP4xxW0GZo1M22aiXwCGbB3c7VdKD
    12x2RUUICkPE93X46mqVzuaV+2RhNPHmAgbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159402; bh=UEPE0JO+NWRbcGG6cyGsFv+I9OS/pH
    0Bg8WsTB84VAw=; b=NqjFelQiDRhoxNfaxTFux1gXosFn5+LnrcFQCgSWSD1L8I
    19J28G7vxQnr4AQgYhpbhBdrfSVaLqtt1a6xHzRlaFlmZOJjKU+YLmSeFhz5lR1i
    uAtcBXh9VXU1T8BeGrL3r7fm7UN8KtfAiLAlxUrVkHsof4QfvgSO2K9S5PQk99sh
    xflIb8AozO5rzynmg0ir8gZBJde+fZdfnKIaZgNnAyZc9F8iEm7kPtxdnzSE3Hru
    g2403SM5qgcLN/s27gMQIg/4Qc/Ib8PDzAzaoGNC4eEjhmKJkvjUN3bv5YYuHbV7
    72LpEdiwELj9H8VeWxk6Ay4dwrYAvVgffBEliYlA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Fj7jlKK1 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Fj7jlKK1 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfN1HGt07iYZ75hu7dISTjCXhz4BOE+jovGFPZnNMq92jkCMtCJHL6fyJQQZij9W/QOurR5jcm3T5iJ/JP86Vt/9KK0tP4m8EhKu9WhRczdv2dzkwBbnS
    NqBTlchbmaE5R/QVQi3ewvl5pX8ZNjskscT6AdLc7uQVqZjVV4D7jqWnbT3CgLlJZWPy7xv+HGfJV2zziG3My8nKJu5BjSkyq85seE+l4x/cAlw1iyUzn73R
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yQdBAQUQAAAA:8 a=pGLkceISAAAA:8 a=Dei6p5SHAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=cC1Zfw63NZkZNGFym8gA:9 a=QEXdDO2ut3YA:10
    a=SzazLyfi1tnkUD6oumHU:22 a=M-Yerj1wOn-OpK7r_3ei:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030317AbeEXJ43 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:56:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030314AbeEXJ41 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:56:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hon Weng Chong <honwchong@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 083/165] Bluetooth: btusb: Add device ID for RTL8822BE
Date: Thu, 24 May 2018 11:38:09 +0200
Message-Id: <20180524093625.374330903@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Larry Finger <Larry.Finger@lwfinger.net>

[ Upstream commit fed03fe7e55b7dc16077f672bd9d7bbe92b3a691 ]

The Asus Z370-I contains a Realtek RTL8822BE device with an associated
BT chip using a USB ID of 0b05:185c. This device is added to the driver.

Signed-off-by: Hon Weng Chong <honwchong@gmail.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/btusb.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -380,6 +380,9 @@ static const struct usb_device_id blackl
 	{ USB_DEVICE(0x13d3, 0x3461), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3462), .driver_info = BTUSB_REALTEK },
 
+	/* Additional Realtek 8822BE Bluetooth devices */
+	{ USB_DEVICE(0x0b05, 0x185c), .driver_info = BTUSB_REALTEK },
+
 	/* Silicon Wave based devices */
 	{ USB_DEVICE(0x0c10, 0x0000), .driver_info = BTUSB_SWAVE },
 
