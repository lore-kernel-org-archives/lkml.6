Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162040AbeBPRc6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:32:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:39278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161052AbeBPRc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:32:57 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBC7217CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 16 Feb 2018 12:32:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Du, Changbin" <changbin.du@intel.com>
Cc: corbet@lwn.net, mingo@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Documentation: convert trace/ftrace-design.txt to
 rst format
Message-ID: <20180216123254.408a93a0@gandalf.local.home>
In-Reply-To: <20180216090726.hcwaq6zxa65c4pk5@intel.com>
References: <1518750739-12514-1-git-send-email-changbin.du@intel.com>
        <1518750739-12514-3-git-send-email-changbin.du@intel.com>
        <20180215225705.58984492@vmware.local.home>
        <20180216090726.hcwaq6zxa65c4pk5@intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2018 17:07:26 +0800
"Du, Changbin" <changbin.du@intel.com> wrote:


> > This document is out of date, and I rather have it updated before we
> > make it more "available" elsewhere.
> >  
> Got you. I plan to convert below docs. Are they out of date, too?
> 
> events-msr.txt, events.txt, mmiotrace.txt, stm.txt, uprobetracer.txt
> events-nmi.txt, intel_th.txt, tracepoint-analysis.txt, events-kmem.txt,
> events-power.txt, ftrace.txt, hwlat_detector.txt, kprobetrace.txt,
> tracepoints.txt.

I'm sure some of them are. I don't have time now to investigate which
ones though.

-- Steve
