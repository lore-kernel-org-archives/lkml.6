Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933220AbeCSLct (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 07:32:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38732 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932917AbeCSLcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 07:32:41 -0400
X-Google-Smtp-Source: AG47ELtMuEqM3+5KA+Lq15pzbRrsEYx2B88fD5v/xigQ0zX1Pj2dK9d3lB0BqUpFDPqOwALbmpK5Gw==
From: Paul McQuade <paulmcquad@gmail.com>
To: paulmcquad@gmail.com
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Use tabs where possible
Date: Mon, 19 Mar 2018 11:32:20 +0000
Message-Id: <20180319113222.6725-2-paulmcquad@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319113222.6725-1-paulmcquad@gmail.com>
References: <20180319113222.6725-1-paulmcquad@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

code indent should use tabs where possible

Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
---
 drivers/bluetooth/hci_intel.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 7c166e3b308b..2a7bdc0bad92 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -609,12 +609,12 @@ static int intel_setup(struct hci_uart *hu)
 		return -EINVAL;
 	}
 
-        /* Check for supported iBT hardware variants of this firmware
-         * loading method.
-         *
-         * This check has been put in place to ensure correct forward
-         * compatibility options when newer hardware variants come along.
-         */
+	/* Check for supported iBT hardware variants of this firmware
+	 * loading method.
+	 *
+	 * This check has been put in place to ensure correct forward
+	 * compatibility options when newer hardware variants come along.
+	 */
 	switch (ver.hw_variant) {
 	case 0x0b:	/* LnP */
 	case 0x0c:	/* WsP */
-- 
2.16.2
