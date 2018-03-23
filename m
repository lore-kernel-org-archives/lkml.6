Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbeCWHdB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 03:33:01 -0400
Received: from mout01.posteo.de ([185.67.36.65]:56765 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751303AbeCWHc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 03:32:59 -0400
From: Martin Kepplinger <martink@posteo.de>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] Documentation: magic-numbers: Fix typo
Date: Fri, 23 Mar 2018 08:32:31 +0100
Message-Id: <20180323073231.5826-1-martink@posteo.de>
X-Mailer: git-send-email 2.14.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a little then / them confusion.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 Documentation/process/magic-number.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process/magic-number.rst
index c74199f60c6c..00cecf1fcba9 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -14,7 +14,7 @@ passing pointers to structures via a void * pointer.  The tty code,
 for example, does this frequently to pass driver-specific and line
 discipline-specific structures back and forth.
 
-The way to use magic numbers is to declare then at the beginning of
+The way to use magic numbers is to declare them at the beginning of
 the structure, like so::
 
 	struct tty_ldisc {
-- 
2.14.2
