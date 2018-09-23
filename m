Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E30AECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 21:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126BD20989
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 21:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126BD20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbeIXDKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 23:10:42 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:57044
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727243AbeIXDKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 23:10:42 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id 4BePgaht1wkZt4BePgvXgH; Sun, 23 Sep 2018 14:10:46 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1g4BeP-0007H7-KD; Sun, 23 Sep 2018 14:10:45 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 1/4] Drivers: hv: vmbus: Fix the descriptions of some function parameters
Date:   Sun, 23 Sep 2018 21:10:41 +0000
Message-Id: <20180923211044.27922-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180923210938.27859-1-kys@linuxonhyperv.com>
References: <20180923210938.27859-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfHLNg71+opW70PDbGj8AltQztl0Dhjxx+4Pl1PXfkMLc0PEiZYYEiAIC5gk53f2PnOqvjcp3KrVE8xMLU6bBshZzdTC6ADZMWZYOviOdGnBufL6/CZKx
 YpiI+YLTQTHyOScC2503CaAaIolZU5GpR2/yf3jTPfoKJl4UXwCXuk2qdJ6Nv7l7naXtWPyBkQTCR/villljLpStqKfXfmSCmYKFZQyeJyNP9lqI0cagHEgg
 7MY67cREtVBZ0n6bEzzyV1+7u7L742x0U8xFJQjMC0VHmIhFsdPW453fBvOXBcz+7RsgI9tWEFg79cW0N3lYvpaI/PVLwbdMlEwZsigYK4ouuO2vdpnZaUg1
 QZPAcUARBTcAtaXBvbm+2ZurVO6pYVtw0KKiegWTIy2zbb1mOHTubuxlw55QfqKev4cgif85qFLDmvYAIr5kSONb+a7OdT0p1MdzLaT/299RjyQgCFwl3oyT
 BilM3HLnyEy6ILceSiG6AxFX6AUzWMOFw1PgRBuqakNaBkJ7odyzO+ZG1cNyL3S48C5RH9yA0RmMZA009ClGpnnySuVyljlaP4NWaT6VznSBUnNj3XJ7tnnU
 n1Rw5kQIMtGr7rUZybhSa/0tYACh+M9+QDVVAuDi87CaVtDXd6+/PxI3a9vem+jXkhPGtJXT11Dii/nzNlO694kV
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

No functional change.

Added descriptions for some parameters.
Fixed some typos.
Removed some out-of-date comments.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/channel.c      | 24 +++++++++++++-----------
 drivers/hv/channel_mgmt.c | 23 +++++++++--------------
 2 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 741857d80da1..ab92779271d0 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -709,15 +709,16 @@ EXPORT_SYMBOL_GPL(vmbus_close);
 
 /**
  * vmbus_sendpacket() - Send the specified buffer on the given channel
- * @channel: Pointer to vmbus_channel structure.
- * @buffer: Pointer to the buffer you want to receive the data into.
- * @bufferlen: Maximum size of what the the buffer will hold
+ * @channel: Pointer to vmbus_channel structure
+ * @buffer: Pointer to the buffer you want to send the data from.
+ * @bufferlen: Maximum size of what the buffer holds.
  * @requestid: Identifier of the request
- * @type: Type of packet that is being send e.g. negotiate, time
- * packet etc.
+ * @type: Type of packet that is being sent e.g. negotiate, time
+ *	  packet etc.
+ * @flags: 0 or VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED
  *
- * Sends data in @buffer directly to hyper-v via the vmbus
- * This will send the data unparsed to hyper-v.
+ * Sends data in @buffer directly to Hyper-V via the vmbus.
+ * This will send the data unparsed to Hyper-V.
  *
  * Mainly used by Hyper-V drivers.
  */
@@ -850,12 +851,13 @@ int vmbus_sendpacket_mpb_desc(struct vmbus_channel *channel,
 EXPORT_SYMBOL_GPL(vmbus_sendpacket_mpb_desc);
 
 /**
- * vmbus_recvpacket() - Retrieve the user packet on the specified channel
- * @channel: Pointer to vmbus_channel structure.
+ * __vmbus_recvpacket() - Retrieve the user packet on the specified channel
+ * @channel: Pointer to vmbus_channel structure
  * @buffer: Pointer to the buffer you want to receive the data into.
- * @bufferlen: Maximum size of what the the buffer will hold
- * @buffer_actual_len: The actual size of the data after it was received
+ * @bufferlen: Maximum size of what the buffer can hold.
+ * @buffer_actual_len: The actual size of the data after it was received.
  * @requestid: Identifier of the request
+ * @raw: true means keep the vmpacket_descriptor header in the received data.
  *
  * Receives directly from the hyper-v vmbus and puts the data it received
  * into Buffer. This will receive the data unparsed from hyper-v.
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 0f0e091c117c..e7598b569bea 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -198,24 +198,19 @@ static u16 hv_get_dev_type(const struct vmbus_channel *channel)
 }
 
 /**
- * vmbus_prep_negotiate_resp() - Create default response for Hyper-V Negotiate message
+ * vmbus_prep_negotiate_resp() - Create default response for Negotiate message
  * @icmsghdrp: Pointer to msg header structure
- * @icmsg_negotiate: Pointer to negotiate message structure
  * @buf: Raw buffer channel data
+ * @fw_version: The framework versions we can support.
+ * @fw_vercnt: The size of @fw_version.
+ * @srv_version: The service versions we can support.
+ * @srv_vercnt: The size of @srv_version.
+ * @nego_fw_version: The selected framework version.
+ * @nego_srv_version: The selected service version.
  *
- * @icmsghdrp is of type &struct icmsg_hdr.
- * Set up and fill in default negotiate response message.
- *
- * The fw_version and fw_vercnt specifies the framework version that
- * we can support.
- *
- * The srv_version and srv_vercnt specifies the service
- * versions we can support.
- *
- * Versions are given in decreasing order.
- *
- * nego_fw_version and nego_srv_version store the selected protocol versions.
+ * Note: Versions are given in decreasing order.
  *
+ * Set up and fill in default negotiate response message.
  * Mainly used by Hyper-V drivers.
  */
 bool vmbus_prep_negotiate_resp(struct icmsg_hdr *icmsghdrp,
-- 
2.18.0

