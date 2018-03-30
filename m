Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/lDFLQ0PDhk9M9dpGoJkK10rfEoBqj/yo1MSquEG/6VQ19uPtCrDo9dco3Ji5jFmIvDht8
ARC-Seal: i=1; a=rsa-sha256; t=1522393797; cv=none;
        d=google.com; s=arc-20160816;
        b=aaul9Qfhc0U1Hc4eCd1qeWwBqKkEEnWScE6OYZqerk6x3mtfRLxWM5zcEg3wANzQ8r
         3uTHrRIFhfn+M+QAju2Z3VvGYSvBltYQcwbcMBal1Vdj4y+5hUOquYOL4GZThnkTg6fq
         LUCat98iJuAP/pZmfjIn6Yc8eS52j3Dn7VxtuzIneYhjI0VjQANvtVsFYvER6IRHmzVk
         Gbd9874g51owyKhIEgSaldfL2P0hrfRDnvokEiTNn0/MPqIVCNEdOKTUymvW09/p5gJs
         iIckRv/QSn7lzAqgko56mLUolVeUQADUOyePcvtVsmkenycfCUQniVtCYuyt7X/+aIJx
         ngTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=X5Z+/YigAoi17l5lk0qsO7279LMSFWYmnbcjLTAQuJ4=;
        b=ylW9aTt5qGj68st0Bok8Zh85asQTVPgBxD4S6RLyNVCK/D+YpLLpRL3KUvB6Smz/3+
         SilXg1GZwaIj1TIH5VOxfzFOXPWyG2wTMKLsUzpGjVIR+xUdHECFxoVPTS6hRdmY3IBj
         3+aLfp6xH5T0VmiNqtLWkDacg0sOudNEcpUYm41RSuyTomQMlgtyvbdwfAd/MbuLhxlZ
         Aoh94tIVJX+8sw0RCMldVdpDKbeEJcy2zVoIm8j2pQ37hLbpXahTdOha1R50pnnbALm3
         uRx7/SUEv6fG+0yl85sY8mlTluF5YG3TjW6Owwy/oS4P63altuzaYFWlCqhewNH/AQji
         Oyhw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 69/76] staging: ks7010: Remove 'eth_addr' field from 'struct ks_wlan_private'.
Date: Fri, 30 Mar 2018 00:08:32 -0700
Message-Id: <20180330070842.25224-69-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:i6Y3VuCIGrTC4KwauSJdJKHJHor4ne95krMo8ZH1f5LzZYbBZ+h
 A6vU0KmehVj4QjgoUGkkcLO4blpXkm5PGHzm5hW/TPkOKO3YZ6ISxMEbY1I48qwrAiwHYQD
 cmXki96kyqOzq5+Z8t2Vy4CL3PMT8x1pjIXAYz7sr2hBq8VlW/trpQZHIqNfxEtelURh8MD
 MJxTIlwEsaOYlyqt/Q7gQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yCtXgHQYjYk=:TRMvaqASDL/I9SMI0AS9fi
 MMjyQ3HHW44k3sBpwwY21gMaxffERgGHp6R29VojoIJke/q4dfc30EndZT6Ssxb6ZkyH9yuwi
 Q9xE1CNhnuBVn7PFNyShHHsLCH3/2D+S/mEOP+eV26hDPzcjOzf4a0WnsceFLCZfwoFyNixsG
 WKw4OT9THlrlDw6iUbR01hBxEjUo1ApZpxSNCJ0+g3qvxCKZMcktbEHQTKyPqRzNXDi+5RdWQ
 aHy8GnyhAj4DN/5Nplm9P7wTgQYbAbH22avwzQz1Ik837RzbRG5KDC4VDvxgfpgBJUOrCTXoq
 PV2dxfWsfy4HHlwgUGviSoiPnxD/MldGxfW4lAF/GAJzIjOI0FFjCqnQd0K7pUhq4tPtJyiLb
 TSk8FoZcKwOB63xFFvCjEJ6cEp2M2wbcLuDAuK7K17zoJaGBi7biahHBOhyX67qPLK/PixypK
 jeTGU7rVjR9RoHgQ7fV3++x0BxNlPt17gzUrOuY7seSAg8u9ttdt7a/HYooUP/g507ai+y0ux
 VxyNTq8s0tLx2S7+QvGoGqwS/AeG4hICK0up2reVGXAgjwp2hC6umTg7IWWpk7lUEDeTpwBTD
 Nobj+M7Q484eWcWqEfDWyXrUkVx/ygfRbAO9XRnw6eFtUZccwGvMK9d8X+F6INhIJdWJH1LRV
 NKjACNl6a8ORbnmgZlip0OkjjnWsuE3W9nM8Jm3sxqqTEafJcAaq6dg0LMELyX129tSr8sBd2
 u1zBhxToqo1gtw7YDccHaPfqkBKSprpO5iDVxQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345598630368809?=
