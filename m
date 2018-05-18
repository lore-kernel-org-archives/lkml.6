Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbeERUc2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 16:32:28 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37670 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbeERUcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 16:32:25 -0400
X-Google-Smtp-Source: AB8JxZq511jw0ljVG6lhY4R5W9k6tJzdLaZ1+0bZpE1YnMdin+EaofRC7k2CAYspyDMUJFyFRuK0bw==
From: Vasyl Gomonovych <gomonovych@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Vasyl Gomonovych <gomonovych@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] ring-buffer: Fix typo in comment
Date: Fri, 18 May 2018 22:31:28 +0200
Message-Id: <20180518203130.2011-1-gomonovych@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in the words 'reserved', 'been'

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
 include/linux/ring_buffer.h | 2 +-
 kernel/trace/ring_buffer.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 7d9eb39fa76a..aa500da87f2a 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -63,7 +63,7 @@ void *ring_buffer_event_data(struct ring_buffer_event *event);
 
 /*
  * ring_buffer_discard_commit will remove an event that has not
- *   ben committed yet. If this is used, then ring_buffer_unlock_commit
+ *   been committed yet. If this is used, then ring_buffer_unlock_commit
  *   must not be called on the discarded event. This function
  *   will try to remove the event from the ring buffer completely
  *   if another event has not been written after it.
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index dcf1c4dd3efe..a8a8eb23c489 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2776,7 +2776,7 @@ rb_reserve_next_event(struct ring_buffer *buffer,
  * @buffer: the ring buffer to reserve from
  * @length: the length of the data to reserve (excluding event header)
  *
- * Returns a reseverd event on the ring buffer to copy directly to.
+ * Returns a reserved event on the ring buffer to copy directly to.
  * The user of this interface will need to get the body to write into
  * and can use the ring_buffer_event_data() interface.
  *
-- 
2.14.1
