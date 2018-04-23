Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755848AbeDWP3K (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:29:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755761AbeDWP3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:29:09 -0400
Date: Mon, 23 Apr 2018 17:29:05 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 7/9] perf stat: Add --table option to display time of
 each run
Message-ID: <20180423152905.GB8331@krava>
References: <20180423090823.32309-1-jolsa@kernel.org>
 <20180423090823.32309-8-jolsa@kernel.org>
 <20180423144149.GG30324@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423144149.GG30324@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 11:41:49AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Apr 23, 2018 at 11:08:21AM +0200, Jiri Olsa escreveu:
> > Adding --table option to display time for each
> > run (-r option), like:
> 
> You forgot to add this to 'perf stat's man page, I'm doing it this time,

ugh, sry.. thanks ;-)

jirka
