Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162277-2-12527551467808076803
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162276; b=gducAnVhmg/xrm6mT4tONOOADivJV0ZOO+3Da9CukfWDjjiVeK
    2gFFm1GscUGOB82joGC4W7ZRtwrrOoBsqGxCMkGLcsr2zvxWbwaVPj3yEwAgIoLS
    OpKbg6AvkeZw1eTN5O/z8J0HHJMjQeRBZKWbZ0/oY5sa4g0SULqTjcE+rUFgOvvn
    OVxH5TY04Nze0FNOjG6hkXlaAtD84WYlK63VCsH8y0g7McuYQD4ymh+AYxI/YluK
    +kGdjjGC1IP/NS5XRZKmCUiHZMPo1DpGImdYPw2wNHwYVUFxDCDBGcYcauz0rUyx
    Ph7tFiiDZlaDbtzxY3e8xSLYBgPzWL7ZFyig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162276; bh=TN3W1h9/81KmwdT7ZcfKuYCi7XigWj
    vLAxaWczxRhhs=; b=dnIJErfpvfekV3zWCRhUQ0ptPCKt+Z8IP0ukVIjMt7N/6r
    P8s+ipHuTgf4en8keVnXd1rPJFfqgxLtJzHfvvjDIKiUxfq8eYpB6DAtmPIRpR/u
    O6l2nlLLnbXbTe/YZaOtz3O7iP/Qjoqs9UfHi+JmG7DrGVTTQVi9lINURMdPy4c4
    9ptOjw2pMkw7w300EsPumV1CQBZqUGKLlqnKIUr+wk28YUgyTchZ4oD3HBr9BUsF
    SPHS1hnVLGZOV/M5NpLKp/a+ukKNAi3ngHkHnqcQxZQbsR0/vF14va/gaMSMOiAd
    eA4XjUDvP1JTCr6YCXAPtQJ6fDYQOSEEMgfXZzww==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=NCQwH6xa x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=NCQwH6xa x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfKWkbiqJZl80IEZmyi9uKL5cSPJTkQOTOB4Fg4Y+k9S5CwYggz7tD1Dde7oR90rIZfbjPUpUcH9FqbSHBnisbQmW30Py+m4gf3yvMjK6dnXxnvO6yU2z
    9/WSSqrBqPeLVpVYMd6ns8g/kE88U22X1uA1bndbfFnE/zvDoRGDrT6ci6ZlOHHE3Ooe7glfp7Or09PsVUFgJGxj3XbtHfaqADXQVrxsH3bCS0Uf9VEYZNkQ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=s-7XUGYW7vl69mGbyGQA:9 a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966880AbeEXJsN (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:48:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967186AbeEXJsL (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:48:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Giuseppe Lippolis <giu.lippolis@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 33/96] net-usb: add qmi_wwan if on lte modem wistron neweb d18q1
Date: Thu, 24 May 2018 11:38:16 +0200
Message-Id: <20180524093607.452289728@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Giuseppe Lippolis <giu.lippolis@gmail.com>

[ Upstream commit d4c4bc11353f3bea6754f7d21e3612c9f32d1d64 ]

This modem is embedded on dlink dwr-921 router.
    The oem configuration states:

    T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480 MxCh= 0
    D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
    P:  Vendor=1435 ProdID=0918 Rev= 2.32
    S:  Manufacturer=Android
    S:  Product=Android
    S:  SerialNumber=0123456789ABCDEF
    C:* #Ifs= 7 Cfg#= 1 Atr=80 MxPwr=500mA
    I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
    E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
    E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
    E:  Ad=84(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
    E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
    E:  Ad=86(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
    E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
    E:  Ad=88(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
    E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
    E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
    E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:* If#= 6 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=(none)
    E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=125us

Tested on openwrt distribution

Signed-off-by: Giuseppe Lippolis <giu.lippolis@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -810,6 +810,9 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x0846, 0x68a2, 8)},
 	{QMI_FIXED_INTF(0x12d1, 0x140c, 1)},	/* Huawei E173 */
 	{QMI_FIXED_INTF(0x12d1, 0x14ac, 1)},	/* Huawei E1820 */
+	{QMI_FIXED_INTF(0x1435, 0xd181, 3)},	/* Wistron NeWeb D18Q1 */
+	{QMI_FIXED_INTF(0x1435, 0xd181, 4)},	/* Wistron NeWeb D18Q1 */
+	{QMI_FIXED_INTF(0x1435, 0xd181, 5)},	/* Wistron NeWeb D18Q1 */
 	{QMI_FIXED_INTF(0x16d8, 0x6003, 0)},	/* CMOTech 6003 */
 	{QMI_FIXED_INTF(0x16d8, 0x6007, 0)},	/* CMOTech CHE-628S */
 	{QMI_FIXED_INTF(0x16d8, 0x6008, 0)},	/* CMOTech CMU-301 */
