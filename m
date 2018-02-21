Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1161422-1519208457-2-6548311087788101439
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519208456; b=chh+t0sKqEVkrFjEgQ10ZFQnEFHADluhRA5WnPaRFscnqiO
    Kv13ITPemVybc2fm5wEdUw5qlgx4mZwtCXjASblrWFqcGt1x168n+/9wTVT+s4e2
    I0rKwpa12Y3zz5zD9+0NB15lpXHa5yKqL953/AIgTUInJuTEYPSKKHMB0ZoM2mhW
    nF1A/3zklDKpg3J0+G/BbLBySV0fiRnMiDWKt9yJqcEzY4R2RbWzrv4osVTWg0qF
    96jyVUtTt9zfltO1L+A7MjIRRplNN1/8ocnJ0D50jkAU0ljVxTC3E1NmLcKuc0Rr
    +odOCn2I5wCc9ytFf5UJ5ox09k/3G8VqUKh0PGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519208456; bh=h
    Yt9vHQFHN6E4DexkEowResPQ0IWbIc59VvdpBiv2k4=; b=R/cqVGFHKM099WCns
    P4/4XYruu1nI/YTlIYx3HSETuHWzjAzGuq9p7BTRpvyQEzuhJS+0SqGn7UlYle62
    6hNitaOgc6OpWYkY/jT4S/JApSQ28s6gVC3bT2LslN5umr0swsikFFlaogDWI4C6
    0ltIZxN89U0ht1RO/M0dSG9wrX6mU5b0XRMdJGUGAoKI2NVZx0WZ94WXwHt+qzw3
    OY3sjKI8Qqig4UtiVvmoXGEGYCrM8VaycwB7rF+cRyl01/z12/aXS8pvoKX7HB0k
    voUxqOi75ifBw6XFLYqY0mysG1aGQGgpXObfBxY6Y5AumK51KI5VJETzX2Ui1so3
    ay1tQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org, jonathankim@gctsemi.com, deanahn@gctsemi.com,
 dan.carpenter@oracle.com
Subject: [PATCH] Staging: gdm724x: LTE: Fix trailing open parentheses.
Date: Wed, 21 Feb 2018 02:20:17 -0800
Message-Id: <20180221102017.17211-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180219091550.7nhyjfqvwob6cc2c@mwanda>
References: <20180219091550.7nhyjfqvwob6cc2c@mwanda>
X-Provags-ID: V03:K0:g8wc5gEOsCFxpXTc6EnTgN/VJKclcznU4AjkuMpPmhzP8k/RrPa
 D6K7X3CRWuxW2Xc3Uc0jUKaBBRqVgYWV+R+0npki85vOuoVumbHWRkVN/qoZbbK5rgE3eMG
 cgzOP8+w9iSqalNmFLxvvLZKNmR3BI1H4oNXFLTp2RJx6USPaLC9DHPk3gOyfQYCkuOiYAS
 nL9yju+M1fCgJsXC7q1gA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tidrprKY1mU=:ta20ZMWwLTGp8XIr0DeLZL
 9/ueZRXJnCn9HqO3/5zgpA6v2Wf9DQCWz6Bci5v4ZOSe2mGl17zvvSH/fxmWtyat8bjPvJQcV
 qC6b7RXETaIxTNMvQBQyet1ZHLnKLYKqbFICcH3OfxcKRZA1jlrkrGR6987IMl8VwjmkYEiiS
 Xzio6+60jNyw39whZ804s4L//21K4AX9gemotTn2V03LUd5qmtBuRJN1IK+t80oXXpjjCfE7v
 Z3UigFJo0OP/g+a14ndldz6qrlbzvtzREummrIHgFCXmzjMwLxCZQSrupAkqH82VzP1quxq2W
 u5FfqUaklj/0yoACwT3vmvSD9KL23ZMQ7IbDPBaQ1pDlTE2HL4hBUCh0C4PamMdEG6ncUw9JN
 Z4Z+9+TXkNMtU2NGQGS1fKZq2j6O3KAzBhvz2XhPIN34p9FyTaQmv18byEa9faOSdJpQy2Ma3
 MKrS4oFlfr2fvDgEcw7VrpGrlK94FuiNBv2wToMeewgAT9yOqWGB+L/ln4Q/Y1hfD3KLGHcIr
 6zhxjRC8h1LTRskCVTRBuN6zqArVePBKz+efQ/2vmKADhdLaJbbsNc4Yhj4CjJVpzfZl5S673
 +MRw5VECpbAe76scBjeD//1JcDk9bYvX6pr2aYpejzELfpBVbtLlPELnV7rfqKqO1XvoXOKZl
 T7embsopovO7AVP7TpueoZLjYNevxDHWIZrTIh0BlEMRq6ebPjcCvIsWUq2geWO860Auy1z1A
 eshhh4dacemBbbd7fVhokQ7UwulyCH93rbXXDg==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Quytelda Kahja <quytelda@tamalin.org>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix lines with a trailing open parenthesis, which is a coding style issue.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/gdm724x/gdm_lte.c | 44 +++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_lte.c b/drivers/staging/gdm724x/gdm_lte.c
