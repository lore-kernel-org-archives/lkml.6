Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751038AbeBQFs6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 00:48:58 -0500
Received: from mga18.intel.com ([134.134.136.126]:1052 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750951AbeBQFs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 00:48:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,523,1511856000";
   d="scan'208";a="20863314"
From: changbin.du@intel.com
To: corbet@lwn.net, rostedt@goodmis.org
Cc: mingo@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH 00/17] Include linux trace docs to Sphinx TOC tree
Date: Sat, 17 Feb 2018 13:39:33 +0800
Message-Id: <1518845990-20733-1-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

Hi All,
The linux tracers are so useful that I want to make the docs better. The kernel
now uses Sphinx to generate intelligent and beautiful documentation from
reStructuredText files. I converted most of the Linux trace docs to rst format
in this serias.

For you to preview, please visit below url:
http://docservice.askxiong.com/linux-kernel/trace/index.html

Thank you!

Changbin Du (17):
  Documentation: add Linux tracing to Sphinx TOC tree
  trace doc: convert trace/ftrace-design.txt to rst format
  trace doc: add ftrace-uses.rst to doc tree
  trace doc: convert trace/tracepoint-analysis.txt to rst format
  trace doc: convert trace/ftrace.txt to rst format
  trace doc: convert trace/kprobetrace.txt to rst format
  trace doc: convert trace/uprobetracer.txt to rst format
  trace doc: convert trace/tracepoints.txt to rst format
  trace doc: convert trace/events.txt to rst format
  trace doc: convert trace/events-kmem.txt to rst format
  trace doc: convert trace/events-power.txt to rst format
  trace doc: convert trace/events-nmi.txt to rst format
  trace doc: convert trace/events-msr.txt to rst format
  trace doc: convert trace/mmiotrace.txt to rst format
  trace doc: convert trace/hwlat_detector.txt to rst fromat
  trace doc: convert trace/intel_th.txt to rst format
  trace doc: convert trace/stm.txt to rst format

 Documentation/index.rst                            |    1 +
 .../trace/{events-kmem.txt => events-kmem.rst}     |   50 +-
 Documentation/trace/events-msr.rst                 |   40 +
 Documentation/trace/events-msr.txt                 |   37 -
 Documentation/trace/events-nmi.rst                 |   45 +
 Documentation/trace/events-nmi.txt                 |   43 -
 .../trace/{events-power.txt => events-power.rst}   |   52 +-
 Documentation/trace/{events.txt => events.rst}     |  669 ++--
 .../trace/{ftrace-design.txt => ftrace-design.rst} |  252 +-
 Documentation/trace/ftrace-uses.rst                |   23 +-
 Documentation/trace/ftrace.rst                     | 3332 ++++++++++++++++++++
 Documentation/trace/ftrace.txt                     | 3220 -------------------
 .../{hwlat_detector.txt => hwlat_detector.rst}     |   26 +-
 Documentation/trace/index.rst                      |   23 +
 Documentation/trace/{intel_th.txt => intel_th.rst} |   43 +-
 .../trace/{kprobetrace.txt => kprobetrace.rst}     |  100 +-
 .../trace/{mmiotrace.txt => mmiotrace.rst}         |   86 +-
 Documentation/trace/{stm.txt => stm.rst}           |   23 +-
 ...epoint-analysis.txt => tracepoint-analysis.rst} |   41 +-
 .../trace/{tracepoints.txt => tracepoints.rst}     |   77 +-
 .../trace/{uprobetracer.txt => uprobetracer.rst}   |   44 +-
 21 files changed, 4237 insertions(+), 3990 deletions(-)
 rename Documentation/trace/{events-kmem.txt => events-kmem.rst} (76%)
 create mode 100644 Documentation/trace/events-msr.rst
 delete mode 100644 Documentation/trace/events-msr.txt
 create mode 100644 Documentation/trace/events-nmi.rst
 delete mode 100644 Documentation/trace/events-nmi.txt
 rename Documentation/trace/{events-power.txt => events-power.rst} (65%)
 rename Documentation/trace/{events.txt => events.rst} (82%)
 rename Documentation/trace/{ftrace-design.txt => ftrace-design.rst} (74%)
 create mode 100644 Documentation/trace/ftrace.rst
 delete mode 100644 Documentation/trace/ftrace.txt
 rename Documentation/trace/{hwlat_detector.txt => hwlat_detector.rst} (83%)
 create mode 100644 Documentation/trace/index.rst
 rename Documentation/trace/{intel_th.txt => intel_th.rst} (82%)
 rename Documentation/trace/{kprobetrace.txt => kprobetrace.rst} (63%)
 rename Documentation/trace/{mmiotrace.txt => mmiotrace.rst} (78%)
 rename Documentation/trace/{stm.txt => stm.rst} (91%)
 rename Documentation/trace/{tracepoint-analysis.txt => tracepoint-analysis.rst} (93%)
 rename Documentation/trace/{tracepoints.txt => tracepoints.rst} (74%)
 rename Documentation/trace/{uprobetracer.txt => uprobetracer.rst} (86%)

-- 
2.7.4
