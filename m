Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753988AbeBLUKq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 15:10:46 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46866 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753220AbeBLUKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 15:10:45 -0500
X-Google-Smtp-Source: AH8x226RhcAOb5V5gczvIB4+QM6FPlCV4cRBGm6pdqEV+DZJwf5QQvuHbRYlpodQRvZ20N8kWGou3g==
Date: Mon, 12 Feb 2018 12:10:41 -0800
From: Tejun Heo <tj@kernel.org>
To: Dennis Zhou <dennisszhou@gmail.com>
Cc: Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org
Subject: [PATCH for-4.17] percpu: add Dennis Zhou as a percpu co-maintainer
Message-ID: <20180212201041.GH695913@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dennis rewrote the percpu area allocator some months ago, understands
most of the code base and has been responsive with the bug reports and
questions.  Let's add him as a co-maintainer.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Imma apply this to percpu/for-4.17.  If there's any objection, please
let me know.

Thanks.

 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bdc260..f384e22 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10832,6 +10832,7 @@ F:	drivers/platform/x86/peaq-wmi.c
 PER-CPU MEMORY ALLOCATOR
 M:	Tejun Heo <tj@kernel.org>
 M:	Christoph Lameter <cl@linux.com>
+M:	Dennis Zhou <dennisszhou@gmail.com>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/percpu.git
 S:	Maintained
 F:	include/linux/percpu*.h
