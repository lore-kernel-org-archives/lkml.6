Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752693AbeEGTQ7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 15:16:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752099AbeEGTQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 15:16:57 -0400
Date: Mon, 7 May 2018 21:16:53 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kan.liang@linux.intel.com
Subject: Re: [PATCH 05/12] perf pmu: Fix pmu events parsing rule
Message-ID: <20180507191653.GA1924@krava>
References: <20180425160008.3407-1-acme@kernel.org>
 <20180425160008.3407-6-acme@kernel.org>
 <448c4e21-8232-3d04-cac4-49b95c8bca3a@intel.com>
 <20180503103717.GA14776@krava>
 <0c33d3f9-4b76-c94c-7306-e93e8cd8d4aa@intel.com>
 <20180504160228.GA25229@krava>
 <87a7tdphyo.fsf@linux.intel.com>
 <20180507183749.GA2095@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507183749.GA2095@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 03:37:49PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sat, May 05, 2018 at 08:43:11PM -0700, Andi Kleen escreveu:
> > Jiri Olsa <jolsa@redhat.com> writes:
> > 
> > Please fix this quickly, PT is currently totally non functional in Linus
> > mainline.
> 
> Ok, so I'm reverting this patch, the previous situation was just a
> misleading error message, so it can wait for the discussion about the
> parser fixes to come to a conclusion and a proper patch to be submitted.

ok, I was waiting for some feedback on the new patch.. I'll merge
it with the one you reverted now

thanks,
jirka