index a6608637035a..8d492d6d6a12 100644
--- a/drivers/staging/gdm724x/gdm_lte.c
+++ b/drivers/staging/gdm724x/gdm_lte.c
@@ -185,6 +185,7 @@ static __sum16 icmp6_checksum(struct ipv6hdr *ipv6, u16 *ptr, int len)
 	unsigned short *w = ptr;
 	__wsum sum = 0;
 	int i;
+	u16 pa;
 
 	union {
 		struct {
@@ -204,9 +205,10 @@ static __sum16 icmp6_checksum(struct ipv6hdr *ipv6, u16 *ptr, int len)
 	pseudo_header.ph.ph_nxt = ipv6->nexthdr;
 
 	w = (u16 *)&pseudo_header;
-	for (i = 0; i < ARRAY_SIZE(pseudo_header.pa); i++)
-		sum = csum_add(sum, csum_unfold(
-					(__force __sum16)pseudo_header.pa[i]));
+	for (i = 0; i < ARRAY_SIZE(pseudo_header.pa); i++) {
+		pa = pseudo_header.pa[i];
+		sum = csum_add(sum, csum_unfold((__force __sum16)pa));
+	}
 
 	w = ptr;
 	while (len > 1) {
@@ -509,8 +511,9 @@ static struct net_device_stats *gdm_lte_stats(struct net_device *dev)
 
 static int gdm_lte_event_send(struct net_device *dev, char *buf, int len)
 {
-	struct nic *nic = netdev_priv(dev);
+	struct phy_dev *phy_dev = ((struct nic *)netdev_priv(dev))->phy_dev;
 	struct hci_packet *hci = (struct hci_packet *)buf;
+	int length;
 	int idx;
 	int ret;
 
@@ -518,11 +521,9 @@ static int gdm_lte_event_send(struct net_device *dev, char *buf, int len)
 	if (ret != 1)
 		return -EINVAL;
 
-	return netlink_send(lte_event.sock, idx, 0, buf,
-			    gdm_dev16_to_cpu(
-				    nic->phy_dev->get_endian(
-					    nic->phy_dev->priv_dev), hci->len)
-			    + HCI_HEADER_SIZE);
+	length = gdm_dev16_to_cpu(phy_dev->get_endian(phy_dev->priv_dev),
+				  hci->len) + HCI_HEADER_SIZE;
+	return netlink_send(lte_event.sock, idx, 0, buf, length);
 }
 
 static void gdm_lte_event_rcv(struct net_device *dev, u16 type,
@@ -731,15 +732,13 @@ static void gdm_lte_pdn_table(struct net_device *dev, char *buf, int len)
 	struct hci_pdn_table_ind *pdn_table = (struct hci_pdn_table_ind *)buf;
 
 	if (pdn_table->activate) {
+		struct gdm_endian *ed;
+
 		nic->pdn_table.activate = pdn_table->activate;
-		nic->pdn_table.dft_eps_id = gdm_dev32_to_cpu(
-						nic->phy_dev->get_endian(
-							nic->phy_dev->priv_dev),
-						pdn_table->dft_eps_id);
-		nic->pdn_table.nic_type = gdm_dev32_to_cpu(
-						nic->phy_dev->get_endian(
-							nic->phy_dev->priv_dev),
-						pdn_table->nic_type);
+
+		ed = nic->phy_dev->get_endian(nic->phy_dev->priv_dev);
+		nic->pdn_table.dft_eps_id = gdm_dev32_to_cpu(ed, pdn_table->dft_eps_id);
+		nic->pdn_table.nic_type = gdm_dev32_to_cpu(ed, pdn_table->nic_type);
 
 		netdev_info(dev, "pdn activated, nic_type=0x%x\n",
 			    nic->pdn_table.nic_type);
@@ -897,12 +896,11 @@ int register_lte_device(struct phy_dev *phy_dev,
 		nic->phy_dev = phy_dev;
 		nic->nic_id = index;
 
-		form_mac_address(
-				net->dev_addr,
-				nic->src_mac_addr,
-				nic->dest_mac_addr,
-				mac_address,
-				index);
+		form_mac_address(net->dev_addr,
+				 nic->src_mac_addr,
+				 nic->dest_mac_addr,
+				 mac_address,
+				 index);
 
 		SET_NETDEV_DEV(net, dev);
 		SET_NETDEV_DEVTYPE(net, &wwan_type);
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
