Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757402AbeBPDVT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 22:21:19 -0500
Received: from mga18.intel.com ([134.134.136.126]:1689 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757381AbeBPDVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 22:21:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="18576195"
From: changbin.du@intel.com
To: corbet@lwn.net, rostedt@goodmis.org, mingo@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@intel.com>
Subject: [RFC PATCH 0/3] Include linux trace docs to Sphinx TOC tree
Date: Fri, 16 Feb 2018 11:12:16 +0800
Message-Id: <1518750739-12514-1-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

Hi All,
The linux tracers are so useful that I want to make the docs better. The kernel
now uses Sphinx to generate intelligent and beautiful documentation from
reStructuredText files. I converted two trace docs for your to preview.

http://docservice.askxiong.com/linux-kernel/trace/index.html

If this looks good then I will do reset rest docs for trace. Please give
feedbacks. Thank you!

Changbin Du (3):
  Documentation: add tracing to Sphinx TOC tree
  Documentation: convert trace/ftrace-design.txt to rst format
  Documentation: add ftrace-uses.rst to doc tree

 Documentation/index.rst                            |   1 +
 .../trace/{ftrace-design.txt => ftrace-design.rst} | 248 +++++++++++----------
 Documentation/trace/ftrace-uses.rst                |  23 +-
 Documentation/trace/index.rst                      |   9 +
 4 files changed, 157 insertions(+), 124 deletions(-)
 rename Documentation/trace/{ftrace-design.txt => ftrace-design.rst} (75%)
 create mode 100644 Documentation/trace/index.rst

-- 
2.7.4
