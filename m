Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757312AbeEJNQF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 09:16:05 -0400
Received: from ms.lwn.net ([45.79.88.28]:56862 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757063AbeEJNQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 09:16:04 -0400
Date: Thu, 10 May 2018 07:15:59 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 13/18] wait: wait.h: Get rid of a kernel-doc/Sphinx
 warnings
Message-ID: <20180510071559.59dcc8cc@lwn.net>
In-Reply-To: <20180510122335.GA7704@andrea>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
        <6b9b3184cbfabab1ad89c974ddf1c61631e8f1bf.1525684985.git.mchehab+samsung@kernel.org>
        <20180509084120.GF12217@hirez.programming.kicks-ass.net>
        <20180509084518.247650e2@lwn.net>
        <20180510122335.GA7704@andrea>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 May 2018 14:23:35 +0200
Andrea Parri <andrea.parri@amarulasolutions.com> wrote:

> only
> remember that other people (including some developers running into the
> "disadventure" of opening an RST doc. from their preferred text editor
> and being brought to conclude:  "WTH!  I need to open a web browser, I
> guess...") _use_ such doc. and _do care_ about it, and that what might
> be an improvement for some people might look as "vandalizing" to others.

If you have an example of a place where use of a web browser has been
made mandatory, please point it out.  Avoiding that was at the top of the
list of explicit requirements.  Surely an extra colon is not going to
force you to run screaming to the protective embrace of Firefox...?

Thanks,

jon
