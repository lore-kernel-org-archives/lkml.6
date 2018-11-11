Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BFEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EE12080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90EE12080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbeKLGEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:04:40 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52956 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729602AbeKLGEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:04:40 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt0-0000l9-Ng; Sun, 11 Nov 2018 19:59:10 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsS-0001Yp-KD; Sun, 11 Nov 2018 19:58:36 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Johan Hovold" <johan@kernel.org>,
        "Carlos Barcala Lara" <cabl@cesinel.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.603416003@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 148/366] USB: serial: cp210x: add CESINEL device ids
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 24160628a34af962ac99f2f58e547ac3c4cbd26f upstream.

Add device ids for CESINEL products.

Reported-by: Carlos Barcala Lara <cabl@cesinel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/serial/cp210x.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -91,6 +91,9 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(0x10C4, 0x8156) }, /* B&G H3000 link cable */
 	{ USB_DEVICE(0x10C4, 0x815E) }, /* Helicomm IP-Link 1220-DVM */
 	{ USB_DEVICE(0x10C4, 0x815F) }, /* Timewave HamLinkUSB */
+	{ USB_DEVICE(0x10C4, 0x817C) }, /* CESINEL MEDCAL N Power Quality Monitor */
+	{ USB_DEVICE(0x10C4, 0x817D) }, /* CESINEL MEDCAL NT Power Quality Monitor */
+	{ USB_DEVICE(0x10C4, 0x817E) }, /* CESINEL MEDCAL S Power Quality Monitor */
 	{ USB_DEVICE(0x10C4, 0x818B) }, /* AVIT Research USB to TTL */
 	{ USB_DEVICE(0x10C4, 0x819F) }, /* MJS USB Toslink Switcher */
 	{ USB_DEVICE(0x10C4, 0x81A6) }, /* ThinkOptics WavIt */
@@ -108,6 +111,9 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(0x10C4, 0x826B) }, /* Cygnal Integrated Products, Inc., Fasttrax GPS demonstration module */
 	{ USB_DEVICE(0x10C4, 0x8281) }, /* Nanotec Plug & Drive */
 	{ USB_DEVICE(0x10C4, 0x8293) }, /* Telegesis ETRX2USB */
+	{ USB_DEVICE(0x10C4, 0x82EF) }, /* CESINEL FALCO 6105 AC Power Supply */
+	{ USB_DEVICE(0x10C4, 0x82F1) }, /* CESINEL MEDCAL EFD Earth Fault Detector */
+	{ USB_DEVICE(0x10C4, 0x82F2) }, /* CESINEL MEDCAL ST Network Analyzer */
 	{ USB_DEVICE(0x10C4, 0x82F4) }, /* Starizona MicroTouch */
 	{ USB_DEVICE(0x10C4, 0x82F9) }, /* Procyon AVS */
 	{ USB_DEVICE(0x10C4, 0x8341) }, /* Siemens MC35PU GPRS Modem */
@@ -120,7 +126,9 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(0x10C4, 0x8470) }, /* Juniper Networks BX Series System Console */
 	{ USB_DEVICE(0x10C4, 0x8477) }, /* Balluff RFID */
 	{ USB_DEVICE(0x10C4, 0x84B6) }, /* Starizona Hyperion */
+	{ USB_DEVICE(0x10C4, 0x851E) }, /* CESINEL MEDCAL PT Network Analyzer */
 	{ USB_DEVICE(0x10C4, 0x85A7) }, /* LifeScan OneTouch Verio IQ */
+	{ USB_DEVICE(0x10C4, 0x85B8) }, /* CESINEL ReCon T Energy Logger */
 	{ USB_DEVICE(0x10C4, 0x85EA) }, /* AC-Services IBUS-IF */
 	{ USB_DEVICE(0x10C4, 0x85EB) }, /* AC-Services CIS-IBUS */
 	{ USB_DEVICE(0x10C4, 0x85F8) }, /* Virtenio Preon32 */
@@ -130,10 +138,13 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(0x10C4, 0x8857) },	/* CEL EM357 ZigBee USB Stick */
 	{ USB_DEVICE(0x10C4, 0x88A4) }, /* MMB Networks ZigBee USB Device */
 	{ USB_DEVICE(0x10C4, 0x88A5) }, /* Planet Innovation Ingeni ZigBee USB Device */
+	{ USB_DEVICE(0x10C4, 0x88FB) }, /* CESINEL MEDCAL STII Network Analyzer */
+	{ USB_DEVICE(0x10C4, 0x8938) }, /* CESINEL MEDCAL S II Network Analyzer */
 	{ USB_DEVICE(0x10C4, 0x8946) }, /* Ketra N1 Wireless Interface */
 	{ USB_DEVICE(0x10C4, 0x8962) }, /* Brim Brothers charging dock */
 	{ USB_DEVICE(0x10C4, 0x8977) },	/* CEL MeshWorks DevKit Device */
 	{ USB_DEVICE(0x10C4, 0x8998) }, /* KCF Technologies PRN */
+	{ USB_DEVICE(0x10C4, 0x89A4) }, /* CESINEL FTBC Flexible Thyristor Bridge Controller */
 	{ USB_DEVICE(0x10C4, 0x8A2A) }, /* HubZ dual ZigBee and Z-Wave dongle */
 	{ USB_DEVICE(0x10C4, 0x8A5E) }, /* CEL EM3588 ZigBee USB Stick Long Range */
 	{ USB_DEVICE(0x10C4, 0x8B34) }, /* Qivicon ZigBee USB Radio Stick */

