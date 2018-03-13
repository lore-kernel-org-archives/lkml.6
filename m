Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbeCMOS6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 10:18:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752647AbeCMOS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 10:18:56 -0400
Date: Tue, 13 Mar 2018 15:18:53 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 11/13] perf bpf: Add helper header files
Message-ID: <20180313141853.GA26382@krava>
References: <20180312094313.18738-1-jolsa@kernel.org>
 <20180312094313.18738-12-jolsa@kernel.org>
 <20180313013529.GD10004@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313013529.GD10004@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 10:35:29PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Mar 12, 2018 at 10:43:11AM +0100, Jiri Olsa escreveu:
> > +#elif defined(__s390x__)
> > +	#define bpf_target_s930x
> 
>     bpf_target_s390x

eagle eyes ;-) must be problem in samples/bpf where I stoled it from ;-)

thanks,
jirka

> 
> > +#elif defined(__aarch64__)
> > +	#define bpf_target_arm64
> > +#elif defined(__mips__)
> > +	#define bpf_target_mips
> > +#elif defined(__powerpc__)
> > +	#define bpf_target_powerpc
> > +#elif defined(__sparc__)
> > +	#define bpf_target_sparc
> > +#endif
> > +#endif
