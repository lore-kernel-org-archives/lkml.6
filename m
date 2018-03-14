Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753272AbeCNIbg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:31:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34708 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeCNIbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:31:34 -0400
Date: Wed, 14 Mar 2018 09:30:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Anderson <dianders@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mathieu Malaterre <malat@debian.org>,
        Dave Hansen <dave.hansen@intel.com>, Yang Shi <yang.s@alibaba-inc.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>, Arnd Bergmann <arnd@arndb.de>,
        Mark Charlebois <charlebm@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 2/2] kbuild: Don't mess with the .cache.mk when root
Message-ID: <20180314083048.GC4082@hirez.programming.kicks-ass.net>
References: <20180313061109.72629-1-dianders@chromium.org>
 <20180313061109.72629-3-dianders@chromium.org>
 <20180313061603.jsgiumet23uqi6hl@gmail.com>
 <CAD=FV=UEuWww=H=TY=E8JvEmrobDNi5+rbTXvTAmZ2brpK+sdg@mail.gmail.com>
 <CAKwvOdnPSMSOenPiPqBpDf=hf5q5uQ5MF0pOLAea5T5_VPhmaA@mail.gmail.com>
 <CAD=FV=UvT-BrpZcz4RV=cRW4Nf9rBkYvc2JgcQr465NMYjAvJw@mail.gmail.com>
 <CA+55aFzTT5fzz__pY2HhxK=GPnJ8vtpgtok672AAXfSGg+ztuQ@mail.gmail.com>
 <20180314072316.zc7qe2reox3htw3z@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314072316.zc7qe2reox3htw3z@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 08:23:16AM +0100, Ingo Molnar wrote:
> 
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > If Ingo wants to build as root, maybe we could even make him set some
> > environment flag to avoid errors.
> 
> I only build as root infrequently, but I think PeterZ does it more frequently?

Yeah, a bunch of my testboxes don't even have a regular user account.
