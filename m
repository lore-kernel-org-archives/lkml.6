Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeERHuC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:50:02 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39269 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752080AbeERHt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:49:56 -0400
X-Google-Smtp-Source: AB8JxZpExxK+J03YuAaRzW4xnOQPgmXAdZ8Z2j3INDMSvihqPo6LfuNYbRLIr9cdN1mIB2o6rUN/Jg==
From: Kent Overstreet <kent.overstreet@gmail.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        viro@zeniv.linux.org.uk, willy@infradead.org, peterz@infradead.org
Subject: [PATCH 02/10] mm: export find_get_pages()
Date: Fri, 18 May 2018 03:49:02 -0400
Message-Id: <20180518074918.13816-5-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518074918.13816-1-kent.overstreet@gmail.com>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 mm/filemap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 31dd888785..78b99019bf 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1845,6 +1845,7 @@ unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 
 	return ret;
 }
+EXPORT_SYMBOL(find_get_pages_range);
 
 /**
  * find_get_pages_contig - gang contiguous pagecache lookup
-- 
2.17.0
