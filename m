Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbeEPXw2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 19:52:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752174AbeEPXuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 19:50:22 -0400
From: Alan Tull <atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Alan Tull <atull@kernel.org>
Subject: [PATCH 07/14] fpga: bridge: kernel-doc fixes
Date: Wed, 16 May 2018 18:50:00 -0500
Message-Id: <20180516235007.3951-8-atull@kernel.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180516235007.3951-1-atull@kernel.org>
References: <20180516235007.3951-1-atull@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warnings when documentation is built:

./drivers/fpga/fpga-bridge.c:143: warning: Function parameter or
member 'info' not described in 'fpga_bridge_get'

./drivers/fpga/fpga-bridge.c:1: warning: no structured comments found

Signed-off-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/fpga-bridge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 164eb55..4b207a7 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -121,6 +121,7 @@ static int fpga_bridge_dev_match(struct device *dev, const void *data)
 /**
  * fpga_bridge_get - get an exclusive reference to a fpga bridge
  * @dev:	parent device that fpga bridge was registered with
+ * @info:	fpga manager info
  *
  * Given a device, get an exclusive reference to a fpga bridge.
  *
-- 
2.7.4
