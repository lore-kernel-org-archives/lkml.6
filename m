Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490082-1521484058-2-1503700393015589968
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521484057; b=tROwgWuZlXCifA/ce2sWkRT8RF33UdYuM9bu5MWLA33DSGD
    FUAv0B+Jkt+mjaNoVGcBCsBjL/iOynAdaC12ZQBs8xvwo0b1COrbiRowwGK8v+q5
    DICzBJcS/aMx1AQ3H/tUJUG3Yj5L7TyrEgZunctGkslH7aWBf/ic90pFchwIt39H
    O/RA0J4OSJgl242EnFiAkdj8dp11yaViA0Z1EjQoALj3BQdush3+n/AthLILCxfI
    Oq/UXmAKZAWi7scgVzDqttWISh1dD+ap3iFtB7RLVkZ0OshCUOYdHJVgAKNYGxNo
    /U2EOaPDddxLR9tOpJ0wEL80akyN4VPB5Z4K8Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484057; bh=oJ06lcK2LqtgETyDWEXEjCcNyf
    QHx3okydp3NtPSpe4=; b=v04Ql7JGSwnzZcjGpHx98i2+OmBHlpJoMcHxwoGidO
    6HQB/v8iNuCmBdRaqlRSxsA1egVW2TFGjPgWWb1pI507qVqp7BQELLDiUXIRhKEP
    75gF1zZiKFAiBxmhDtXPqMjGMfA2dwc1cMK7ZK6ZyaOlYgngyPvUwuBVzI6qOZMh
    XdE1o5z0AH7KMoxxNr1ZVuOawWOvK8Fvjsw5IIOFwATBoKkpfeq+qQGbzw2ZMmEu
    8f/EdLK276dtmCg9p+gQXbcQspEnLj3j9q7RFlFo6MhHPweC0boDjrnDQEbOP9Jl
    /BgbzrXmVCMgUADZ6k9hsZ7q0Ysb6ehg+apuRKpGUeIw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeehtdejfeenucevlhhushhtvghrufhiiigvpeelud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeehtdejfeenucevlhhushhtvghrufhiiigvpeelud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970032AbeCSS1d (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:27:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51202 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970020AbeCSS1Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:27:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 210/241] net: hns: Some checkpatch.pl script & warning fixes
Date: Mon, 19 Mar 2018 19:07:55 +0100
Message-Id: <20180319180759.866979135@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
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

From: Salil <salil.mehta@huawei.com>

commit b4957ab0826f6f7efdfdc648521e1c4c3fc6ceda upstream.

This patch fixes some checkpatch.pl script caught errors and
warnings during the compilation time.

[ backported to 4.9.y to fix build warnings caused by the backporting of
  64ec10dc2ab8 ("net: hns: Correct HNS RSS key set function") by Sasha
  - gregkh]

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |   11 +++++------
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c  |    1 -
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |    5 +++--
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   |    1 -
 5 files changed, 9 insertions(+), 11 deletions(-)

--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
@@ -86,12 +86,11 @@ static void hns_gmac_disable(void *mac_d
 		dsaf_set_dev_bit(drv, GMAC_PORT_EN_REG, GMAC_PORT_RX_EN_B, 0);
 }
 
-/**
-*hns_gmac_get_en - get port enable
-*@mac_drv:mac device
-*@rx:rx enable
-*@tx:tx enable
-*/
+/* hns_gmac_get_en - get port enable
+ * @mac_drv:mac device
+ * @rx:rx enable
+ * @tx:tx enable
+ */
 static void hns_gmac_get_en(void *mac_drv, u32 *rx, u32 *tx)
 {
 	struct mac_driver *drv = (struct mac_driver *)mac_drv;
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
@@ -70,7 +70,7 @@ enum dsaf_roce_qos_sl {
 };
 
 #define DSAF_STATS_READ(p, offset) (*((u64 *)((u8 *)(p) + (offset))))
-#define HNS_DSAF_IS_DEBUG(dev) (dev->dsaf_mode == DSAF_MODE_DISABLE_SP)
+#define HNS_DSAF_IS_DEBUG(dev) ((dev)->dsaf_mode == DSAF_MODE_DISABLE_SP)
 
 enum hal_dsaf_mode {
 	HRD_DSAF_NO_DSAF_MODE	= 0x0,
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
@@ -430,7 +430,6 @@ static void hns_rcb_ring_pair_get_cfg(st
 static int hns_rcb_get_port_in_comm(
 	struct rcb_common_cb *rcb_common, int ring_idx)
 {
-
 	return ring_idx / (rcb_common->max_q_per_vf * rcb_common->max_vfn);
 }
 
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -511,7 +511,8 @@ static void hns_nic_reuse_page(struct sk
 	int last_offset;
 	bool twobufs;
 
-	twobufs = ((PAGE_SIZE < 8192) && hnae_buf_size(ring) == HNS_BUFFER_SIZE_2048);
+	twobufs = ((PAGE_SIZE < 8192) &&
+		hnae_buf_size(ring) == HNS_BUFFER_SIZE_2048);
 
 	desc = &ring->desc[ring->next_to_clean];
 	size = le16_to_cpu(desc->rx.size);
@@ -1700,7 +1701,7 @@ static void hns_nic_reset_subtask(struct
 static void hns_nic_service_event_complete(struct hns_nic_priv *priv)
 {
 	WARN_ON(!test_bit(NIC_STATE_SERVICE_SCHED, &priv->state));
-
+	/* make sure to commit the things */
 	smp_mb__before_atomic();
 	clear_bit(NIC_STATE_SERVICE_SCHED, &priv->state);
 }
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -1243,7 +1243,6 @@ hns_set_rss(struct net_device *netdev, c
 {
 	struct hns_nic_priv *priv = netdev_priv(netdev);
 	struct hnae_ae_ops *ops;
-	int ret;
 
 	if (AE_IS_VER1(priv->enet_ver)) {
 		netdev_err(netdev,
