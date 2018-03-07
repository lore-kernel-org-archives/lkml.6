Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754461AbeCGOKa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:10:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753807AbeCGOK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:10:27 -0500
Date: Wed, 7 Mar 2018 15:10:23 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [RFC 00/49] perf tools: Add threads to record command
Message-ID: <20180307141023.GA15364@krava>
References: <20180109153522.14116-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180109153522.14116-1-jolsa@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2018 at 04:34:33PM +0100, Jiri Olsa wrote:
> hi,
> sending *RFC* for threads support in perf record command.
> 
> In big picture this patchset adds perf record --threads
> option that allows to create threads in following modes:

rebased to current Arnaldo's perf/core with few bugs fixed

  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/record_threads

jirka
