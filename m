Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AH8x224SQQcThPkz+x0/4CP4v1+bnovXhPJ3Y7d2ZP5evR/fjljIsSfCX4Ubnzc19WIpSB/2qV2Z
ARC-Seal: i=1; a=rsa-sha256; t=1518817255; cv=none;
        d=google.com; s=arc-20160816;
        b=A1hu0kJBbnFPTfpk3JejwFd8EmBH7Wa6pOd47SAFTajmaYXRSvCUfXD0E8GLC39hkt
         DkNwlD864VV+ek2t16z9QdxwfKRhEIW7Rnn/tjDc1Hv5MO3nFz1rtJGterdPmBgkQZtl
         VqoH5Y+SF0z9dh4Ciq8iDMvClxtmiQfvFEFmZvn3j4eEuwwjeD8bvxU1DBT76TrNLEzT
         KOJCiyS7L/DiSJyJM8vsR+7JMr62dUfYxqHPiebK5rTAw1MN6T+qJnkD2OiT+tr51q7u
         gqikGyJq/vLmjPhPRgzJuJ/i1uO79RbVMwsLku17CHxpUen1i8a9B1QH71V/ACeqiQMs
         6GCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=66B3Dp43n8duFwet+2rzaQw508uyKvxsDjbPpBBsgWQ=;
        b=U+3pL+vxmc1FGHzr806wgfu5vLfLojFgNjuBwR7R7XO58qIh0RFnj6HxAfkcEVj8v+
         EGfK3FsEXDio5tjWMkHrbOxBKmIDhCVliHqe+bIiy8SHGmWL/cHH014Gkb1iMaacTEbE
         B2ekZhRYrasr+gJjFjYqsnzhUf2BnFEKpntpFfrx1TfrkkSLW4xDsdYdf5H4hbZ1/RLU
         bcitzOSqWO7E/4+J3ilVlyiXql9jLYvasCpRq/GUVeRrg8IofYmqAYZuGq1AR8X9kNTz
         RV1gXSaoMNM33N6HUu8aUi/269n/i7i0d2/JPjtU2Bk11G8Ho3H2Jz4xhv4H+mweppFE
         SXWw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	tulup@mail.ru,
	stephen@networkplumber.org
Cc: devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH] Staging: gdm724x: LTE: Fix trailing open parenthesis code style issue.
Date: Fri, 16 Feb 2018 13:40:08 -0800
Message-Id: <20180216214008.17105-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.1
X-Provags-ID: V03:K0:e8vv21K4LvhcjipQOJ4CaqKMh5kwGs8KZm/kYOXErsh05eBsA6O
 eNsZGFkWv0Ym6V2RKR0OJ78yZFSS4QCemj40h2VX5J7es4gybUxPZ/C+yMGEQu5u0DtdIzj
 PjNEPewGDXcCjpU3snJrGqMFzvdCT8nAbRZ25cwK2oIEWtWC2BEeSD68YV+mX/LmhNYRXF5
 A2M2dorkjm8bD9w7Ft1uw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e0f1y4i5ILU=:VBDSJG2ApGEUHLAZC1ribr
 NTiGN1ZFVqYFdirlSnIw2P9FJz8u+6PYnGGvpY0+0gbkGFHtvbLuz0X+fAwEa884KmxFH9Hlt
 gA0CM7jHk57PW8Rkuw0Ssio6lEBT6H9/kx5CFH5B9CdovhmU0p1eb7u1g9FV8/IHEJ5xZuDic
 Z9ZUGLfVZytE2H3UR4FmDz2g9TK0A4dmZ0ttR5GI0eS1+XLXllHQiA4fJkKWF5Bk/iTXD/jSc
 gRTnQMPMKary5/vq4Z71HWxGGv7CPd3bNxF74lGelLMQASFbYfShMk1H1pYkpg0NrtbcyireD
 O4YeACVrR1XzyxflfM+lUTV5MHIPliZDCfRUiiOBP1HHyaV+E85vNu9yabDbgbSMx/YX0SYs+
 4aer68t1JluRyIqGjbf0f348o8lskIpSOdEfi/kZggxhF8Hrlno4plJ9ddRM1Q8AexmYH9gRt
 jx15RjIqUPzac7S5me5Rb0yWkBUoAiZMtl2ox00vV80X7v8NSnkJPP5spEQd9XyTgPTDP3nu9
 GTlKSSMUmgKnns5eloSkbhojXcibhgYOHl3lstrAqFBxrok9ahWiW44Y3nzJuyqh1Ti9I88A1
 4e0x6D+ZdYEhgkSea2O1FWjDCCzu6xlojiLoh64zQtQiE6rqe8JmR1KIzgOYo9y4kIFyUaF7I
 V2Y/k108+pJvlOmLq5TGf6d62mJr+N8I2S7eTg4cKGClEZuqnBusDAS693leO9fEzPfa4DAEP
 4PsmFNRk4xcDiPR7eH/xmCFAuWrRN1b40dApGA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592595323230814459?=
