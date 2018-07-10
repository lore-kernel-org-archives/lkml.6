Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB67C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD9520936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD9520936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732863AbeGJS0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:26:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43810 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732387AbeGJS0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:26:45 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 34372D71;
        Tue, 10 Jul 2018 18:26:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Hill <josh@joshuajhill.com>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 07/23] net: qmi_wwan: Add Netgear Aircard 779S
Date:   Tue, 10 Jul 2018 20:24:40 +0200
Message-Id: <20180710182309.191632388@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182308.877332304@linuxfoundation.org>
References: <20180710182308.877332304@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Hill <josh@joshuajhill.com>

[ Upstream commit 2415f3bd059fe050eb98aedf93664d000ceb4e92 ]

Add support for Netgear Aircard 779S

Signed-off-by: Josh Hill <josh@joshuajhill.com>
Acked-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -677,6 +677,7 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 0)},
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 5)},
 	{QMI_FIXED_INTF(0x0846, 0x68a2, 8)},
+	{QMI_FIXED_INTF(0x0846, 0x68d3, 8)},	/* Netgear Aircard 779S */
 	{QMI_FIXED_INTF(0x12d1, 0x140c, 1)},	/* Huawei E173 */
 	{QMI_FIXED_INTF(0x12d1, 0x14ac, 1)},	/* Huawei E1820 */
 	{QMI_FIXED_INTF(0x1435, 0xd181, 3)},	/* Wistron NeWeb D18Q1 */


