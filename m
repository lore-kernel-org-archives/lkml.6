Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2046117-1524724252-2-2731660000871890604
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='UTF-8', cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524724251; b=GczNHGETgtt5TbcjBbVuOuykeDaNSyYfaMDWzY6I8Hc1OMv4qX
    Q7JG9A9BkZlpvPPCuTdIjprFLh/924ECalxCzZ0mziEZS2+vWXEbNjOQt/SydYoD
    Zb2/mCXMEIjdNLmYaGLKhXvD/6y3CDADmL+1oYuTkSlbFhYR47dnqgP9BuYrA/U1
    tI8i+2maHejOCxYOrN9OTMsFTA7iK9eeVJu0RiIyjt/B1JeXAh9JcHi8klNo4MgN
    bL5NpcLaOBgsl89G/nDs8VD7RX0k+pAySRpF6/aigP4k0bJf2uZRQNxbXKuZUw6P
    qvWN4y3iNZoTFcEG8QxwzbLkD0ooyOd+8aJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:to:sender
    :list-id; s=fm2; t=1524724251; bh=Ssfz9hg2mnukquZVPPgk8NVlhHdJ8O
    L8YxB5O9gv7Do=; b=ZBrHPzsrqBC+bX2KVKikB+9qrVDlGUQncOIWVLxP/tUZPV
    DxG70FSP1iSR/LuPC8hgwB7aQQAI55RkawjtREMbKMpAQYKA0WDQQdviFNzl+o0D
    voYc2fNWHy8sDdwW0w5+hjwk7ZqoKEX7fLR19xHWFwTFq0B3MtBBZiJunXW0uG14
    FpnuEZRAbF9trLLkrsEY+rYDGqdd8EwJHqffDI+mu9yWSep2CknTykYy3kho4Iuq
    WS450XeKNSr1WEDstyo28H/MK7v0XVj2gC1zoPEijTaYXBXK4j+O5ydtCKpvu0nN
    DTN8kgPrWCLccldIKJKJ/cDOCl2d8FS1RQ+/fbYA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=moxa.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kPkjji7s;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=moxa.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=40 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=moxa.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kPkjji7s;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=moxa.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=40 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG9FDTN0gJZuUX9I3NIBaoWGEqTu4ogamMPJMYpgSQQLTl5cXQpCEOb+MHpClYyXVF4Ee2cfOACfwzvIV1n2iaYftXXPfIuYmIR0o+PgYe3p2dL78/dQ
    PPa2kn4RAfepnHIypcjMapX7Bv0F/s0OZ4NrCfn59Ag+6VTVUTY7WyiTpmCePTCXIajwSCoD+M7kR/r0aer8TOcc1pC9IpkUCtMadtQIOnkXwbSMXSSKF3k+
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=dZ7Af3Q_AAAA:8 a=VwQbUJbxAAAA:8 a=zhus26-9LzgaYVPFmNMA:9 a=QEXdDO2ut3YA:10
    a=xnyMoErWsJe9py2mg6Iw:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbeDZGas (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 02:30:48 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35820 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbeDZGar (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 02:30:47 -0400
X-Google-Smtp-Source: AIpwx49STMe6Tlhe2e60ugMRtGZmELtUMviqQUC/Zry/Aw9+e1whMRy6kEyhr01pM2sVew7yMRyh8g==
From: =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?=
        <sz.lin@moxa.com>
Cc: =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?=
        <sz.lin@moxa.com>, stable <stable@vger.kernel.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] NET: usb: qmi_wwan: add support for ublox R410M PID 0x90b2
Date: Thu, 26 Apr 2018 14:30:13 +0800
Message-Id: <20180426063013.453-1-sz.lin@moxa.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds support for PID 0x90b2 of ublox R410M.

qmicli -d /dev/cdc-wdm0 --dms-get-manufacturer
[/dev/cdc-wdm0] Device manufacturer retrieved:
        Manufacturer: 'u-blox'

qmicli -d /dev/cdc-wdm0 --dms-get-model
[/dev/cdc-wdm0] Device model retrieved:
        Model: 'SARA-R410M-02B'

Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index c853e7410f5a..51c68fc416fa 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1098,6 +1098,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x05c6, 0x9080, 8)},
 	{QMI_FIXED_INTF(0x05c6, 0x9083, 3)},
 	{QMI_FIXED_INTF(0x05c6, 0x9084, 4)},
+	{QMI_FIXED_INTF(0x05c6, 0x90b2, 3)},    /* ublox R410M */
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 0)},
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 5)},
 	{QMI_QUIRK_SET_DTR(0x05c6, 0x9625, 4)},	/* YUGA CLM920-NC5 */
-- 
2.17.0
