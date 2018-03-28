Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-875866-1522198234-2-14602085181226748476
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522198233; b=YW8wfNYdAPU/lB2cFbm6q+e9cvzhdfmyCStFW3NO/JmS9+M
    2X3zgcmRbcFtbjFem3Lk2JcTfQVJZ66baBdADAz435lZW55VX1AwXWe/Bct/sUUL
    obCXnSyiyAxAnZy6Adk9tiS3ATJPaxnMEGmD/6hA8QSRnegVp9m64XOstq2zbDkW
    TKwU2sY35EwCoQSZ+/qooEkZZ5i0gkfhewWof1v1VtMJfKsSIWXTjqJBgcg2QFCW
    UzbcDa0rl69MPOo8fplHSfd3nxETxoL7WkkVVuU3YUiQ6yVjcAGX2LJyjpbXNtGC
    4wapxFujZ9jLzSAnaZKAjN6P20vwNNr9PcsIbdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:mime-version
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1522198233; bh=sV5s0z+KLHXXAMib1xENP5aqyk5baoyx3/4D2vsofB4=; b=N
    0SI4v6HPeP3muEeC97JF5Fz9YrlzHGK6ViYyzKy/JEB8sI4pjuwFpd2+JPq+Xqvj
    d9V5km9IOv0AN3w5rFfQ/aaYGsTdFKyz36DlrsPSJsYLPkib25WO7VI62RYVrgCs
    o+nf3w6wf0m3tjaxhK81UUKDUR9chAdYgxGPi+zbA6RQjQtMtp5jxy7Ejm4Ilm0Q
    EpFG8ITyynSIFJIyK7JgTyQsmakv0exTNl/cMELKz+nNABJKZ9gar4xsdiROTgxo
    1yVjaee11Eg1kZSdBZn1qRQmnd017Ctomog8Cd3qvUYL4TN6HqUFMQcby9O02J0x
    MWR2Nlz2V//sRXuvurtng==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAfjd4TmE1+GNbGO6Ze5YDIhntsIg8aaZGv9GgFjgjdfxgGSuZxx7cG6TjRQpV6WWPYn/ButwbswJ2lwCGsncN44i7zHYHFSVObsEX5J9KSbexRDezcD
    ATNWTNWimkaaoRgwAeRpYFNCJww5iL8nz93qUmw6/U7fpdYdshUNAWtwIDcsrPuK4vlqVz5SS9zHMLer0NW8RVQHUxUgsPHGEh1Lpc8UXYrClYVZ/t83PK8H
    d2TqCX3gbVo2bP7w5P22aA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=wmH2h71lHiwA:10 a=kj9zAlcOel0A:10
    a=v2DPQv5-lfwA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=lwtqpF0IrLJM2hNxfQoA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "James E . J . Bottomley" <JBottomley@odin.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 devel@linuxdriverproject.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [Resend Patch 2/3] Netvsc: Use the vmbus functiton to calculate ring
 buffer percentage
Date: Tue, 27 Mar 2018 17:48:39 -0700
Message-Id: <20180328004840.22787-2-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180328004840.22787-1-longli@linuxonhyperv.com>
References: <20180328004840.22787-1-longli@linuxonhyperv.com>
X-CMAE-Envelope: MS4wfK8iaB4Y41R6eTr5PofrmAXoFzoVhC2j0ZUHbZ2IazodCAARyFDVDct1cTXFXpTBtw/ZxSITBy23EGg7c1Wl/LYNNSdwxrZARu3ztZqLxBBeiyOeHrHF
 VgmKPEND1T1Wks4/4pyGqlwqft7HIy1pWpD7HfKZzqTr0g9Ad26qoQN14i5Gr0ksgGCj21XbiP2DRMSSCG4f/i14C3va2v0XybtoCUyeBs26DtNogf19KuwQ
 ulT7wZkzP8A4absE3pO1nNPhpnPkPLNe5CDje6weE1Doazyx6Gl3Q0tAFZN1+4KZ9iCgqf43TzvH/9YtubXyK1xNonzwEGufVFud+u/DAEfjA/oyWGBzoGQH
 aRnEFibLC+Epmb1GfdbPrh6pki0N2YsyY+3d5k0uwlJ4ampl9uTkIw6dtUhj8yrAt/r4ApCT0+J9qhdy6bkFktZw7svvnOMiRfOIG+ZGZC5JM5iLZLe5O3PK
 /JS3rJ/OHyAEyfDIYgu11oDS9ldCMu8NkzyIIPqB0M6/oqPZKWKjV3RN6jeTxuVl1G4C0WYPqBfRueTx
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
Reply-To: longli@microsoft.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Long Li <longli@microsoft.com>

