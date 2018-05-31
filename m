Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755700AbeEaQRR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:17:17 -0400
Received: from mail.netline.ch ([148.251.143.178]:37395 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755653AbeEaQRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:17:12 -0400
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: amd-gfx@lists.freedesktop.org
Cc: Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/doc: Add a label for the PRIME Buffer Sharing chapter
Date: Thu, 31 May 2018 18:17:06 +0200
Message-Id: <20180531161708.5894-1-michel@daenzer.net>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michel Dänzer <michel.daenzer@amd.com>

So that it can be referenced from e.g. DOC comments.

Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
---
 Documentation/gpu/drm-mm.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst
index 96ebcc2a7b41..21b6b72a9ba8 100644
--- a/Documentation/gpu/drm-mm.rst
+++ b/Documentation/gpu/drm-mm.rst
@@ -395,6 +395,8 @@ VMA Offset Manager
 .. kernel-doc:: drivers/gpu/drm/drm_vma_manager.c
    :export:
 
+.. _prime_buffer_sharing:
+
 PRIME Buffer Sharing
 ====================
 
-- 
2.17.0
