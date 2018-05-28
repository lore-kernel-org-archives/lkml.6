Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165360AbeE1NZe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:25:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033690AbeE1KsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:48:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ramon Fried <rfried@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 157/496] qrtr: add MODULE_ALIAS macro to smd
Date: Mon, 28 May 2018 11:59:02 +0200
Message-Id: <20180528100326.499248903@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ramon Fried <rfried@codeaurora.org>

[ Upstream commit c77f5fbbefc04612755117775e8555c2a7006cac ]

Added MODULE_ALIAS("rpmsg:IPCRTR") to ensure qrtr-smd and qrtr will load
when IPCRTR channel is detected.

Signed-off-by: Ramon Fried <rfried@codeaurora.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/qrtr/smd.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/qrtr/smd.c
+++ b/net/qrtr/smd.c
@@ -114,5 +114,6 @@ static struct rpmsg_driver qcom_smd_qrtr
 
 module_rpmsg_driver(qcom_smd_qrtr_driver);
 
+MODULE_ALIAS("rpmsg:IPCRTR");
 MODULE_DESCRIPTION("Qualcomm IPC-Router SMD interface driver");
 MODULE_LICENSE("GPL v2");
