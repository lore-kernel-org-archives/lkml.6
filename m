Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751386AbeFDSsj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:48:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751104AbeFDSsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:48:37 -0400
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@intel.com>
Subject: [PATCH 2/2] MAINTAINERS: add Josh Poimboeuf as faddr2line maintainer
Date: Mon,  4 Jun 2018 13:48:32 -0500
Message-Id: <2065a1d018fa6363cec67976269c1db4ad4d1854.1528137452.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1528137452.git.jpoimboe@redhat.com>
References: <cover.1528137452.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... so I finally get credit for my greatest accomplishment.

And, less importantly, so get_maintainer.pl will actually CC me on
future patches.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ca4afd68530c..93f55753142a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5413,6 +5413,11 @@ S:	Maintained
 F:	Documentation/hwmon/f71805f
 F:	drivers/hwmon/f71805f.c
 
+FADDR2LINE
+M:	Josh Poimboeuf <jpoimboe@redhat.com>
+S:	Maintained
+F:	scripts/faddr2line
+
 FANOTIFY
 M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
-- 
2.17.0
