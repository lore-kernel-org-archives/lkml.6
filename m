Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527160781-2-1377638313870687031
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527160781; b=ErJrgvPnRq+PHQN40bnDg+KyZ+MD+LLPBC7dKd64p9MNB/jqWD
    Jdupt5L2hmkFVOhDq6wfD1p4ZXdOtITLnYzrOgbHoMiuKurdRcaQ+2/LSUjbbABg
    EI25BY3wo21bTUjALC2PONyxRy2WM9x0rINMbLs9zs2fczQaLaa4OyZjfRWbX83B
    /n0MjzZHpXBPURV9a1M4LlwS4bIFsEinMLdZtqwh/KPDIotgOmRZcq3gWeOoXWxi
    lUJwdnDZEQ+guYgzyaHjsx8GexhcOD7Kd0LGNifY0jRrXySQxDtenYz+Gar9GLAF
    sOUZXH6SzzkSP2Y5q2Glcly4KIX6uJC7Drug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527160781; bh=XbN0Jx9TFOhw3fcVg08VOkNIv1J4h6
    J3CQksERoUxVk=; b=dyLOtfI+LpmzpZW/NgfSBAKm6oi47vS7v0cJMbffpjlqs8
    oXP1H2IsPinhoaBDxIjlncJgAp3wX7HwGR3MBB/6eXTk2IwAP+Wkz/50YhLkxzFQ
    b0/Yil8f0nnuqrXrsq1Tz02s1ymN0rL+xotwi7apZUy4XBY/0iLX6Mf8U1gPws3O
    EcEwKi0yiaRyPOx+geTK74ff9PH59sgJsHCjFSu2Ihpxc/Ts0zjt8S0D7k8tgOx/
    mHkeyev2qGtCXhhpbBOF68VdxrZHmw6ZMXwialQF8ucpARi11U1cvxdh3u7ZVMDa
    nFF8MP9G8pHkjtQ/ZmRbU90XQNwSyWuiN8ZR+BFg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=WPCVEgCG x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=WPCVEgCG x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCm8T3l8scORQe/DDsxaCrBhrP1C7kM8O8Kk9LQFW4lDDI8ef1hlcgx0wc6iWEUKH5AaNyfclZAg7kx9HvwYPKwa9Kzfl51uEqu96ub+ozZWRKU7104Q
    hohov7rdDTBw6E5n2omLjJPsoHldwDqQrfNrI38HwyRJzwqWKaQ2VCTiM8q1YZQDa98EJHjio7zKYvngfgI4kJcNl7MzbeFmszflYt9RRg5mcODXuRX0Ku/1
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=M6g0FbP6dAQHMZKsyzYA:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967463AbeEXJwr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:52:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967615AbeEXJwo (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:52:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mohammed Gamal <mgamal@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 033/165] hv_netvsc: Ensure correct teardown message sequence order
Date: Thu, 24 May 2018 11:37:19 +0200
Message-Id: <20180524093623.316542446@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mohammed Gamal <mgamal@redhat.com>

[ Commit a56d99d714665591fed8527b90eef21530ea61e0 upstream. ]

Prior to commit 0cf737808ae7 ("hv_netvsc: netvsc_teardown_gpadl() split")
the call sequence in netvsc_device_remove() was as follows (as
implemented in netvsc_destroy_buf()):
1- Send NVSP_MSG1_TYPE_REVOKE_RECV_BUF message
2- Teardown receive buffer GPADL
3- Send NVSP_MSG1_TYPE_REVOKE_SEND_BUF message
4- Teardown send buffer GPADL
5- Close vmbus

This didn't work for WS2016 hosts. Commit 0cf737808ae7
("hv_netvsc: netvsc_teardown_gpadl() split") rearranged the
teardown sequence as follows:
1- Send NVSP_MSG1_TYPE_REVOKE_RECV_BUF message
2- Send NVSP_MSG1_TYPE_REVOKE_SEND_BUF message
3- Close vmbus
4- Teardown receive buffer GPADL
5- Teardown send buffer GPADL

That worked well for WS2016 hosts, but it prevented guests on older hosts from
shutting down after changing network settings. Commit 0ef58b0a05c1
("hv_netvsc: change GPAD teardown order on older versions") ensured the
following message sequence for older hosts
1- Send NVSP_MSG1_TYPE_REVOKE_RECV_BUF message
2- Send NVSP_MSG1_TYPE_REVOKE_SEND_BUF message
3- Teardown receive buffer GPADL
4- Teardown send buffer GPADL
5- Close vmbus

However, with this sequence calling `ip link set eth0 mtu 1000` hangs and the
process becomes uninterruptible. On futher analysis it turns out that on tearing
down the receive buffer GPADL the kernel is waiting indefinitely
in vmbus_teardown_gpadl() for a completion to be signaled.

Here is a snippet of where this occurs:
int vmbus_teardown_gpadl(struct vmbus_channel *channel, u32 gpadl_handle)
{
        struct vmbus_channel_gpadl_teardown *msg;
        struct vmbus_channel_msginfo *info;
        unsigned long flags;
        int ret;

        info = kmalloc(sizeof(*info) +
                       sizeof(struct vmbus_channel_gpadl_teardown), GFP_KERNEL);
        if (!info)
                return -ENOMEM;

        init_completion(&info->waitevent);
        info->waiting_channel = channel;
[....]
        ret = vmbus_post_msg(msg, sizeof(struct vmbus_channel_gpadl_teardown),
                             true);

        if (ret)
                goto post_msg_err;

        wait_for_completion(&info->waitevent);
[....]
}

The completion is signaled from vmbus_ongpadl_torndown(), which gets called when
the corresponding message is received from the host, which apparently never happens
in that case.
This patch works around the issue by restoring the first mentioned message sequence
for older hosts

Fixes: 0ef58b0a05c1 ("hv_netvsc: change GPAD teardown order on older versions")
Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -571,8 +571,17 @@ void netvsc_device_remove(struct hv_devi
 		= rtnl_dereference(net_device_ctx->nvdev);
 	int i;
 
+	/*
+	 * Revoke receive buffer. If host is pre-Win2016 then tear down
+	 * receive buffer GPADL. Do the same for send buffer.
+	 */
 	netvsc_revoke_recv_buf(device, net_device);
+	if (vmbus_proto_version < VERSION_WIN10)
+		netvsc_teardown_recv_gpadl(device, net_device);
+
 	netvsc_revoke_send_buf(device, net_device);
+	if (vmbus_proto_version < VERSION_WIN10)
+		netvsc_teardown_send_gpadl(device, net_device);
 
 	RCU_INIT_POINTER(net_device_ctx->nvdev, NULL);
 
@@ -586,15 +595,13 @@ void netvsc_device_remove(struct hv_devi
 	 */
 	netdev_dbg(ndev, "net device safe to remove\n");
 
-	/* older versions require that buffer be revoked before close */
-	if (vmbus_proto_version < VERSION_WIN10) {
-		netvsc_teardown_recv_gpadl(device, net_device);
-		netvsc_teardown_send_gpadl(device, net_device);
-	}
-
 	/* Now, we can close the channel safely */
 	vmbus_close(device->channel);
 
+	/*
+	 * If host is Win2016 or higher then we do the GPADL tear down
+	 * here after VMBus is closed.
+	*/
 	if (vmbus_proto_version >= VERSION_WIN10) {
 		netvsc_teardown_recv_gpadl(device, net_device);
 		netvsc_teardown_send_gpadl(device, net_device);
