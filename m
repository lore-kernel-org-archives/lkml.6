Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752813AbeDFNO4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:14:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:9994 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752296AbeDFNOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:14:55 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,415,1517904000";
   d="scan'208";a="41202841"
Date: Fri, 6 Apr 2018 21:14:15 +0800
From: "Liu, Changcheng" <changcheng.liu@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: [PATCH] dts: remove cris & metag dts hard link file
Message-ID: <20180406131415.GA32103@sofia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch cris & metag have been removed from supported archs.
The dts hard link files should also be removed, or the ctags
tool will give warning.

execute"ctags -R", output:
ctags: Warning: cannot open source file
"scripts/dtc/include-prefixes/cris" : No such file or directory
ctags: Warning: cannot open source file
"scripts/dtc/include-prefixes/metag" : No such file or directory

Signed-off-by: Liu Changcheng <changcheng.liu@intel.com>

diff --git a/scripts/dtc/include-prefixes/cris b/scripts/dtc/include-prefixes/cris
deleted file mode 120000
index 736d998..0000000
--- a/scripts/dtc/include-prefixes/cris
+++ /dev/null
@@ -1 +0,0 @@
-../../../arch/cris/boot/dts
\ No newline at end of file
diff --git a/scripts/dtc/include-prefixes/metag b/scripts/dtc/include-prefixes/metag
deleted file mode 120000
index 87a3c84..0000000
--- a/scripts/dtc/include-prefixes/metag
+++ /dev/null
@@ -1 +0,0 @@
-../../../arch/metag/boot/dts
\ No newline at end of file
-- 
2.7.4
