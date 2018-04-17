Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753954AbeDQN6Z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:58:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753088AbeDQN6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:58:24 -0400
Date: Tue, 17 Apr 2018 10:58:20 -0300
From: Arnaldo Carvalho de Melo <acme@redhat.com>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, mhiramat@kernel.org,
        kstewart@linuxfoundation.org, tglx@linutronix.de, pombredanne@nexb.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        uneedsihyeon@gmail.com, kjlx@templeofstupid.com
Subject: Re: [PATCH v2 0/3] perf/buildid-cache: Add --list and --purge-all
 options
Message-ID: <20180417135820.GB2350@redhat.com>
References: <20180417041346.5617-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180417075750.GC2052@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417075750.GC2052@krava>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 17, 2018 at 09:57:50AM +0200, Jiri Olsa escreveu:
> On Tue, Apr 17, 2018 at 09:43:43AM +0530, Ravi Bangoria wrote:
> > First patch is a trivial error message fix. Second and third
> > adds new options --list and --purge-all to 'buildid-cache'
> > subcommand.
> > 
> > v2 changes:
> >  - [PATCH v2 2/3] Display optput of 'perf buildid-cache -l' same as
> >    'perf buildid-list'.
> >  - [PATCH v2 2/3] Other minor changes as suggested by Jiri.
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied 1/3 to perf/urgent, 2-3/3 to perf/core.

- Arnaldo
