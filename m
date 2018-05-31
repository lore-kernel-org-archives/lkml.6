Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755743AbeEaQRX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:17:23 -0400
Received: from mail.netline.ch ([148.251.143.178]:37398 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755650AbeEaQRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:17:12 -0400
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: amd-gfx@lists.freedesktop.org
Cc: Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm/doc: Add initial amdgpu driver documentation
Date: Thu, 31 May 2018 18:17:07 +0200
Message-Id: <20180531161708.5894-2-michel@daenzer.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180531161708.5894-1-michel@daenzer.net>
References: <20180531161708.5894-1-michel@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michel Dänzer <michel.daenzer@amd.com>

Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
---
 Documentation/gpu/amdgpu.rst  | 6 ++++++
 Documentation/gpu/drivers.rst | 1 +
 2 files changed, 7 insertions(+)
 create mode 100644 Documentation/gpu/amdgpu.rst

diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
new file mode 100644
index 000000000000..41a14e4aa4ac
--- /dev/null
+++ b/Documentation/gpu/amdgpu.rst
@@ -0,0 +1,6 @@
+=========================
+ drm/amdgpu AMDgpu driver
+=========================
+
+The drm/amdgpu driver supports all AMD Radeon GPUs based on the Graphics Core
+Next (GCN) architecture.
diff --git a/Documentation/gpu/drivers.rst b/Documentation/gpu/drivers.rst
index e8c84419a2a1..604b6d6975af 100644
--- a/Documentation/gpu/drivers.rst
+++ b/Documentation/gpu/drivers.rst
@@ -4,6 +4,7 @@ GPU Driver Documentation
 
 .. toctree::
 
+   amdgpu
    i915
    meson
    pl111
-- 
2.17.0
