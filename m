Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbeCUQDq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 12:03:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:59576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751416AbeCUQDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 12:03:41 -0400
From: Takashi Iwai <tiwai@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] trace-cmd: Documentation: Fix title markers
Date: Wed, 21 Mar 2018 17:03:34 +0100
Message-Id: <20180321160334.16050-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the title markers that aren't aligned with the previous lines.
This was caught by processing via asciidoctor, which is picker than
asciidoc and aborts as an error.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/trace-cmd-extract.1.txt  | 2 +-
 Documentation/trace-cmd-hist.1.txt     | 2 +-
 Documentation/trace-cmd-list.1.txt     | 2 +-
 Documentation/trace-cmd-listen.1.txt   | 2 +-
 Documentation/trace-cmd-mem.1.txt      | 2 +-
 Documentation/trace-cmd-options.1.txt  | 2 +-
 Documentation/trace-cmd-profile.1.txt  | 2 +-
 Documentation/trace-cmd-show.1.txt     | 2 +-
 Documentation/trace-cmd-snapshot.1.txt | 2 +-
 Documentation/trace-cmd-start.1.txt    | 2 +-
 Documentation/trace-cmd-stat.1.txt     | 2 +-
 Documentation/trace-cmd-stop.1.txt     | 2 +-
 Documentation/trace-cmd.dat.5.txt      | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/trace-cmd-extract.1.txt b/Documentation/trace-cmd-extract.1.txt
index 73eda4ed235d..917a63718b3b 100644
--- a/Documentation/trace-cmd-extract.1.txt
+++ b/Documentation/trace-cmd-extract.1.txt
@@ -1,5 +1,5 @@
 TRACE-CMD-EXTRACT(1)
-===================
+====================
 
 NAME
 ----
diff --git a/Documentation/trace-cmd-hist.1.txt b/Documentation/trace-cmd-hist.1.txt
index 96a5b8216202..b17936d0f612 100644
--- a/Documentation/trace-cmd-hist.1.txt
+++ b/Documentation/trace-cmd-hist.1.txt
@@ -1,5 +1,5 @@
 TRACE-CMD-HIST(1)
-==================
+=================
 
 NAME
 ----
diff --git a/Documentation/trace-cmd-list.1.txt b/Documentation/trace-cmd-list.1.txt
index a83c001c698e..ea6bd86bc317 100644
--- a/Documentation/trace-cmd-list.1.txt
+++ b/Documentation/trace-cmd-list.1.txt
@@ -1,5 +1,5 @@
 TRACE-CMD-LIST(1)
-==================
+=================
 
 NAME
 ----
diff --git a/Documentation/trace-cmd-listen.1.txt b/Documentation/trace-cmd-listen.1.txt
index c9bafcd9fd70..a242c49edfbe 100644
--- a/Documentation/trace-cmd-listen.1.txt
+++ b/Documentation/trace-cmd-listen.1.txt
@@ -1,5 +1,5 @@
 TRACE-CMD-LISTEN(1)
-==================
+===================
 
 NAME
 ----
diff --git a/Documentation/trace-cmd-mem.1.txt b/Documentation/trace-cmd-mem.1.txt
index 3f4a7ca6a316..9e811b91eea0 100644
--- a/Documentation/trace-cmd-mem.1.txt
+++ b/Documentation/trace-cmd-mem.1.txt
@@ -1,5 +1,5 @@
 TRACE-CMD-MEM(1)
-==================
+================
 
 NAME
 ----
diff --git a/Documentation/trace-cmd-options.1.txt b/Documentation/trace-cmd-options.1.txt
index 23735540e5ea..e7faf320a5da 100644
--- a/Documentation/trace-cmd-options.1.txt
+++ b/Documentation/trace-cmd-options.1.txt
@@ -1,5 +1,5 @@
 TRACE-CMD-OPTIONS(1)
-===================
+====================
 
 NAME
 ----
diff --git a/Documentation/trace-cmd-profile.1.txt b/Documentation/trace-cmd-profile.1.txt
index f0fa30eedc61..3ffce86b803d 100644
--- a/Documentation/trace-cmd-profile.1.txt
+++ b/Documentation/trace-cmd-profile.1.txt
@@ -1,5 +1,5 @@
 TRACE-CMD-PROFILE(1)
-===================
+====================
 
 NAME
 ----
diff --git a/Documentation/trace-cmd-show.1.txt b/Documentation/trace-cmd-show.1.txt
index 046c06717447..b17851ef5c80 100644
--- a/Documentation/trace-cmd-show.1.txt
+++ b/Documentation/trace-cmd-show.1.txt
@@ -1,5 +1,5 @@
 TRACE-CMD-SHOW(1)
-===================
+=================
 
 NAME
 ----
diff --git a/Documentation/trace-cmd-snapshot.1.txt b/Documentation/trace-cmd-snapshot.1.txt
index 98b8924dca9d..6d94ada033b1 100644
--- a/Documentation/trace-cmd-snapshot.1.txt
+++ b/Documentation/trace-cmd-snapshot.1.txt
@@ -1,5 +1,5 @@
 TRACE-CMD-SNAPSHOT(1)
-===================
+=====================
 
 NAME
 ----
diff --git a/Documentation/trace-cmd-start.1.txt b/Documentation/trace-cmd-start.1.txt
index 3264abf1ca00..2b027b01be35 100644
--- a/Documentation/trace-cmd-start.1.txt
+++ b/Documentation/trace-cmd-start.1.txt
@@ -1,5 +1,5 @@
 TRACE-CMD-START(1)
-===================
+==================
 
 NAME
 ----
diff --git a/Documentation/trace-cmd-stat.1.txt b/Documentation/trace-cmd-stat.1.txt
index 7e4263ea149d..4a29b143122c 100644
--- a/Documentation/trace-cmd-stat.1.txt
+++ b/Documentation/trace-cmd-stat.1.txt
@@ -1,5 +1,5 @@
 TRACE-CMD-STAT(1)
-==================
+=================
 
 NAME
 ----
diff --git a/Documentation/trace-cmd-stop.1.txt b/Documentation/trace-cmd-stop.1.txt
index 9d4093ee503c..1955fa7140b1 100644
--- a/Documentation/trace-cmd-stop.1.txt
+++ b/Documentation/trace-cmd-stop.1.txt
@@ -1,5 +1,5 @@
 TRACE-CMD-STOP(1)
-===================
+=================
 
 NAME
 ----
diff --git a/Documentation/trace-cmd.dat.5.txt b/Documentation/trace-cmd.dat.5.txt
index 4d0cce5aa4a6..d849439bb3c7 100644
--- a/Documentation/trace-cmd.dat.5.txt
+++ b/Documentation/trace-cmd.dat.5.txt
@@ -1,5 +1,5 @@
 TRACE-CMD.DAT(5)
-===============
+================
 
 NAME
 ----
-- 
2.16.2
