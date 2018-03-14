Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeCNM2O (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:28:14 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:38566 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751889AbeCNM2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:28:12 -0400
X-Google-Smtp-Source: AG47ELtHNzLbk/4VHe9TDYQP+1IlMDLwdM8gF0duEPXoBLfDOe4jzdP3wLae7nOFFmjSK28T4LmxZg==
Date: Wed, 14 Mar 2018 13:28:07 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Milind Chabbi <chabbi.milind@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@intel.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Oleg Nesterov <onestero@redhat.com>, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] hw_breakpoint: Fix build for disabled
 CONFIG_HAVE_HW_BREAKPOINT
Message-ID: <20180314122807.lnlun4og2i6q3uzb@gmail.com>
References: <20180312134548.31532-1-jolsa@kernel.org>
 <20180313063747.b4bw2j25cvtgjk5b@gmail.com>
 <20180313092801.GB16389@krava>
 <20180313095045.GC16389@krava>
 <20180314084513.GA9216@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314084513.GA9216@krava>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jiri Olsa <jolsa@redhat.com> wrote:

> > should be this one.. I'm checking on s390 which is also
> > without breakpoint support, I'll send full patch after
> 
> and here it is

Yeah, note that I back-merged this into the series so there's no separate commit 
for the fix.

Thanks,

	Ingo
