Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966560AbeEJQwa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 12:52:30 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:39711 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966474AbeEJQw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 12:52:28 -0400
X-Google-Smtp-Source: AB8JxZojRdGUeO/Rxybkdpc5evo7EdljrpaJP3yJfcgeQ+29HlwNs0YnUz+O1ixbmLB3i+CTdim3ZQ==
Date: Thu, 10 May 2018 18:52:20 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 13/18] wait: wait.h: Get rid of a kernel-doc/Sphinx
 warnings
Message-ID: <20180510165220.GA9757@andrea>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
 <6b9b3184cbfabab1ad89c974ddf1c61631e8f1bf.1525684985.git.mchehab+samsung@kernel.org>
 <20180509084120.GF12217@hirez.programming.kicks-ass.net>
 <20180509084518.247650e2@lwn.net>
 <20180510122335.GA7704@andrea>
 <20180510071559.59dcc8cc@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510071559.59dcc8cc@lwn.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 07:15:59AM -0600, Jonathan Corbet wrote:
> On Thu, 10 May 2018 14:23:35 +0200
> Andrea Parri <andrea.parri@amarulasolutions.com> wrote:
> 
> > only
> > remember that other people (including some developers running into the
> > "disadventure" of opening an RST doc. from their preferred text editor
> > and being brought to conclude:  "WTH!  I need to open a web browser, I
> > guess...") _use_ such doc. and _do care_ about it, and that what might
> > be an improvement for some people might look as "vandalizing" to others.
> 
> If you have an example of a place where use of a web browser has been
> made mandatory, please point it out.  Avoiding that was at the top of the
> list of explicit requirements.

That's all I need.


>Surely an extra colon is not going to
> force you to run screaming to the protective embrace of Firefox...?

Let me put it in these terms: I believe that that extra colon (or the
"diagram" keywork) is not going to improve/help my use of the doc. ;D

  Andrea


> 
> Thanks,
> 
> jon
