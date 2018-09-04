Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0249C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749E42082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749E42082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbeIDVzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:55:51 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:59469 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbeIDVzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:55:50 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0Lb1ib-1fUpDu40mf-00kdbC; Tue, 04 Sep 2018 19:29:40 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Woojung Huh <woojung.huh@microchip.com>
Cc:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 4/4 next] net: lan78xx: Make declaration style consistent
Date:   Tue,  4 Sep 2018 19:29:12 +0200
Message-Id: <1536082152-3669-5-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536082152-3669-1-git-send-email-stefan.wahren@i2se.com>
References: <1536082152-3669-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:A77hTVESIIEQYxz8Sf1Jj08AlI77pYKhh3dmIqk1O8L7BLNAHV5
 aOWXktCunBVGoFOrgBju38c3GO+Ik6JfIHykC6nQ1Xjs1qr9fm18ASvowLTudm7H0xeToQQ
 Qu8sPwKq1BdakBibr6QjC3rEMNcYvgSPMp0y3wXSS7OsIdaA8hOnoRSlKJr4xx8hB9OkXi6
 d5zAxKBFDY0ilx+4Uh5vg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Jm+lOBuXalw=:AeQKnrE5ZxBZZqhZsrjjFT
 6Xo+hXUSJeWnuV7b3vzoln8V6cij32/nP5r1FmEviIoJKURBcgHd8aRNGN3BXx0aufAf3mgWU
 //aczNFu6ogmD88Dsfh29bwKmagZhSsRVME6T9OZNZUATEsie26CwXwxH7COvUBvyUUiUfXJB
 yY3WHnxrsulNMaJccA2sbzmHlGNsAZGMKprDZU9+CALrJD85wDtiz9yNhgKVtYHMnAUTivT/7
 M1XGyPL4brkGwr84zgStz+YSLpC4uMIKyf52eAC+usUcuYVlW+7BQaHuGZc6y4x+Z4A83CoMu
 kjscUgrThqcy2NBq5Sgb/4m4BZ4M4O1tZTqXH1R4m0jA25zAnLUUWG9pqwqoNtPuvQOM5TyfX
 5fjXT55hZc2Y6EE8ovpzmvFlXmKREwB7qag0HlBAx5Sxpd6NFfkUE+IEvD8tXwwFp9a1OwIK2
 sbHxJB4zqXGOioqIg7ll5IKMIQvrbyxuZAbaLowi5sRXUd9oMIVJsKLtFuOnfkuSHLpjhaT2c
 YzJ2u6SOchDBaWCzDMkbJVzCstQxeqJP/KIuMevopHtUVFPa53HiisQOnt6aImXi0lOn77e2o
 HE3dZNgyZKd11m9O4RNvdJca5SlQ9bXVdKdaycPXLY8nGQf1BB+CsFy3rjLHfft8egDvKBDYy
 dykMXEkh0rBp3mZRl/hAIA450G0GOjy35GHDbru4YO0AYOfmHoAiaqU8/Q07sKUqkF60=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some declaration more consistent.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Raghuram Chary Jallipalli <raghuramchary.jallipalli@microchip.com>
---
 drivers/net/usb/lan78xx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index e1c055d..331bc99 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1015,7 +1015,7 @@ static int lan78xx_dataport_write(struct lan78xx_net *dev, u32 ram_select,
 static void lan78xx_set_addr_filter(struct lan78xx_priv *pdata,
 				    int index, u8 addr[ETH_ALEN])
 {
-	u32	temp;
+	u32 temp;
 
 	if ((pdata) && (index > 0) && (index < NUM_OF_MAF)) {
 		temp = addr[3];
@@ -2690,7 +2690,7 @@ static void lan78xx_terminate_urbs(struct lan78xx_net *dev)
 
 static int lan78xx_stop(struct net_device *net)
 {
-	struct lan78xx_net		*dev = netdev_priv(net);
+	struct lan78xx_net *dev = netdev_priv(net);
 
 	if (timer_pending(&dev->stat_monitor))
 		del_timer_sync(&dev->stat_monitor);
@@ -3073,7 +3073,7 @@ static void lan78xx_rx_vlan_offload(struct lan78xx_net *dev,
 
 static void lan78xx_skb_return(struct lan78xx_net *dev, struct sk_buff *skb)
 {
-	int		status;
+	int status;
 
 	if (test_bit(EVENT_RX_PAUSED, &dev->flags)) {
 		skb_queue_tail(&dev->rxq_pause, skb);
@@ -3633,10 +3633,10 @@ static void intr_complete(struct urb *urb)
 
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

