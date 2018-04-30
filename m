Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2075229-1525126700-2-6188010859052818729
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525126699; b=Le4oF9Kwv0aOw6pmD812c8YGUpBFK5/c/1TtJ5Ynjfv9IvnmA1
    9O8jORMrOFjFNEhfH3muYwvg0VbNIUvenjy/Mf9NwpFgKHWphbMXoiZQ4a+0dIPy
    1vJpw2Oq3901uOd3bjdV7dUkLTMoIW3woztb1i+JnLJIeOG4jaF6J1HdajGy4ZVw
    aWh3XItdbCNlV1wWLEYh4rANP3NFp1dO923jYrXLv5C22z+C/HgUF3xe21gl4chQ
    ovNEiXcnjzH//5SdFnc7juBQar4CJvZYv4sNs2r9uwzkm5tilp9TFj8Iqxsa0CW0
    XVPiD6sjX23Qxr1a9Gvga0vvL0ZU91/z8kxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525126699; bh=YwsOYq3FRegeB/qTRvhbTYaRlnFrCR
    bpVC5BPV2MVCA=; b=crFOR0nGvGCMA29x6JblX5wKesZV62znnhkd5G3ISu5Pbr
    /IouLy7KopF+znlj6I4YZwJ7TJvcrUsvzwGdUY8TC9reu2CqTjf3TVERW56MHpOf
    YdEuRZUhkQMeSrhQwmmdtzzaS6oK98KPUkViKmkikfWZd+Ml+4CaGq/VRHyirUfj
    6QaZ4seioYVhxUK6iat24Z1vlXAqvmLyuQQGyOZyyYf7xtc/HKefi2tPU7NtdqQw
    zGAj47SsM96miadIf/RxoupXG716b4emdZVNnp1/ftOneECIVLKxZw+t7Mgbx8Qx
    uB66WNusiXb719RAgDO3XNYS8KEQDsu98PudjQcw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfACyu8VFNimSrjLUvVkp3RlFZBPTWFdNt3voxWaqQwkxugaiLnNUawKUOFS0QMFVsBjXdJj1OoSAfRKx+hXa936Igup1ZvEkUXc4YsrIvHYk/as6P6bm
    CqsOmIIAr9kBVbRjVXOEKAmfck204FqKahqUgzICuJ7/T6EBJtYd1ObGiyTy78zIgYnpsPOd1Bwp2pstdyeBHMfQ993mGtr3wjsSLqxPorRpUGYNaT1RmNh7
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=_Bs-QTHlmUP4gWKnpksA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753530AbeD3WRu (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 18:17:50 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:42989 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751384AbeD3WRt (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 30 Apr 2018 18:17:49 -0400
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [REBASED PATCH 1/2] usbip: usbip_host: delete device from busid_table after rebind
Date: Mon, 30 Apr 2018 16:17:19 -0600
Message-Id: <9cfffc546fc9774a9e38e81b0f396866a9d8d11f.1525115738.git.shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Device is left in the busid_table after unbind and rebind. Rebind
initiates usb bus scan and the original driver claims the device.
After rescan the device should be deleted from the busid_table as
it no longer belongs to usbip_host.

Fix it to delete the device after device_attach() succeeds.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 drivers/usb/usbip/stub_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
index d41d0cdeec0f..fb46bd62d538 100644
--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -186,6 +186,9 @@ static ssize_t rebind_store(struct device_driver *dev, const char *buf,
 	if (!bid)
 		return -ENODEV;
 
+	/* mark the device for deletion so probe ignores it during rescan */
+	bid->status = STUB_BUSID_OTHER;
+
 	/* device_attach() callers should hold parent lock for USB */
 	if (bid->udev->dev.parent)
 		device_lock(bid->udev->dev.parent);
@@ -197,6 +200,9 @@ static ssize_t rebind_store(struct device_driver *dev, const char *buf,
 		return ret;
 	}
 
+	/* delete device from busid_table */
+	del_match_busid((char *) buf);
+
 	return count;
 }
 
-- 
2.14.1

