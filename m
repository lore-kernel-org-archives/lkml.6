Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbeCZTmc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 15:42:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751024AbeCZTmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 15:42:31 -0400
Subject: [PATCH] MAINTAINERS: vfio/platform: Update sub-maintainer
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        eric.auger@redhat.com, a.rigo@virtualopensystems.com
Date: Mon, 26 Mar 2018 13:42:02 -0600
Message-ID: <20180326194121.10256.27009.stgit@gimli.home>
User-Agent: StGit/0.18-102-gdf9f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baptiste has changed positions and has not been active with
vfio-platform, replace with the current, de-facto sub-maintainer
Eric Auger.  Also add Alvise Rigo as a designated reviewer.

Cc: Eric Auger <eric.auger@redhat.com>
Cc: Alvise Rigo <a.rigo@virtualopensystems.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 MAINTAINERS |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 205c8fc12a9c..c6680c189f2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14687,7 +14687,8 @@ F:	include/linux/mdev.h
 F:	samples/vfio-mdev/
 
 VFIO PLATFORM DRIVER
-M:	Baptiste Reynal <b.reynal@virtualopensystems.com>
+M:	Eric Auger <eric.auger@redhat.com>
+R:	Alvise Rigo <a.rigo@virtualopensystems.com>
 L:	kvm@vger.kernel.org
 S:	Maintained
 F:	drivers/vfio/platform/
