Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbeEVNsA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 09:48:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751196AbeEVNr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 09:47:59 -0400
Date: Tue, 22 May 2018 15:47:57 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: found 2 tests failed using "perf test" command
Message-ID: <20180522134757.GA10727@krava>
References: <CAG=yYwnNYY6YKD8wtnjQD-87N7ipSCnyXr8dzFGm4brE6-cgNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG=yYwnNYY6YKD8wtnjQD-87N7ipSCnyXr8dzFGm4brE6-cgNw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 01:53:15AM +0530, Jeffrin Thalakkottoor wrote:
> hello,
> 
> 
> i found two tests failed while i did "sudo ./perf test"
> 
> --------------------------------------------------------------------------->
> 24: Object code reading                                   : FAILED!
> 64: probe libc's inet_pton & backtrace it with ping       : FAILED!
> ---------------------------------------------------------------------------->
> 
> some relevent shell session details from ./sudo perf test -vv 24
> -------------------------------------------------------------------------------------------------------->
> Objdump command is: objdump -z -d --start-address=0xffffffff8132dda7
> --stop-address=0xffffffff8132de27
> /lib/modules/4.17.0-rc5+/build/vmlinux
> Bytes read match those read by objdump
> Reading object code for memory address: 0xfffffe000005e01e
> thread__find_addr_map failed
> test child finished with -1
> ---- end ----
> Object code reading: FAILED!
> ---------------------------------------------------------------------------------------------------------->
> 
> $sudo ./perf test -vv 64
> 64: probe libc's inet_pton & backtrace it with ping       :
> --- start ---
> test child forked, pid 4751
> test child finished with -1
> ---- end ----
> probe libc's inet_pton & backtrace it with ping: FAILED!

there's been some recent discussion/changes in here, please follow:
  https://marc.info/?t=152662842600002&r=1&w=2

jirka
