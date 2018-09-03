Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89897C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227772077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227772077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbeICVeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:34:07 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:37897 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbeICVeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:34:06 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue105 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0MAeJn-1g3hly2Drn-00BsBV; Mon, 03 Sep 2018 19:12:57 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Woojung Huh <woojung.huh@microchip.com>
Cc:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 4/4 next] net: lan78xx: Make declaration style consistent
Date:   Mon,  3 Sep 2018 19:12:39 +0200
Message-Id: <1535994759-8938-5-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535994759-8938-1-git-send-email-stefan.wahren@i2se.com>
References: <1535994759-8938-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:pSquybRud8rBJ81+pXBAwOSU+4FRWjdY30Kx4NhF4jHUTSEAjef
 JlReTztAtOMTG3JLFzPc/o9OTA3jQoWk7EaFbDZafPB56HSNiYXV9wBfG3+hHyPps2Lq2Ix
 6z3Rb6A1wdbEbVKZkvV1Dk6KTGZ65/0dRR4vYFHwrg0aeBAqoWFl0KqlCoF1AvKxOt/F0sw
 r35eEsecIS34muzf0nETQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PpMvpzFP5v8=:WGXL5zKZdNriZGUFU49GYn
 M4WY7BolOO53SV4OCez+jmY2XlIcj4wM6ee7UV/HKZ7q6QTIwJ79DBuIx4l5Gilu5xhiLWgm/
 niwcZfeaDunobP/EKI91AAKZ7rPAU3SPVZI6mTgMlBtFT1E8RmCWh4gpNFr2oqZ9R7tEdx6fU
 XiagKuYoFJ5j0P9zrqcTF0aUgpL7qvl1BHw0r0Xh19Rqxhoujlmpk5Dj5t8zAUqYL4jaLkXv+
 f8P5EMZkun+YJWwXy9mVJ/iAsmhIMUTf5O89Go/HeudL3jYbv1xeNmkLKinbQjSNr7F137uC7
 dK6oDkcmU5N9K98TCsWZ2bOkZs8ggHuYce38zzRBRN1bfFzPmbsPn+nhHNaMVo+hgM34q4WUR
 UZsIOrmR2qvPuTq6Ytnwbb0gIBATTBu9VneMPX4NWeFFXOtbnW/yBhTPpESlBNkDBvMBVj8Xk
 lKOy64YcmjTg5W8VFWPJbcT3LsPmWC30Ivucuuix+No3aE+rAelD7Q1Ip5TiP8rl+hZKT1d5Y
 bVl6kvf0v78uEMCrCjipnxfxbOZz72IyO/qGda51jZGzl5CCmyzV5oC8aTVcGvuVTS6/4GiP5
 szxANS2642nVnBHCI+zGw6bjfAprJhh9DYr+lkh/gcT0KaStouDU7osJ2trPqwM6JkwubA3xs
 SzY7YR4mMUEwS6ulMX6B3zF/3tfhBi6smczg/UOWP878CZdybNz7e4zLph/7HR3TaCM8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some declaration more consistent.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/net/usb/lan78xx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index a6e88a4..143091a 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1013,7 +1013,7 @@ static int lan78xx_dataport_write(struct lan78xx_net *dev, u32 ram_select,
 static void lan78xx_set_addr_filter(struct lan78xx_priv *pdata,
 				    int index, u8 addr[ETH_ALEN])
 {
-	u32	temp;
+	u32 temp;
 
 	if ((pdata) && (index > 0) && (index < NUM_OF_MAF)) {
 		temp = addr[3];
@@ -2688,7 +2688,7 @@ static void lan78xx_terminate_urbs(struct lan78xx_net *dev)
 
 static int lan78xx_stop(struct net_device *net)
 {
-	struct lan78xx_net		*dev = netdev_priv(net);
+	struct lan78xx_net *dev = netdev_priv(net);
 
 	if (timer_pending(&dev->stat_monitor))
 		del_timer_sync(&dev->stat_monitor);
@@ -3071,7 +3071,7 @@ static void lan78xx_rx_vlan_offload(struct lan78xx_net *dev,
 
 static void lan78xx_skb_return(struct lan78xx_net *dev, struct sk_buff *skb)
 {
-	int		status;
+	int status;
 
 	if (test_bit(EVENT_RX_PAUSED, &dev->flags)) {
 		skb_queue_tail(&dev->rxq_pause, skb);
@@ -3631,10 +3631,10 @@ static void intr_complete(struct urb *urb)
 
 static void lan78xx_disconnect(struct usb_interface *intf)
 {
-	struct lan78xx_net		*dev;
-	struct usb_device		*udev;
-	struct net_device		*net;
-	struct phy_device		*phydev;
+	struct lan78xx_net *dev;
+	struct usb_device *udev;
+	struct net_device *net;
+	struct phy_device *phydev;
 
 	dev = usb_get_intfdata(intf);
 	usb_set_intfdata(intf, NULL);
-- 
2.7.4

