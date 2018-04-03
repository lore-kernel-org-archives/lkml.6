Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754969AbeDCIF5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:05:57 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46217 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754807AbeDCIFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:05:55 -0400
X-Google-Smtp-Source: AIpwx49cIcZR8jkqJuRboJkFEU2jMRxGqxUEQfJ5inqoZClxdz8lx+eNaOv8OFL78ABiRWN6hm5+EA==
Date: Tue, 3 Apr 2018 10:05:51 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] misc core kernel changes
Message-ID: <20180403080551.f6u4c3kt7gl4cc62@gmail.com>
References: <20180402061443.yismaal7rly6ctpt@gmail.com>
 <CA+55aFz9zELeexAw8Yk6wgDcazGVFC6sbn_MWP7ZLVtigx2Odg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFz9zELeexAw8Yk6wgDcazGVFC6sbn_MWP7ZLVtigx2Odg@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, Apr 1, 2018 at 11:14 PM, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >  - add membarriers to Documentation/features/
> 
> You had actually done this earlier already, so now there are two
> commits adding it.
> 
> Oh well.

Indeed, I messed up the handling of that patch, sorry about that!

Thanks,

	Ingo
