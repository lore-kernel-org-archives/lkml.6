Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422777AbeBPAG0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 19:06:26 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39918 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752900AbeBPAGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 19:06:24 -0500
X-Google-Smtp-Source: AH8x225AFn5LZCCuJWgtWCp8aQzQKBmMVhD6VlaD4/lkp9ZDJIMW2XNAY8aVrmMYGjaN9Lbk7NjUXw==
From: Minghui Liu <minghui.liu.95@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: [PATCH] Documentation: Delete reference to the kernel-mentors mailing
 list because the mailing list no longer exists
Message-Id: <2CD1322F-1638-4591-81B9-595B7EC73327@gmail.com>
Date: Thu, 15 Feb 2018 16:05:37 -0800
Cc: sj38.park@gmail.com, mchehab@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org
To: corbet@lwn.net
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1G06U2t025911

>From 2e4a473973a3b2dd841dc73523766c45f990acb5 Mon Sep 17 00:00:00 2001
From: Minghui Liu <minghui.liu.95@gmail.com>
Date: Thu, 15 Feb 2018 18:33:14 -0500
Subject: [PATCH] Documentation: Delete reference to the kernel-mentors mailing
 list because the mailing list no longer exists

Signed-off-by: Minghui Liu <minghui.liu.95@gmail.com>
---
 Documentation/process/howto.rst | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index c6875b1..bcd8d1e 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -213,13 +213,6 @@ will learn the basics of getting your patch into the Linux kernel tree,
 and possibly be pointed in the direction of what to go work on next, if
 you do not already have an idea.
 
-If you already have a chunk of code that you want to put into the kernel
-tree, but need some help getting it in the proper form, the
-kernel-mentors project was created to help you out with this.  It is a
-mailing list, and can be found at:
-
-	https://selenic.com/mailman/listinfo/kernel-mentors
-
 Before making any actual modifications to the Linux kernel code, it is
 imperative to understand how the code in question works.  For this
 purpose, nothing is better than reading through it directly (most tricky
-- 
1.8.3.1