In Vmbus, we have defined a function to calculate available ring buffer
percentage to write.

Use that function and remove netvsc's private version.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/hyperv/hyperv_net.h |  1 -
 drivers/net/hyperv/netvsc.c     | 17 +++--------------
 drivers/net/hyperv/netvsc_drv.c |  3 ---
 3 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index cd538d5a7986..a0199ab13d67 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -189,7 +189,6 @@ struct netvsc_device;
 struct net_device_context;
 
 extern u32 netvsc_ring_bytes;
-extern struct reciprocal_value netvsc_ring_reciprocal;
 
 struct netvsc_device *netvsc_device_add(struct hv_device *device,
 					const struct netvsc_device_info *info);
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 0265d703eb03..8af0069e4d8c 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -31,7 +31,6 @@
 #include <linux/vmalloc.h>
 #include <linux/rtnetlink.h>
 #include <linux/prefetch.h>
-#include <linux/reciprocal_div.h>
 
 #include <asm/sync_bitops.h>
 
@@ -590,17 +589,6 @@ void netvsc_device_remove(struct hv_device *device)
 #define RING_AVAIL_PERCENT_HIWATER 20
 #define RING_AVAIL_PERCENT_LOWATER 10
 
-/*
- * Get the percentage of available bytes to write in the ring.
- * The return value is in range from 0 to 100.
- */
-static u32 hv_ringbuf_avail_percent(const struct hv_ring_buffer_info *ring_info)
-{
-	u32 avail_write = hv_get_bytes_to_write(ring_info);
-
-	return reciprocal_divide(avail_write  * 100, netvsc_ring_reciprocal);
-}
-
 static inline void netvsc_free_send_slot(struct netvsc_device *net_device,
 					 u32 index)
 {
@@ -649,7 +637,8 @@ static void netvsc_send_tx_complete(struct netvsc_device *net_device,
 		wake_up(&net_device->wait_drain);
 
 	if (netif_tx_queue_stopped(netdev_get_tx_queue(ndev, q_idx)) &&
-	    (hv_ringbuf_avail_percent(&channel->outbound) > RING_AVAIL_PERCENT_HIWATER ||
+	    (hv_get_avail_to_write_percent(&channel->outbound) >
+	     RING_AVAIL_PERCENT_HIWATER ||
 	     queue_sends < 1)) {
 		netif_tx_wake_queue(netdev_get_tx_queue(ndev, q_idx));
 		ndev_ctx->eth_stats.wake_queue++;
@@ -757,7 +746,7 @@ static inline int netvsc_send_pkt(
 	struct netdev_queue *txq = netdev_get_tx_queue(ndev, packet->q_idx);
 	u64 req_id;
 	int ret;
-	u32 ring_avail = hv_ringbuf_avail_percent(&out_channel->outbound);
+	u32 ring_avail = hv_get_avail_to_write_percent(&out_channel->outbound);
 
 	nvmsg.hdr.msg_type = NVSP_MSG1_TYPE_SEND_RNDIS_PKT;
 	if (skb)
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index faea0be18924..b0b1c2fd2b7b 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -35,7 +35,6 @@
 #include <linux/slab.h>
 #include <linux/rtnetlink.h>
 #include <linux/netpoll.h>
-#include <linux/reciprocal_div.h>
 
 #include <net/arp.h>
 #include <net/route.h>
@@ -55,7 +54,6 @@ static unsigned int ring_size __ro_after_init = 128;
 module_param(ring_size, uint, S_IRUGO);
 MODULE_PARM_DESC(ring_size, "Ring buffer size (# of pages)");
 unsigned int netvsc_ring_bytes __ro_after_init;
-struct reciprocal_value netvsc_ring_reciprocal __ro_after_init;
 
 static const u32 default_msg = NETIF_MSG_DRV | NETIF_MSG_PROBE |
 				NETIF_MSG_LINK | NETIF_MSG_IFUP |
@@ -2186,7 +2184,6 @@ static int __init netvsc_drv_init(void)
 			ring_size);
 	}
 	netvsc_ring_bytes = ring_size * PAGE_SIZE;
-	netvsc_ring_reciprocal = reciprocal_value(netvsc_ring_bytes);
 
 	ret = vmbus_driver_register(&netvsc_drv);
 	if (ret)
-- 
2.14.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
