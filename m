Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753564AbeFDOgY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:36:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753297AbeFDOgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:36:23 -0400
Date: Mon, 4 Jun 2018 10:36:22 -0400 (EDT)
From: Bob Peterson <rpeterso@redhat.com>
To: cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <819640525.39798623.1528122982163.JavaMail.zimbra@redhat.com>
In-Reply-To: <1852682163.39798530.1528122945967.JavaMail.zimbra@redhat.com>
Subject: [PATCH v2] MAINTAINERS: Add Andreas Gruenbacher as a maintainer for
 gfs2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.116.15, 10.4.195.4]
Thread-Topic: MAINTAINERS: Add Andreas Gruenbacher as a maintainer for gfs2
Thread-Index: jKPdqXx4I1pBA1mBM84hkIz3anlcWw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Andreas Gruenbacher as a maintainer for the gfs2 file system
and remove Steve Whitehouse.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b60179d948bb..73745884a595 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5939,8 +5939,8 @@ S:	Maintained
 F:	scripts/get_maintainer.pl
 
 GFS2 FILE SYSTEM
-M:	Steven Whitehouse <swhiteho@redhat.com>
 M:	Bob Peterson <rpeterso@redhat.com>
+M:	Andreas Gruenbacher <agruenba@redhat.com>
 L:	cluster-devel@redhat.com
 W:	http://sources.redhat.com/cluster/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
