Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbeB0JnU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 04:43:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:28702 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751117AbeB0JnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 04:43:19 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,400,1515484800";
   d="scan'208";a="30973621"
Date: Tue, 27 Feb 2018 17:34:22 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: changbin.du@intel.com
Cc: corbet@lwn.net, rostedt@goodmis.org, mingo@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] Include linux trace docs to Sphinx TOC tree
Message-ID: <20180227093421.yd674oaklthaljgh@intel.com>
References: <1518845990-20733-1-git-send-email-changbin.du@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518845990-20733-1-git-send-email-changbin.du@intel.com>
User-Agent: NeoMutt/20171027-42-ad8712
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steven and Corbet,
Ten days past, will you accept this serias? Thank you!

On Sat, Feb 17, 2018 at 01:39:33PM +0800, changbin.du@intel.com wrote:
> From: Changbin Du <changbin.du@intel.com>
> 
> Hi All,
> The linux tracers are so useful that I want to make the docs better. The kernel
> now uses Sphinx to generate intelligent and beautiful documentation from
> reStructuredText files. I converted most of the Linux trace docs to rst format
> in this serias.
> 
> For you to preview, please visit below url:
> http://docservice.askxiong.com/linux-kernel/trace/index.html
> 
> Thank you!
> 
> Changbin Du (17):
>   Documentation: add Linux tracing to Sphinx TOC tree
>   trace doc: convert trace/ftrace-design.txt to rst format
>   trace doc: add ftrace-uses.rst to doc tree
>   trace doc: convert trace/tracepoint-analysis.txt to rst format
>   trace doc: convert trace/ftrace.txt to rst format
>   trace doc: convert trace/kprobetrace.txt to rst format
>   trace doc: convert trace/uprobetracer.txt to rst format
>   trace doc: convert trace/tracepoints.txt to rst format
>   trace doc: convert trace/events.txt to rst format
>   trace doc: convert trace/events-kmem.txt to rst format
>   trace doc: convert trace/events-power.txt to rst format
>   trace doc: convert trace/events-nmi.txt to rst format
>   trace doc: convert trace/events-msr.txt to rst format
>   trace doc: convert trace/mmiotrace.txt to rst format
>   trace doc: convert trace/hwlat_detector.txt to rst fromat
>   trace doc: convert trace/intel_th.txt to rst format
>   trace doc: convert trace/stm.txt to rst format
> 
>  Documentation/index.rst                            |    1 +
>  .../trace/{events-kmem.txt => events-kmem.rst}     |   50 +-
>  Documentation/trace/events-msr.rst                 |   40 +
>  Documentation/trace/events-msr.txt                 |   37 -
>  Documentation/trace/events-nmi.rst                 |   45 +
>  Documentation/trace/events-nmi.txt                 |   43 -
>  .../trace/{events-power.txt => events-power.rst}   |   52 +-
>  Documentation/trace/{events.txt => events.rst}     |  669 ++--
>  .../trace/{ftrace-design.txt => ftrace-design.rst} |  252 +-
>  Documentation/trace/ftrace-uses.rst                |   23 +-
>  Documentation/trace/ftrace.rst                     | 3332 ++++++++++++++++++++
>  Documentation/trace/ftrace.txt                     | 3220 -------------------
>  .../{hwlat_detector.txt => hwlat_detector.rst}     |   26 +-
>  Documentation/trace/index.rst                      |   23 +
>  Documentation/trace/{intel_th.txt => intel_th.rst} |   43 +-
>  .../trace/{kprobetrace.txt => kprobetrace.rst}     |  100 +-
>  .../trace/{mmiotrace.txt => mmiotrace.rst}         |   86 +-
>  Documentation/trace/{stm.txt => stm.rst}           |   23 +-
>  ...epoint-analysis.txt => tracepoint-analysis.rst} |   41 +-
>  .../trace/{tracepoints.txt => tracepoints.rst}     |   77 +-
>  .../trace/{uprobetracer.txt => uprobetracer.rst}   |   44 +-
>  21 files changed, 4237 insertions(+), 3990 deletions(-)
>  rename Documentation/trace/{events-kmem.txt => events-kmem.rst} (76%)
>  create mode 100644 Documentation/trace/events-msr.rst
>  delete mode 100644 Documentation/trace/events-msr.txt
>  create mode 100644 Documentation/trace/events-nmi.rst
>  delete mode 100644 Documentation/trace/events-nmi.txt
>  rename Documentation/trace/{events-power.txt => events-power.rst} (65%)
>  rename Documentation/trace/{events.txt => events.rst} (82%)
>  rename Documentation/trace/{ftrace-design.txt => ftrace-design.rst} (74%)
>  create mode 100644 Documentation/trace/ftrace.rst
>  delete mode 100644 Documentation/trace/ftrace.txt
>  rename Documentation/trace/{hwlat_detector.txt => hwlat_detector.rst} (83%)
>  create mode 100644 Documentation/trace/index.rst
>  rename Documentation/trace/{intel_th.txt => intel_th.rst} (82%)
>  rename Documentation/trace/{kprobetrace.txt => kprobetrace.rst} (63%)
>  rename Documentation/trace/{mmiotrace.txt => mmiotrace.rst} (78%)
>  rename Documentation/trace/{stm.txt => stm.rst} (91%)
>  rename Documentation/trace/{tracepoint-analysis.txt => tracepoint-analysis.rst} (93%)
>  rename Documentation/trace/{tracepoints.txt => tracepoints.rst} (74%)
>  rename Documentation/trace/{uprobetracer.txt => uprobetracer.rst} (86%)
> 
> -- 
> 2.7.4
> 

-- 
Thanks,
Changbin Du
