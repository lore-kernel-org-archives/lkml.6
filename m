Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759156AbeD1RIC (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 13:08:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:37411 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758246AbeD1RHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 13:07:52 -0400
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org,
        Martin Steigerwald <martin@lichtvoll.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH] MAINTAINERS: add myself as maintainer of AFFS
Date: Sat, 28 Apr 2018 19:05:04 +0200
Message-Id: <20180428170504.16031-1-dsterba@suse.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AFFS filesystem is still in use by m68k community (Link #2), but as
there was no code activity and no maintainer, the filesystem appeared on
the list of candidates for staging/removal (Link #1).

I volunteer to act as a maintainer of AFFS to collect any fixes that
might show up and to guard fs/affs/ against another spring cleaning.

Link: https://lkml.kernel.org/r/20180425154602.GA8546@bombadil.infradead.org
Link: https://lkml.kernel.org/r/1613268.lKBQxPXt8J@merkaba
CC: Martin Steigerwald <martin@lichtvoll.de>
CC: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd66ae9a847e..9d268895bd56 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -564,8 +564,10 @@ S:	Maintained
 F:	drivers/media/dvb-frontends/af9033*
 
 AFFS FILE SYSTEM
+M:	David Sterba <dsterba@suse.com>
 L:	linux-fsdevel@vger.kernel.org
-S:	Orphan
+S:	Odd Fixes
 F:	Documentation/filesystems/affs.txt
 F:	fs/affs/
 
-- 
2.16.2
