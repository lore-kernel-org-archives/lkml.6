Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2470ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B7B20864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B7B20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbeGPIDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:03:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46692 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeGPIDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:03:19 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 38B09C03;
        Mon, 16 Jul 2018 07:37:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olli Salonen <olli.salonen@iki.fi>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.17 25/67] USB: serial: cp210x: add another USB ID for Qivicon ZigBee stick
Date:   Mon, 16 Jul 2018 09:34:54 +0200
Message-Id: <20180716073447.149872766@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Olli Salonen <olli.salonen@iki.fi>

commit 367b160fe4717c14a2a978b6f9ffb75a7762d3ed upstream.

There are two versions of the Qivicon Zigbee stick in circulation. This
adds the second USB ID to the cp210x driver.

Signed-off-by: Olli Salonen <olli.salonen@iki.fi>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/cp210x.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -149,6 +149,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(0x10C4, 0x8977) },	/* CEL MeshWorks DevKit Device */
 	{ USB_DEVICE(0x10C4, 0x8998) }, /* KCF Technologies PRN */
 	{ USB_DEVICE(0x10C4, 0x89A4) }, /* CESINEL FTBC Flexible Thyristor Bridge Controller */
+	{ USB_DEVICE(0x10C4, 0x89FB) }, /* Qivicon ZigBee USB Radio Stick */
 	{ USB_DEVICE(0x10C4, 0x8A2A) }, /* HubZ dual ZigBee and Z-Wave dongle */
 	{ USB_DEVICE(0x10C4, 0x8A5E) }, /* CEL EM3588 ZigBee USB Stick Long Range */
 	{ USB_DEVICE(0x10C4, 0x8B34) }, /* Qivicon ZigBee USB Radio Stick */


