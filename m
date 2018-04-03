Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2619226-1522794001-2-16535550918623085271
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522794000; b=eF4sKiOPQOO8Fbv6gIHUdfV+gsfPqrkQa0GOcP3tD91UnjCAXp
    hayvWmxB8kLw92tB7jP7LlXhvFtt3gnsV1T5677A0nBL9CAwtMvsV0TqvIqpz3VD
    xBYVPVsQ41XW07Q4qGLnV204pv6oOV0TlL0VHZDzVmpJw5jcT5mo94tOZ5RZSRVb
    aZxmG7nNqnGgjCa8IzH1CswyB1nyuo8oz3Xn+3UULu21LR3DY6L0FTuMO2lrnNqQ
    8ILsCPLE0b2ud1maSS/FABl+CESIge+uEDwX+bW1GKNBYB5Ww+YPBy9a9oSXXU6Z
    2OPpz6J0PPrL0ySqDQFjhlFftBuy7cwwoO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1522794000; bh=KIdEnUMMw5iOjhTSHEzU8nNyZ7VrM8
    jqfPtqYIAd9e8=; b=JcDaBmPibD39tARSm+ome8qseSbyj4XuXnb3eh0H+fum1Z
    VSuxpFAhHKSE2JPkWastLgdr5cmlg8V9AhdeYTcofTjE76dlcZTb9nr0rbrrt3H6
    0dtetmOPIiaddQfXiN0UjJX3mCOYknt3SKRypY42kGrCdTWCn60jHj061Wz6J9R7
    fzV80z82O9ZfmVMT0/0UXj40HyLxltCiQyWz2VWavsEEeHUqI3B0FVUbzluC/ZEr
    uoVKdMdxK5oYAWl0WpFfEjkQSma71b4gl8yKKalLq5rfucwRSeEgeD23V7yhbisX
    G6K1lh9zWF8wVR0Eh3pBgNkRvYTZV6N+jwBfl5Gg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL91rAzUplD9FygNGVrhXRC/Z1cu7azwmqstTM5q+r77nJCpJbr1Xf2Egkgi5jFH9vLx6AMRBGPGaPlg0UFPv6F0T1KbrfCZtMV+QZDJwwK4XYMrppTZ
    ETgaII8CLONRL0zVnYsiKevfk2kcpdtTvOdNNuOQ9d8WDSivd+8DAq6yAt1ZmBn7QENTzZoWW+z4HROzp/oYbdRaZPclt12nCxAVdWt9D72vyxdQZ7VWxkhJ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=yuDANdplbDjHmebTBnUA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753933AbeDCWTk (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 18:19:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:33085 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751850AbeDCWTj (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 3 Apr 2018 18:19:39 -0400
From: Alexander Graf <agraf@suse.de>
To: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nisar.Sayed@microchip.com, Woojung.Huh@microchip.com,
        UNGLinuxDriver@microchip.com, tbogendoerfer@suse.de,
        phil@raspberrypi.org, Andrew Lunn <andrew@lunn.ch>,
        RaghuramChary.Jallipalli@microchip.com
Subject: [PATCH v2] lan78xx: Connect phy early
Date: Wed,  4 Apr 2018 00:19:35 +0200
Message-Id: <20180403221935.51099-1-agraf@suse.de>
X-Mailer: git-send-email 2.12.3
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When using wicked with a lan78xx device attached to the system, we
end up with ethtool commands issued on the device before an ifup
got issued. That lead to the following crash:

    Unable to handle kernel NULL pointer dereference at virtual address 0000039c
    pgd = ffff800035b30000
    [0000039c] *pgd=0000000000000000
    Internal error: Oops: 96000004 [#1] SMP
    Modules linked in: [...]
    Supported: Yes
    CPU: 3 PID: 638 Comm: wickedd Tainted: G            E      4.12.14-0-default #1
    Hardware name: raspberrypi rpi/rpi, BIOS 2018.03-rc2 02/21/2018
    task: ffff800035e74180 task.stack: ffff800036718000
    PC is at phy_ethtool_ksettings_get+0x20/0x98
    LR is at lan78xx_get_link_ksettings+0x44/0x60 [lan78xx]
    pc : [<ffff0000086f7f30>] lr : [<ffff000000dcca84>] pstate: 20000005
    sp : ffff80003671bb20
    x29: ffff80003671bb20 x28: ffff800035e74180
    x27: ffff000008912000 x26: 000000000000001d
    x25: 0000000000000124 x24: ffff000008f74d00
    x23: 0000004000114809 x22: 0000000000000000
    x21: ffff80003671bbd0 x20: 0000000000000000
    x19: ffff80003671bbd0 x18: 000000000000040d
    x17: 0000000000000001 x16: 0000000000000000
    x15: 0000000000000000 x14: ffffffffffffffff
    x13: 0000000000000000 x12: 0000000000000020
    x11: 0101010101010101 x10: fefefefefefefeff
    x9 : 7f7f7f7f7f7f7f7f x8 : fefefeff31677364
    x7 : 0000000080808080 x6 : ffff80003671bc9c
    x5 : ffff80003671b9f8 x4 : ffff80002c296190
    x3 : 0000000000000000 x2 : 0000000000000000
    x1 : ffff80003671bbd0 x0 : ffff80003671bc00
    Process wickedd (pid: 638, stack limit = 0xffff800036718000)
    Call trace:
    Exception stack(0xffff80003671b9e0 to 0xffff80003671bb20)
    b9e0: ffff80003671bc00 ffff80003671bbd0 0000000000000000 0000000000000000
    ba00: ffff80002c296190 ffff80003671b9f8 ffff80003671bc9c 0000000080808080
    ba20: fefefeff31677364 7f7f7f7f7f7f7f7f fefefefefefefeff 0101010101010101
    ba40: 0000000000000020 0000000000000000 ffffffffffffffff 0000000000000000
    ba60: 0000000000000000 0000000000000001 000000000000040d ffff80003671bbd0
    ba80: 0000000000000000 ffff80003671bbd0 0000000000000000 0000004000114809
    baa0: ffff000008f74d00 0000000000000124 000000000000001d ffff000008912000
    bac0: ffff800035e74180 ffff80003671bb20 ffff000000dcca84 ffff80003671bb20
    bae0: ffff0000086f7f30 0000000020000005 ffff80002c296000 ffff800035223900
    bb00: 0000ffffffffffff 0000000000000000 ffff80003671bb20 ffff0000086f7f30
    [<ffff0000086f7f30>] phy_ethtool_ksettings_get+0x20/0x98
    [<ffff000000dcca84>] lan78xx_get_link_ksettings+0x44/0x60 [lan78xx]
    [<ffff0000087cbc40>] ethtool_get_settings+0x68/0x210
    [<ffff0000087cc0d4>] dev_ethtool+0x214/0x2180
    [<ffff0000087e5008>] dev_ioctl+0x400/0x630
    [<ffff00000879dd00>] sock_do_ioctl+0x70/0x88
    [<ffff00000879f5f8>] sock_ioctl+0x208/0x368
    [<ffff0000082cde10>] do_vfs_ioctl+0xb0/0x848
    [<ffff0000082ce634>] SyS_ioctl+0x8c/0xa8
    Exception stack(0xffff80003671bec0 to 0xffff80003671c000)
    bec0: 0000000000000009 0000000000008946 0000fffff4e841d0 0000aa0032687465
    bee0: 0000aaaafa2319d4 0000fffff4e841d4 0000000032687465 0000000032687465
    bf00: 000000000000001d 7f7fff7f7f7f7f7f 72606b622e71ff4c 7f7f7f7f7f7f7f7f
    bf20: 0101010101010101 0000000000000020 ffffffffffffffff 0000ffff7f510c68
    bf40: 0000ffff7f6a9d18 0000ffff7f44ce30 000000000000040d 0000ffff7f6f98f0
    bf60: 0000fffff4e842c0 0000000000000001 0000aaaafa2c2e00 0000ffff7f6ab000
    bf80: 0000fffff4e842c0 0000ffff7f62a000 0000aaaafa2b9f20 0000aaaafa2c2e00
    bfa0: 0000fffff4e84818 0000fffff4e841a0 0000ffff7f5ad0cc 0000fffff4e841a0
    bfc0: 0000ffff7f44ce3c 0000000080000000 0000000000000009 000000000000001d
    bfe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000

The culprit is quite simple: The driver tries to access the phy left and right,
but only actually has a working reference to it when the device is up.

The fix thus is quite simple too: Get a reference to the phy on probe already
and keep it even when the device is going down.

With this patch applied, I can successfully run wicked on my system and bring
the interface up and down as many times as I want, without getting NULL pointer
dereferences in between.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v1 -> v2:

  - move debug message (Andrew Lunn)
  - check for phydev != NULL before phy_stop (Sayed Nisar)
  - move phy_disconnect before unregister_netdev (Sayed Nisar)
  - properly unroll failing probe phy_init (Sayed Nisar)
  - change phy_init to phy_start in reset_resume (Sayed Nisar)
---
 drivers/net/usb/lan78xx.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 60a604cc7647..6986f53fe967 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2082,10 +2082,6 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 
 	dev->fc_autoneg = phydev->autoneg;
 
-	phy_start(phydev);
-
-	netif_dbg(dev, ifup, dev->net, "phy initialised successfully");
-
 	return 0;
 
 error:
@@ -2512,9 +2508,9 @@ static int lan78xx_open(struct net_device *net)
 	if (ret < 0)
 		goto done;
 
-	ret = lan78xx_phy_init(dev);
-	if (ret < 0)
-		goto done;
+	phy_start(net->phydev);
+
+	netif_dbg(dev, ifup, dev->net, "phy initialised successfully");
 
 	/* for Link Check */
 	if (dev->urb_intr) {
@@ -2575,13 +2571,8 @@ static int lan78xx_stop(struct net_device *net)
 	if (timer_pending(&dev->stat_monitor))
 		del_timer_sync(&dev->stat_monitor);
 
-	phy_unregister_fixup_for_uid(PHY_KSZ9031RNX, 0xfffffff0);
-	phy_unregister_fixup_for_uid(PHY_LAN8835, 0xfffffff0);
-
-	phy_stop(net->phydev);
-	phy_disconnect(net->phydev);
-
-	net->phydev = NULL;
+	if (net->phydev)
+		phy_stop(net->phydev);
 
 	clear_bit(EVENT_DEV_OPEN, &dev->flags);
 	netif_stop_queue(net);
@@ -3477,8 +3468,13 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 		return;
 
 	udev = interface_to_usbdev(intf);
-
 	net = dev->net;
+
+	phy_unregister_fixup_for_uid(PHY_KSZ9031RNX, 0xfffffff0);
+	phy_unregister_fixup_for_uid(PHY_LAN8835, 0xfffffff0);
+
+	phy_disconnect(net->phydev);
+
 	unregister_netdev(net);
 
 	cancel_delayed_work_sync(&dev->wq);
@@ -3634,8 +3630,14 @@ static int lan78xx_probe(struct usb_interface *intf,
 	pm_runtime_set_autosuspend_delay(&udev->dev,
 					 DEFAULT_AUTOSUSPEND_DELAY);
 
+	ret = lan78xx_phy_init(dev);
+	if (ret < 0)
+		goto out4;
+
 	return 0;
 
+out4:
+	unregister_netdev(netdev);
 out3:
 	lan78xx_unbind(dev, intf);
 out2:
@@ -3983,7 +3985,7 @@ static int lan78xx_reset_resume(struct usb_interface *intf)
 
 	lan78xx_reset(dev);
 
-	lan78xx_phy_init(dev);
+	phy_start(dev->net->phydev);
 
 	return lan78xx_resume(intf);
 }
-- 
2.12.3

