Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752285AbeEPXub (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 19:50:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752244AbeEPXu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 19:50:29 -0400
From: Alan Tull <atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Alan Tull <atull@kernel.org>
Subject: [PATCH 14/14] MAINTAINERS: Add driver-api/fpga path
Date: Wed, 16 May 2018 18:50:07 -0500
Message-Id: <20180516235007.3951-15-atull@kernel.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180516235007.3951-1-atull@kernel.org>
References: <20180516235007.3951-1-atull@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Documentation/driver-api/fpga path to MAINTAINERS file
for fpga.

Signed-off-by: Alan Tull <atull@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ce5062..febeecd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5612,6 +5612,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/atull/linux-fpga.git
 Q:	http://patchwork.kernel.org/project/linux-fpga/list/
 F:	Documentation/fpga/
+F:	Documentation/driver-api/fpga/
 F:	Documentation/devicetree/bindings/fpga/
 F:	drivers/fpga/
 F:	include/linux/fpga/
-- 
2.7.4
