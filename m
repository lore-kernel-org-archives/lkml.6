Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754028AbeBST5G (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 14:57:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44758 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753711AbeBSTqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 14:46:18 -0500
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 31/61] page cache: Remove stray radix comment
Date: Mon, 19 Feb 2018 11:45:26 -0800
Message-Id: <20180219194556.6575-32-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180219194556.6575-1-willy@infradead.org>
References: <20180219194556.6575-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 49effa6301b9..3735ea6e3d19 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2605,7 +2605,7 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 			put_page(page);
 			if (err == -EEXIST)
 				goto repeat;
-			/* Presumably ENOMEM for radix tree node */
+			/* Presumably ENOMEM for xarray node */
 			return ERR_PTR(err);
 		}
 
-- 
2.16.1
