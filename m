Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2568158-1526386456-2-785860411526809768
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526386456; b=AtK8xnrmc/MYc+8m0dA7EJ5m1bRJN5q9yMzCvQ7h9Kco0JjLQb
    1LnB1OM2fsE+ST/eAGqfbxAQKoNQHyNCqQbdJ3Zk00SktZqs4zNoXs9e6wirZ7NJ
    5pSRZkIpZlBb9+etTc5tTSGM+PM0OF4IMURi9puiBmrdosNrPAqAbshRGynGqYxL
    QCETu4EX8QgWCJUoUlnWLjXuH6xfhFSVs9baBZBt6k/Jf4414OzwXhenpK7uIVuu
    yVsABp7bB2XSvoNsajBITfB14g0WPgnevbh8GPRkYahzgf0LkyQd+nl3O9cGCaKm
    t1PcvCJtH57zjXBPz40Hjo3LJdPswD5rxFQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526386456; bh=
    Q2rBAjxDK05PwgppPvt8PqTLNBiLyc/AY4ymHhm9Tks=; b=cEtaCIdH10gdnG8m
    gIkZyy3kvz6fIYhfI6RMkqoakJxjELw6Y/DnEMqcZly7CG6/GPSREJ1gnVFlQISx
    oeR0Xiqj8OkQYyeGot8M/tjle50n8a1+ER3b3VSnjWkBH3Q2wV0LWVGuQczRyNGr
    DdxMWSJXKbuUK6J2/BB8In80ZeREa2ehiY7xaFMkUq+EhSlpNTWKrxmbbtujsWRk
    TRMalAcbvmE6NSNyidZrpWhTF/J62aX1RCPx+ZPU+WQyAeE3kS7pngbi4/FNL7mn
    ngR67aqFWXbrkZWJGetZwisfEaRCz+fcz6ls56Fkj26wXUs9PUcySkNCcggqB05K
    qy+E9w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=samsung.com header.i=@samsung.com header.b=toodlmxK
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=samsung.com header.i=@samsung.com header.b=toodlmxK
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMBBQoOoYMQZMDe8+Kf6V5qSidBvQNj4BcZaYIECdZd/OafLx2Ra8Ap6CJ6na6JC8906tyb9t0I7MideSVgP0sPlhpeVjBTedpHLr/hpbV3KHg32+Oc5
    4qTVrj4HxxU1PO028pX0f9dTwniYAuOiqf/96EwBd+j8PpR5U4Yz5X/qAb4GxBnkRVZP16FF27HevuF/qSc1IL2DZZ0FT+Ih5LLSMEZqgCkWUB0mtXHG9iOt
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=hD80L64hAAAA:8
    a=VwQbUJbxAAAA:8 a=TFwayRnwDMb8vJKvQFcA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753200AbeEOMNA (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 08:13:00 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45768 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752794AbeEOMMz (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 15 May 2018 08:12:55 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180515121252euoutp013905b05509e21823ccd6b7b13e6bf635~u0FGmV-0J2727427274euoutp01F
X-AuditID: cbfec7f5-b45ff700000028a9-60-5afacec3897e
From: Andrzej Hajda <a.hajda@samsung.com>
To: linux-usb@vger.kernel.org (open list:DESIGNWARE USB3 DRD IP DRIVER)
Cc: Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 1/2] USB: dwc3: get extcon device by OF graph bindings
Date: Tue, 15 May 2018 14:12:38 +0200
Message-id: <20180515121239.18192-2-a.hajda@samsung.com>
X-Mailer: git-send-email 2.17.0
In-reply-to: <20180515121239.18192-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsWy7djP87qHz/2KMth0Scvi1rpzrBYbZ6xn
        tTjW9oTd4vqX56wW848AxZoXr2ezmHR/AovF+fMb2C06Jy5ht7i8aw6bxYzz+5gsFi1rZbZY
        e+Quu8XS6xeZLFr3HmF34PdYM28No8fsjpmsHptWdbJ57J+7ht2jb8sqRo/Pm+QC2KK4bFJS
        czLLUov07RK4Ml4+/8FUcJOvYlFPL1sD40SeLkZODgkBE4kdX6+wdjFycQgJrGCUaF16nAXC
        +cwo8fraHXaYqrVHusFsIYFljBKXjxRB2P8ZJc4d0Qax2QQ0Jf5uvskGYosIuEssW34NbCqz
        wEcWiZauj2AJYQFPiednHjKC2CwCqhIrDixgAbF5BSwkmldfZINYJi/xbPo8sGWcApYS6yc8
        AbtIQuAIm0TrjdOMEEUuEmu7r7NA2MISr45vgbpURuLy5G6oeLXEzRdNUM0djBL3f7dDbbCW
        OHz8IiuIzSzAJzFp23TmLkYOoDivREebEESJh8TXk8eYIWxHidb5+9ghwdLDKPHsXjvTBEap
        BYwMqxjFU0uLc9NTi43zUsv1ihNzi0vz0vWS83M3MQJj/vS/4193MO77k3SIUYCDUYmHd8eM
        n1FCrIllxZW5hxglOJiVRHh3GwGFeFMSK6tSi/Lji0pzUosPMUpzsCiJ88Zp1EUJCaQnlqRm
        p6YWpBbBZJk4OKUaGKf9lw5avLFeLr5+QuJUCz5+68viu6J3c9w4fSfaOLhRxrHwcvUTmcTW
        /Pg1ka9TphiyrIuz5H2XsOjtmdAbT6cXmPzuCX+y6lafcIy7rFM/Y+LVG6VCgcejAw9zHcxz
        UN/8heHYjerH+/XsVtzckD3784H77JdVbZuPH83c8OIpq8Z2t63y85VYijMSDbWYi4oTAZwD
        lKX1AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsVy+t/xa7qHz/2KMviQY3Fr3TlWi40z1rNa
        HGt7wm5x/ctzVov5R4BizYvXs1lMuj+BxeL8+Q3sFp0Tl7BbXN41h81ixvl9TBaLlrUyW6w9
        cpfdYun1i0wWrXuPsDvwe6yZt4bRY3bHTFaPTas62Tz2z13D7tG3ZRWjx+dNcgFsUVw2Kak5
        mWWpRfp2CVwZL5//YCq4yVexqKeXrYFxIk8XIyeHhICJxNoj3exdjFwcQgJLGCWeLPnAAuE0
        Mklcn7iBHaSKTUBT4u/mm2wgtoiAu8Sy5ddYQYqYBb6ySEz6/hKsSFjAU+L5mYeMIDaLgKrE
        igMLWEBsXgELiebVF9kg1slLPJs+D6yeU8BSYv2EJ2A1QkA1c599ZprAyLOAkWEVo0hqaXFu
        em6xkV5xYm5xaV66XnJ+7iZGYFhuO/Zzyw7GrnfBhxgFOBiVeHh3zPgZJcSaWFZcmXuIUYKD
        WUmEd7cRUIg3JbGyKrUoP76oNCe1+BCjNAeLkjjveYPKKCGB9MSS1OzU1ILUIpgsEwenVANj
        ebXf3LKbH5kLnDnaU3b8uDxX7kl+T/3OEoYXogrcwb1M9nrzWw0f1f16NbfvaS1f+tZy9tMi
        2tZCO2o2+hfw29vd3bD/rMyn3UE1l4WC369aeni7/IXUbSvMtN4vNRWWZrCIWDv18Dy+xu0a
        rZ/VbReyfpv6ZYbjBq2DXzyPWvSsXRZ+5LulEktxRqKhFnNRcSIAKNkTmUcCAAA=
X-CMS-MailID: 20180515121251eucas1p290dce20660eb0008f6eeff30fc42443e
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180515121251eucas1p290dce20660eb0008f6eeff30fc42443e
X-RootMTR: 20180515121251eucas1p290dce20660eb0008f6eeff30fc42443e
References: <20180515121239.18192-1-a.hajda@samsung.com>
        <CGME20180515121251eucas1p290dce20660eb0008f6eeff30fc42443e@eucas1p2.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

extcon device is used to detect host/device connection. Since extcon
OF property is deprecated, alternative method should be added.
This method uses OF graph bindings to locate extcon.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/usb/dwc3/drd.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 1d8c557e97e0..270682486f82 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/extcon.h>
+#include <linux/of_graph.h>
 #include <linux/platform_device.h>
 
 #include "debug.h"
@@ -439,17 +440,38 @@ static int dwc3_drd_notifier(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+	struct device_node *np_phy, *np_conn;
+	struct extcon_dev *edev;
+
+	if (of_property_read_bool(dev->of_node, "extcon"))
+		return extcon_get_edev_by_phandle(dwc->dev, 0);
+
+	np_phy = of_parse_phandle(dev->of_node, "phys", 0);
+	np_conn = of_graph_get_remote_node(np_phy, -1, -1);
+
+	if (np_conn)
+		edev = extcon_find_edev_by_node(np_conn);
+	else
+		edev = NULL;
+
+	of_node_put(np_conn);
+	of_node_put(np_phy);
+
+	return edev;
+}
+
 int dwc3_drd_init(struct dwc3 *dwc)
 {
 	int ret, irq;
 
-	if (dwc->dev->of_node &&
-	    of_property_read_bool(dwc->dev->of_node, "extcon")) {
-		dwc->edev = extcon_get_edev_by_phandle(dwc->dev, 0);
-
-		if (IS_ERR(dwc->edev))
-			return PTR_ERR(dwc->edev);
+	dwc->edev = dwc3_get_extcon(dwc);
+	if (IS_ERR(dwc->edev))
+		return PTR_ERR(dwc->edev);
 
+	if (dwc->edev) {
 		dwc->edev_nb.notifier_call = dwc3_drd_notifier;
 		ret = extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
 					       &dwc->edev_nb);
-- 
2.17.0

