Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbeC0MFV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:05:21 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:32845 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752309AbeC0MFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:05:18 -0400
From: michaelsh@mellanox.com
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Shych <michaelsh@mellanox.com>
Subject: [PATCH v1 - resent 5/5] i2c: busses: Add capability register description to documentation
Date: Tue, 27 Mar 2018 14:01:26 +0000
Message-Id: <1522159286-41779-6-git-send-email-michaelsh@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1522159286-41779-1-git-send-email-michaelsh@mellanox.com>
References: <1522159286-41779-1-git-send-email-michaelsh@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Shych <michaelsh@mellanox.com>

It adds capability register description to documentation.

Signed-off-by: Michael Shych <michaelsh@mellanox.com>
---
 Documentation/i2c/busses/i2c-mlxcpld | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/i2c/busses/i2c-mlxcpld b/Documentation/i2c/busses/i2c-mlxcpld
index 4e46c44..925904a 100644
--- a/Documentation/i2c/busses/i2c-mlxcpld
+++ b/Documentation/i2c/busses/i2c-mlxcpld
@@ -20,6 +20,10 @@ The next transaction types are supported:
  - Write Byte/Block.
 
 Registers:
+CPBLTY		0x0 - capability reg.
+			Bits [6:5] - transaction length. b01 - 72B is supported,
+			36B in other case.
+			Bit 7 - SMBus block read support.
 CTRL		0x1 - control reg.
 			Resets all the registers.
 HALF_CYC	0x4 - cycle reg.
-- 
2.1.4
