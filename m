Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030787AbeEXRow (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:44:52 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40505 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030394AbeEXRos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:44:48 -0400
X-Google-Smtp-Source: AB8JxZofkcfb+gIkPUl7A+PehKjKz79YxsrhEagUM8Xnp+ifI4sYjqkvcrOkKyoRXrjqfFOShDcRDQ==
Date: Thu, 24 May 2018 23:14:40 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
To: Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: comedi: comedidev.h: Fix SPDX-License-Identifier
 tag style
Message-ID: <20180524174436.GA10724@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace // SPDX-License-Identifier: GPL-2.0+ by
/* SPDX-License-Identifier: GPL-2.0+ */ as per licensing rule
for C header files. Issue found by checkpatch. Part of
Eudyptula Challenge.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/comedi/comedidev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/comedidev.h b/drivers/staging/comedi/comedidev.h
index f3474a4ba69e..c54ac94d89d2 100644
--- a/drivers/staging/comedi/comedidev.h
+++ b/drivers/staging/comedi/comedidev.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * comedidev.h
  * header file for kernel-only structures, variables, and constants
-- 
2.17.0