X-GMAIL-MSGID: =?utf-8?q?1596345598630368809?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The ethernet address of the network device is already stored in the
'dev_addr' field of 'struct net_device'.  Since 'struct ks_wlan_private'
keeps a pointer to the driver's 'struct net_device', there is no reason
to duplicate this information in 'struct ks_wlan_private'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c   | 29 +++++++++++------------------
 drivers/staging/ks7010/ks_wlan.h     |  2 --
 drivers/staging/ks7010/ks_wlan_net.c |  5 ++---
 3 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 1eff78540683..3c8a8d0f800c 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -388,6 +388,7 @@ int hostif_data_indication_wpa(struct ks_wlan_private *priv,
 static
 void hostif_data_indication(struct ks_wlan_private *priv)
 {
+	struct net_device * dev = priv->net_dev;
 	unsigned int rx_ind_size;	/* indicate data size */
 	struct sk_buff *skb;
 	unsigned short auth_type;
@@ -411,9 +412,9 @@ void hostif_data_indication(struct ks_wlan_private *priv)
 	eth_proto = ntohs(eth_hdr->h_proto);
 
 	/* source address check */
-	if (memcmp(&priv->eth_addr[0], eth_hdr->h_source, ETH_ALEN) == 0) {
-		netdev_err(priv->net_dev, "invalid : source is own mac address !!\n");
-		netdev_err(priv->net_dev,
+	if (memcmp(dev->dev_addr, eth_hdr->h_source, ETH_ALEN) == 0) {
+		netdev_err(dev, "invalid : source is own mac address !!\n");
+		netdev_err(dev,
 			   "eth_hdrernet->h_dest=%02X:%02X:%02X:%02X:%02X:%02X\n",
 			   eth_hdr->h_source[0], eth_hdr->h_source[1],
 			   eth_hdr->h_source[2], eth_hdr->h_source[3],
@@ -443,7 +444,7 @@ void hostif_data_indication(struct ks_wlan_private *priv)
 			priv->nstats.rx_dropped++;
 			return;
 		}
-		netdev_dbg(priv->net_dev, "SNAP, rx_ind_size = %d\n",
+		netdev_dbg(dev, "SNAP, rx_ind_size = %d\n",
 			   rx_ind_size);
 
 		size = ETH_ALEN * 2;
@@ -463,7 +464,7 @@ void hostif_data_indication(struct ks_wlan_private *priv)
 			priv->nstats.rx_dropped++;
 			return;
 		}
-		netdev_dbg(priv->net_dev, "NETBEUI/NetBIOS rx_ind_size=%d\n",
+		netdev_dbg(dev, "NETBEUI/NetBIOS rx_ind_size=%d\n",
 			   rx_ind_size);
 
 		/* 8802/FDDI MAC copy */
@@ -480,7 +481,7 @@ void hostif_data_indication(struct ks_wlan_private *priv)
 		aa1x_hdr = (struct ieee802_1x_hdr *)(priv->rxp + 14);
 		break;
 	default:	/* other rx data */
-		netdev_err(priv->net_dev, "invalid data format\n");
+		netdev_err(dev, "invalid data format\n");
 		priv->nstats.rx_errors++;
 		return;
 	}
@@ -522,17 +523,9 @@ void hostif_mib_get_confirm(struct ks_wlan_private *priv)
 	case DOT11_MAC_ADDRESS:
 		/* MAC address */
 		hostif_sme_enqueue(priv, SME_GET_MAC_ADDRESS);
-		memcpy(priv->eth_addr, priv->rxp, ETH_ALEN);
+		memcpy(dev->dev_addr, priv->rxp, ETH_ALEN);
 		priv->mac_address_valid = true;
-		dev->dev_addr[0] = priv->eth_addr[0];
-		dev->dev_addr[1] = priv->eth_addr[1];
-		dev->dev_addr[2] = priv->eth_addr[2];
-		dev->dev_addr[3] = priv->eth_addr[3];
-		dev->dev_addr[4] = priv->eth_addr[4];
-		dev->dev_addr[5] = priv->eth_addr[5];
-		dev->dev_addr[6] = 0x00;
-		dev->dev_addr[7] = 0x00;
-		netdev_info(dev, "MAC ADDRESS = %pM\n", priv->eth_addr);
+		netdev_info(dev, "MAC ADDRESS = %pM\n", dev->dev_addr);
 		break;
 	case DOT11_PRODUCT_VERSION:
 		/* firmware version */
@@ -1111,7 +1104,7 @@ int hostif_data_request(struct ks_wlan_private *priv, struct sk_buff *skb)
 
 	/* skb check */
 	eth = (struct ethhdr *)skb->data;
-	if (memcmp(&priv->eth_addr[0], eth->h_source, ETH_ALEN) != 0) {
+	if (memcmp(priv->net_dev->dev_addr, eth->h_source, ETH_ALEN) != 0) {
 		netdev_err(priv->net_dev, "invalid mac address !!\n");
 		netdev_err(priv->net_dev, "ethernet->h_source=%pM\n", eth->h_source);
 		ret = -ENXIO;
@@ -2167,7 +2160,7 @@ void hostif_sme_execute(struct ks_wlan_private *priv, int event)
 	case SME_MACADDRESS_SET_REQUEST:
 		hostif_mib_set_request(priv, LOCAL_CURRENTADDRESS, ETH_ALEN,
 				       MIB_VALUE_TYPE_OSTRING,
-				       &priv->eth_addr[0]);
+				       priv->net_dev->dev_addr);
 		break;
 	case SME_BSS_SCAN_REQUEST:
 		hostif_bss_scan_request(priv, priv->reg.scan_type,
diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index eb0c14e78bd2..012e0fe2b60d 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -421,8 +421,6 @@ struct ks_wlan_private {
 	struct work_struct wakeup_work;
 	int scan_ind_count;
 
-	unsigned char eth_addr[ETH_ALEN];
-
 	struct local_aplist aplist;
 	struct local_ap current_ap;
 	struct power_save_status psstatus;
diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index d6bfbc1f8558..35c615433687 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -2749,11 +2749,10 @@ int ks_wlan_set_mac_address(struct net_device *dev, void *addr)
 	if (netif_running(dev))
 		return -EBUSY;
 	memcpy(dev->dev_addr, mac_addr->sa_data, dev->addr_len);
-	memcpy(priv->eth_addr, mac_addr->sa_data, ETH_ALEN);
 
 	priv->mac_address_valid = false;
 	hostif_sme_enqueue(priv, SME_MACADDRESS_SET_REQUEST);
-	netdev_info(dev, "ks_wlan:  MAC ADDRESS = %pM\n", priv->eth_addr);
+	netdev_info(dev, "ks_wlan:  MAC ADDRESS = %pM\n", dev->dev_addr);
 	return 0;
 }
 
@@ -2884,7 +2883,7 @@ int ks_wlan_net_start(struct net_device *dev)
 	timer_setup(&update_phyinfo_timer, ks_wlan_update_phyinfo_timeout, 0);
 
 	/* dummy address set */
-	ether_addr_copy(dev->dev_addr, priv->eth_addr);
+	ether_addr_copy(dev->dev_addr, dummy_addr);
 
 	/* The ks_wlan-specific entries in the device structure. */
 	dev->netdev_ops = &ks_wlan_netdev_ops;
-- 
2.16.3
