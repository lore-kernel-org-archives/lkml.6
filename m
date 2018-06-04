Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753343AbeFDNrU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753057AbeFDNrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:47:19 -0400
Date: Mon, 4 Jun 2018 10:47:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2]: perf record: enable arbitrary event names thru name=
 modifier
Message-ID: <20180604134716.GD3397@kernel.org>
References: <23f72f9b-c513-ecd4-d375-c5cf2eb30197@linux.intel.com>
 <20180601230100.GN30764@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601230100.GN30764@tassilo.jf.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 01, 2018 at 04:01:00PM -0700, Andi Kleen escreveu:
> On Thu, May 31, 2018 at 05:08:12PM +0300, Alexey Budankov wrote:
> > 
> > Enable complex event names containing [.:=,] symbols to be encoded into Perf 
> > trace using name= modifier e.g. like this:
> > 
> > perf record -e cpu/name=\'OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM\',\
> > 		period=0x3567e0,event=0x3c,cmask=0x1/Duk ./futex
> > 
> > Below is how it looks like in the report output. Please note explicit escaped 
> > quoting at cmdline string in the header so that thestring can be directly reused
> > for another collection in shell:
> 
> Patch looks good, but new syntax also needs to be documented in some manpage
> (e.g. perf list)

He added the doc part in his v3 post, so I'l collecting your Acked-by,
ok?

- Arnaldo
