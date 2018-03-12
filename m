Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751473AbeCLIYf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:24:35 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33870 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeCLIYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:24:33 -0400
X-Google-Smtp-Source: AG47ELs+IvyzSl1b4sU8he9Dpgp2ejY7T5N7hPdTKYsW/3MXDcZWcjXSUwuYdxgRkKre/ubbwf+swA==
Date: Mon, 12 Mar 2018 09:24:29 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Vas Dias <jason.vas.dias@gmail.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, andi <andi@firstfloor.org>
Subject: Re: [PATCH v4.16-rc4 1/2] x86/vdso: on Intel, VDSO should handle
 CLOCK_MONOTONIC_RAW
Message-ID: <20180312082429.yxyaennsgfzkoohh@gmail.com>
References: <d109lwfe.fsf@gmail.com>
 <alpine.DEB.2.21.1803112350190.1485@nanos.tec.linutronix.de>
 <20180312072413.toyd5ztkgaah35xg@gmail.com>
 <20180312081007.GD4043@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312081007.GD4043@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Mar 12, 2018 at 08:24:13AM +0100, Ingo Molnar wrote:
> 
> >  - Code quality of the submitted patches is atrocious, please run them through
> >    scripts/checkpatch.pl (and make sure they pass) to at least enable the reading 
> >    of them.
> 
> I'd suggest also reading: Documentation/CodingStyle

Yeah, a careful reading of Documentation/process/submitting-patches.rst will 
include:

  4) Style-check your changes
  ---------------------------

  Check your patch for basic style violations, details of which can be
  found in
  :ref:`Documentation/process/coding-style.rst <codingstyle>`.
  Failure to do so simply wastes
  the reviewers time and will get your patch rejected, probably
  without even being read.


Thanks,

	Ingo
