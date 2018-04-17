Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-861505-1523942085-2-6851374543959069832
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523942084; b=kCnDq013cEaTTcSCOZb4G0GUlfvh32S2P19SQVVMQnkG4wAEjk
    0chwk9kh+eg6FqQEmXX8lbvH+mOSpQV4dFm5InjamjGAFIl0kDmOhnshb2twh0jP
    rgwF7AJ45PfoEwhNFOWY7YTo2jCg/857084U2Mukf1kCmEic3q7/1ltMAbCd+7tR
    DACzXNIkOKY6L3ulxLG10T9q+YgEmyXtAtuIpVt4gBFk/BYhqhvgJNs00wO+0ecF
    p05WTfvKwGbt7UaslNb41H3w1gKrhrov20t9WOXQckEcIuELEI6h6QJtndMSEoTL
    ylZmCQDlhQwiyHRBK6Eeg4RQ+dBBkXE+TdHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:from:subject:message-id:date
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1523942084; bh=oqel6ZUBTNG3+Zz7AB5/kjVc6kqJFr
    I0fWN6p33uATw=; b=jH9YHwCZ1P2ytVoVsIaXkuGZAPXZf9ftsH9z1fZdSvbYDE
    BQ+O/PTu/aYnbKE2xlZ9TMbOp7OniRCCUfZ+1iT6Evmfm2axYoX/0zela5iV+Tcz
    VlxRzh9j4L1VbkiyqSBvG4qf49v3gRNfTOok1WKOipgLf1I9SHJozGw+6crYG39D
    TwqBgbXwDjh8hVQPdaxUrFrTTqZDZ924GimqdxKpNO7fNDZEjmxMIEiKWMMi8j15
    kFQeQL2y7Aam41uYV6RytGAV4UdOjq9lmASLDARiQafIae0HgItvLdjBYRsKgjWw
    YC5B2/ojvy1q3NtjnjCXEGrA4eCLtwmf/Q4hJU8Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=E+uKnDgB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=E+uKnDgB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDmcf4wyoYEm5uWOFpHnI1EIBexN00p2apN3Pih4OlPCSYD0jaPZce0FoRgyR/qFx2mVPbs0LTJ2tjD3T+r7Z+FZfBkNBI6naTrEyE4ri96ynodkjAz2
    t5LII8SES6fHcaP1oj1sMX1e6y7nFdcMHh3pVHYQEAv6OG2+sWxxVfxvgDT/T8MUmz3LoOB5u2i0KsxD7LtmuxRffivKVd8ZQD05Nt+mRoo2oCPtVxBSjgIy
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=JfrnYn6hAAAA:8 a=QyXUC8HyAAAA:8 a=hD80L64hAAAA:8 a=20KFwNOVAAAA:8
    a=ag1SF4gXAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=sDdyCebgBAZCNYHvrNAA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750988AbeDQFOa (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 01:14:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60920 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeDQFO3 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 17 Apr 2018 01:14:29 -0400
To: USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] usb: always build usb/common/ targets; fixes extcon-axp288
 build error
Message-ID: <d2641585-65d8-76d4-0668-a278955967d8@infradead.org>
Date: Mon, 16 Apr 2018 22:14:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

The extcon-axp288 driver selects USB_ROLE_SWITCH, but the USB
Makefile does not currently build drivers/usb/common/ (where
USB_ROLE_SWITCH code is) unless USB_COMMON is set, so modify
the USB Makefile to always descend into drivers/usb/common/
to build its configured targets.

Fixes these build errors:

ERROR: "usb_role_switch_get" [drivers/extcon/extcon-axp288.ko] undefined!
ERROR: "usb_role_switch_set_role" [drivers/extcon/extcon-axp288.ko] undefined!
ERROR: "usb_role_switch_get_role" [drivers/extcon/extcon-axp288.ko] undefined!
ERROR: "usb_role_switch_put" [drivers/extcon/extcon-axp288.ko] undefined!

An alternative patch would be to select USB_COMMON in the EXTCON_AXP288
driver Kconfig entry, but this would build more code in
drivers/usb/common/ than is necessary.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org
---
 drivers/usb/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-417-rc1.orig/drivers/usb/Makefile
+++ lnx-417-rc1/drivers/usb/Makefile
@@ -60,7 +60,7 @@ obj-$(CONFIG_USB_CHIPIDEA)	+= chipidea/
 obj-$(CONFIG_USB_RENESAS_USBHS)	+= renesas_usbhs/
 obj-$(CONFIG_USB_GADGET)	+= gadget/
 
-obj-$(CONFIG_USB_COMMON)	+= common/
+obj-y				+= common/
 
 obj-$(CONFIG_USBIP_CORE)	+= usbip/
 


