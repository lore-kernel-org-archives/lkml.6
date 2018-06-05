Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbeFEPcm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:32:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751701AbeFEPcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:32:41 -0400
Date: Tue, 5 Jun 2018 12:32:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] perf intel-pt: Fixes
Message-ID: <20180605153238.GJ4899@kernel.org>
References: <1527762225-26024-1-git-send-email-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527762225-26024-1-git-send-email-adrian.hunter@intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 31, 2018 at 01:23:41PM +0300, Adrian Hunter escreveu:
> Hi
> 
> Here are some small non-urgent fixes for Intel PT.

Thanks, applied the kit,

- Arnaldo
 
> 
> Adrian Hunter (4):
>       perf intel-pt: Fix sync_switch INTEL_PT_SS_NOT_TRACING
>       perf intel-pt: Fix decoding to accept CBR between FUP and corresponding TIP
>       perf intel-pt: Fix MTC timing after overflow
>       perf intel-pt: Fix "Unexpected indirect branch" error
> 
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 23 ++++++++++++++++++----
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |  9 +++++++++
>  tools/perf/util/intel-pt.c                         |  5 +++++
>  3 files changed, 33 insertions(+), 4 deletions(-)
> 
> 
> Regards
> Adrian
