Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753242AbeAaD7x (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 22:59:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:7145 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753208AbeAaD7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 22:59:51 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,437,1511856000";
   d="scan'208";a="13871344"
Date: Tue, 30 Jan 2018 19:59:41 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Stephane Eranian <eranian@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>, "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V3 0/5] bugs fix for large PEBS mmap read and rdpmc read
Message-ID: <20180131035941.GW26209@tassilo.jf.intel.com>
References: <1517243373-355481-1-git-send-email-kan.liang@linux.intel.com>
 <CABPqkBRjQp62ArVZzuH=TRU3mDPkS93D8_cNev6M=eXTCpBLkA@mail.gmail.com>
 <20180130133917.GC29098@krava>
 <6d708c09-52a7-a906-b651-b133a7b4f189@linux.intel.com>
 <20180130150454.GE29098@krava>
 <35090c62-466a-aec8-b1a3-69def959c1c6@linux.intel.com>
 <CABPqkBRWtSsKEM7ycPs0HYSKLsYDmZhr4ztUmMMqsytYamPGsw@mail.gmail.com>
 <24210bcb-0e4b-58fe-bcda-da30019f6e7e@linux.intel.com>
 <20180130185212.GA16806@krava>
 <CABPqkBRp9bDmGECStbAHA5Ja0SjJmDQ2SOceat=qXno707MuAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBRp9bDmGECStbAHA5Ja0SjJmDQ2SOceat=qXno707MuAA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Still, the part I am missing here, is why asking for
> PERF_SAMPLE_PERIOD voids large PEBS.

I think it was disabled together with frequency mode
(which we could support too, but it's a bit more work)

But yes PERIOD could probably be allowed.


-Andi
