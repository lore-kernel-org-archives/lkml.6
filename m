Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935105AbeE2PZM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935606AbeE2PXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:23:35 -0400
Message-Id: <20180529152328.804425982@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 29 May 2018 11:23:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasyl Gomonovych <gomonovych@gmail.com>
Subject: [for-next][PATCH 19/19] ring-buffer: Fix typo in comment
References: <20180529152304.885389740@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0019-ring-buffer-Fix-typo-in-comment.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasyl Gomonovych <gomonovych@gmail.com>

Fix typo of the word 'been'

Link: http://lkml.kernel.org/r/20180518203130.2011-1-gomonovych@gmail.com

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index a0233edc0718..b72ebdff0b77 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -65,7 +65,7 @@ u64 ring_buffer_event_time_stamp(struct ring_buffer_event *event);
 
 /*
  * ring_buffer_discard_commit will remove an event that has not
- *   ben committed yet. If this is used, then ring_buffer_unlock_commit
+ *   been committed yet. If this is used, then ring_buffer_unlock_commit
  *   must not be called on the discarded event. This function
  *   will try to remove the event from the ring buffer completely
  *   if another event has not been written after it.
-- 
2.17.0
