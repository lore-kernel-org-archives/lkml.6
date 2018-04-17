Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753412AbeDQMxW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:53:22 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:29621 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753370AbeDQMxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:53:18 -0400
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=flawful.org
Date: Tue, 17 Apr 2018 14:53:08 +0200
From: Niklas Cassel <nks@flawful.org>
To: arm@kernel.org
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@axis.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Remove myself as maintainer
Message-ID: <20180417125308.GA30884@flawful.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@axis.com>

I am leaving Axis, so this address will bounce in the not too
distant future.

Fortunately, I will still be working with the community.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
Hello arm-soc, could you please pick this up?
The email address has started to bounce.

Kind regards,
Niklas

 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42b10dc55a49..71fa4312cc36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1208,7 +1208,6 @@ F:	drivers/*/*alpine*
 ARM/ARTPEC MACHINE SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
 M:	Lars Persson <lars.persson@axis.com>
-M:	Niklas Cassel <niklas.cassel@axis.com>
 S:	Maintained
 L:	linux-arm-kernel@axis.com
 F:	arch/arm/mach-artpec
@@ -10893,7 +10892,6 @@ F:	drivers/pci/host/
 F:	drivers/pci/dwc/
 
 PCIE DRIVER FOR AXIS ARTPEC
-M:	Niklas Cassel <niklas.cassel@axis.com>
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
 L:	linux-arm-kernel@axis.com
 L:	linux-pci@vger.kernel.org
-- 
2.14.3
