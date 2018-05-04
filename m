Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbeEDVhJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 17:37:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37149 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbeEDVhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 17:37:08 -0400
X-Google-Smtp-Source: AB8JxZqm3eKDRpEDM3/qQ2BpPsh5OopT4QBs3mB7iIfgimeVwjcoCGQI7ib3ccZHT7fnIh6uQ8HrsA==
Date: Fri, 4 May 2018 23:37:00 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Kees Cook <keescook@chromium.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Elena Reshetova <elena.reshetova@intel.com>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: refcount-vs-atomic: Update reference to
 LKMM doc.
Message-ID: <20180504213700.GA5628@andrea>
References: <1525468309-5310-1-git-send-email-andrea.parri@amarulasolutions.com>
 <CAGXu5jKHb8-P-Y2ecnH9sd6vWhY9cWPfow1Lx_gzRMbHWusRXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKHb8-P-Y2ecnH9sd6vWhY9cWPfow1Lx_gzRMbHWusRXg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 02:13:59PM -0700, Kees Cook wrote:
> On Fri, May 4, 2018 at 2:11 PM, Andrea Parri
> <andrea.parri@amarulasolutions.com> wrote:
> > The LKMM project has moved to 'tools/memory-model/'.
> >
> > Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> > ---
> >  Documentation/core-api/refcount-vs-atomic.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/core-api/refcount-vs-atomic.rst b/Documentation/core-api/refcount-vs-atomic.rst
> > index 83351c258cdb9..322851bada167 100644
> > --- a/Documentation/core-api/refcount-vs-atomic.rst
> > +++ b/Documentation/core-api/refcount-vs-atomic.rst
> > @@ -17,7 +17,7 @@ in order to help maintainers validate their code against the change in
> >  these memory ordering guarantees.
> >
> >  The terms used through this document try to follow the formal LKMM defined in
> > -github.com/aparri/memory-model/blob/master/Documentation/explanation.txt
> > +tools/memory-model/Documentation/explanation.txt.
> >
> >  memory-barriers.txt and atomic_t.txt provide more background to the
> >  memory ordering in general and for atomic operations specifically.
> 
> Will this get linkified by rst ?

I believe not, but I'm not too familiar with rst...  FWIW, I'm seeing that
the above memory-barriers.txt, atomic_t.txt are not linkified.

  Andrea


> 
> -Kees
> 
> -- 
> Kees Cook
> Pixel Security
