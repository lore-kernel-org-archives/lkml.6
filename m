Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753369AbeFDOJd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:09:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753019AbeFDOJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:09:31 -0400
Date: Mon, 4 Jun 2018 10:09:31 -0400 (EDT)
From: Bob Peterson <rpeterso@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <1511027539.39786658.1528121371637.JavaMail.zimbra@redhat.com>
In-Reply-To: <707773306.39786540.1528121329531.JavaMail.zimbra@redhat.com>
Subject: [PATCH] MAINTAINERS: Add Andreas Gruenbacher as a maintainer for
 gfs2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.116.15, 10.4.195.13]
Thread-Topic: MAINTAINERS: Add Andreas Gruenbacher as a maintainer for gfs2
Thread-Index: aq34eriYfHeFWJxO1y+ov557HbSH+w==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Andreas Gruenbacher as a maintainer for the gfs2 file system

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b60179d948bb..f369e975c821 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5941,6 +5941,7 @@ F:	scripts/get_maintainer.pl
 GFS2 FILE SYSTEM
 M:	Steven Whitehouse <swhiteho@redhat.com>
 M:	Bob Peterson <rpeterso@redhat.com>
+M:	Andreas Gruenbacher <agruenba@redhat.com>
 L:	cluster-devel@redhat.com
 W:	http://sources.redhat.com/cluster/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
