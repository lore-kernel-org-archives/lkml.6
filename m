Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1550584-1519349496-2-7393758604918558441
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519349495; b=IiiTkRrftNFPQ78d2mE047od3+2JsygnFpxgcp4uST3eLDb
    bRwrMltkSZCfdlndf52UI87bdxEkMikZhccvceFWHLW0YxvGABAGXJ+xT8AMvdOm
    fHYv4hW4jkktgs0/V69ESgVvMvuimHyNlCqci/PxtQaoSbEfxqr6NJZ9kdsgded6
    ynvNvOsI8nuEBAV+QfmbdiJ4yTAEnG7m6WoSLIa1kLHdI5ArkFC2OqEFwmSVXL3q
    bcGMI8gq1rtZkh8q6kz8hK29btPRqwwXXxr9/gspmuXvnQkvw8g1e4EnalIjSS+a
    KitBSU38hY3Ah/bZwLMBS1IP/JhVmUbsWUrCQrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519349495; bh=h
    Yt9vHQFHN6E4DexkEowResPQ0IWbIc59VvdpBiv2k4=; b=FNo6O92h6K3SQOVyS
    Cl6R+oAu2KpqIkQvpgGyIaTBGtWl70gqx8fbMNRe/VACtwJsdGqUWNXrXBHmouxu
    Ne6UAtLmnMhplN7qsmyjvTItuOTzucwdM8MUdWRnKES21C6xE3m5j11WlpAl9Siy
    pOoJ+pJbbWqJxCQZ7YMR3GCPwRdQrwhZ75VKbNqBW8GmEAOa63yADqNbgwET0n88
    sf/6ziKFQu3aoSpYMkzQetftq4MZjtAv33gB6s6Vc9CB8TsPIvIsRzBUCDpYV03k
    jIiKQaJlxMQvCraoIjpWyOzzpOcuKBWCbZiFy3luj1d9+Uf1vsNUVo4vNyNd+876
    noPnA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org, jonathankim@gctsemi.com, deanahn@gctsemi.com,
 dan.carpenter@oracle.com
Subject: [PATCH 1/4] Staging: gdm724x: LTE: Fix trailing open parentheses.
Date: Thu, 22 Feb 2018 17:30:50 -0800
Message-Id: <20180223013053.17474-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <CAFLvi22mENRoFd3Z6=a5tAcbiOGw3CCnvJy_7N4u783_k3jH5g@mail.gmail.com>
References: <CAFLvi22mENRoFd3Z6=a5tAcbiOGw3CCnvJy_7N4u783_k3jH5g@mail.gmail.com>
X-Provags-ID: V03:K0:FUV4T2QR4UZSoLvtk1Fcprel8dlDz7AM6DjiOrSw6xrgjzgBxpr
 faj6ou6vzhf0mDCgpCwiNWzYTL8hgxZk7aiFeFJx7ZMurA4DFrhDOR3HqGdcLIPM1Tg0dko
 5F4tMyK+Guq7SeCcmqH0snExsZVe7pcA0eVZnEJl18TQ/YzUsbo8RjydcxqWGrcEPewK42g
 dePfwgYGiENRe04AXcXAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tqwfJjrdXpA=:CjTiNtbjHjxlBvEhTPaabg
 N3pe8FM3sgI0hLIKshk8yNI/mAVkXpsnVMu6VbJ9itqkUxmMSty7TRPV9v2o9fouZTsT3A566
 uemvQb2EXGw+D6+hDt0+GR8sllOblO7vApgIR3CKOTDF69u/YFUJpYyEaOubT/U21VAIfhIXU
 RuA7Ty0YKTvgbI3aFcetEqvsoxbYL37s88seRRdNq850g7wz21IK7LvAn9zt/p+eAK5KJnL91
 pweRK+wvk9e2/GW7biTGyfa1SS2Jd9b238X3Aip8QwgRT+O4+JoHaoeCdb3QPFVtCMVjO6Ivu
 baMNB4e1rSFwapbesduArVpIbRp781pQqc1+Dz/yckwG8WOblW1EVy8TAfyAP2iSWY/0mgEzu
 LRDMwRtspz7UXIA0/DEd71NoAaKzn6ljfiEbuEaabpO0I5laBkZXt9gYElTap6k6q04jf3MxH
 I7htN6JUcCZUQE+6sDedasWEdXwJW+0Uwq/zMKn9yjFsiXoIjcMo0GtRmJR3Q1uFf0noKhlMb
 L2zNdvak2fpAoDbcQwIE+q+te2ovHWF1njJS7htOOZ3FavpTfmEDAht+d1nAeLOaagss7YPqK
 G686JbhfRvufXYOKyqQUJrlO0vEIYj8+EWfRD/FVEGeWfyOdC/UsFKHf479WCBjLqlJgwNpAY
 wjEivY2/o1f3R8Q5Ui5WNSKKHpGFD8/DGhwSlnnAJTkhmMvNWSukcKyQFO75aHcMtdCtPXBWI
 W1Yf6/xMhUqSIW1YdblvEluhxsdU3JcW47Mm4Q==
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