X-GMAIL-MSGID: =?utf-8?q?1592595323230814459?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix a coding style problem causing warnings from checkpatch.pl.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/gdm724x/gdm_lte.c | 50 ++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_lte.c b/drivers/staging/gdm724x/gdm_lte.c
index 0527b0d1c1d0..ff3fed9c4a81 100644
--- a/drivers/staging/gdm724x/gdm_lte.c
+++ b/drivers/staging/gdm724x/gdm_lte.c
@@ -204,9 +204,12 @@ static __sum16 icmp6_checksum(struct ipv6hdr *ipv6, u16 *ptr, int len)
 	pseudo_header.ph.ph_nxt = ipv6->nexthdr;
 
 	w = (u16 *)&pseudo_header;
-	for (i = 0; i < ARRAY_SIZE(pseudo_header.pa); i++)
-		sum = csum_add(sum, csum_unfold(
-					(__force __sum16)pseudo_header.pa[i]));
+	for (i = 0; i < ARRAY_SIZE(pseudo_header.pa); i++) {
+		__wsum tmp_sum;
+
+		tmp_sum = csum_unfold((__force __sum16)pseudo_header.pa[i]);
+		sum = csum_add(sum, tmp_sum);
+	}
 
 	w = ptr;
 	while (len > 1) {
@@ -510,18 +513,18 @@ static int gdm_lte_event_send(struct net_device *dev, char *buf, int len)
 {
 	struct nic *nic = netdev_priv(dev);
 	struct hci_packet *hci = (struct hci_packet *)buf;
+	struct gdm_endian *phy_endian;
 	int idx;
+	u16 cpu;
 	int ret;
 
 	ret = sscanf(dev->name, "lte%d", &idx);
 	if (ret != 1)
 		return -EINVAL;
 
-	return netlink_send(lte_event.sock, idx, 0, buf,
-			    gdm_dev16_to_cpu(
-				    nic->phy_dev->get_endian(
-					    nic->phy_dev->priv_dev), hci->len)
-			    + HCI_HEADER_SIZE);
+	phy_endian = nic->phy_dev->get_endian(nic->phy_dev->priv_dev);
+	cpu = gdm_dev16_to_cpu(phy_endian, hci->len);
+	return netlink_send(lte_event.sock, idx, 0, buf, cpu + HCI_HEADER_SIZE);
 }
 
 static void gdm_lte_event_rcv(struct net_device *dev, u16 type,
@@ -728,17 +731,21 @@ static void gdm_lte_pdn_table(struct net_device *dev, char *buf, int len)
 {
 	struct nic *nic = netdev_priv(dev);
 	struct hci_pdn_table_ind *pdn_table = (struct hci_pdn_table_ind *)buf;
+	struct gdm_endian *dft_endian;
+	struct gdm_endian *nic_endian;
 
 	if (pdn_table->activate) {
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
+		dft_endian = nic->phy_dev->get_endian(nic->phy_dev->priv_dev);
+		nic_endian = nic->phy_dev->get_endian(nic->phy_dev->priv_dev);
+
+		nic->pdn_table.dft_eps_id =
+			gdm_dev32_to_cpu(dft_endian,
+					 pdn_table->dft_eps_id);
+		nic->pdn_table.nic_type =
+			gdm_dev32_to_cpu(nic_endian,
+					 pdn_table->nic_type);
 
 		netdev_info(dev, "pdn activated, nic_type=0x%x\n",
 			    nic->pdn_table.nic_type);
@@ -896,12 +903,11 @@ int register_lte_device(struct phy_dev *phy_dev,
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
2.16.1
