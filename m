Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbeBBJNc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 04:13:32 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38555 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeBBJNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 04:13:22 -0500
X-Google-Smtp-Source: AH8x225P3UQ6kafPa7yczV1qcxbFAAw+/XxD9EWsaEsstjd/8QAq4mAZghAO6VbDOSV7an9xlfRV6g==
From: Andrea Parri <parri.andrea@gmail.com>
To: corbet@lwn.net, dhowells@redhat.com, paulmck@linux.vnet.ibm.com,
        will.deacon@arm.com, peterz@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        stern@rowland.harvard.edu, boqun.feng@gmail.com, npiggin@gmail.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH 1/2] Documentation/memory-barriers.txt: cross-reference "tools/memory-model/"
Date: Fri,  2 Feb 2018 10:12:48 +0100
Message-Id: <1517562768-6238-1-git-send-email-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent efforts led to the specification of a memory consistency model
for the Linux kernel [1], which "can (roughly speaking) be thought of
as an automated version of memory-barriers.txt" and which is (in turn)
"accompanied by extensive documentation on its use and its design".

Make sure that the (occasional) reader of memory-barriers.txt will be
aware of these developments.

[1] https://marc.info/?l=linux-kernel&m=151687290114799&w=2

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 Documentation/memory-barriers.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index a863009849a3b..8cc3f098f4a7d 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -17,7 +17,9 @@ meant as a guide to using the various memory barriers provided by Linux, but
 in case of any doubt (and there are many) please ask.
 
 To repeat, this document is not a specification of what Linux expects from
-hardware.
+hardware.  For such a specification, in the form of a memory consistency
+model, and for documentation about its usage and its design, the reader is
+referred to "tools/memory-model/".
 
 The purpose of this document is twofold:
 
-- 
2.7.4
