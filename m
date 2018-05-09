Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935125AbeEIOlF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:41:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58444 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933988AbeEIOlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:41:03 -0400
Date: Wed, 9 May 2018 11:40:54 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 08/11] docs: refcount-vs-atomic.rst: prefix url with
 https
Message-ID: <20180509114054.3ff70c98@vento.lan>
In-Reply-To: <20180509134319.GA14921@andrea>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
        <d5683242124d6070c9a2d665c59e274d94c8b3ba.1525870886.git.mchehab+samsung@kernel.org>
        <20180509134319.GA14921@andrea>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 9 May 2018 15:43:19 +0200
Andrea Parri <andrea.parri@amarulasolutions.com> escreveu:

> Hi Mauro,
> 
> On Wed, May 09, 2018 at 10:18:51AM -0300, Mauro Carvalho Chehab wrote:
> > There's a github URL there, but it is not prefixed by https.
> > Add a prefix, to avoid false-positives with:
> > 	./scripts/documentation-file-ref-check
> > 
> > As a side effect, Sphinx should also generate a cross-ref.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>  
> 
> There seems to be a "conflicting" patch ("applied" according to Jon):
> 
>     http://lkml.kernel.org/r/1525468309-5310-1-git-send-email-andrea.parri@amarulasolutions.com
> 
> Let me stress here that the github repo. is out-of-date (and we have
> no plans to keep that in sync with mainline).

Good! One less patch pending :-)

Yeah, it seems that Jon pushed it from his repository today. I did a new
git remote update and I'm now seeing this one too.

> 
>   Andrea
> 
> 
> > ---
> >  Documentation/core-api/refcount-vs-atomic.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/core-api/refcount-vs-atomic.rst b/Documentation/core-api/refcount-vs-atomic.rst
> > index 83351c258cdb..185d659e350a 100644
> > --- a/Documentation/core-api/refcount-vs-atomic.rst
> > +++ b/Documentation/core-api/refcount-vs-atomic.rst
> > @@ -17,7 +17,7 @@ in order to help maintainers validate their code against the change in
> >  these memory ordering guarantees.
> >  
> >  The terms used through this document try to follow the formal LKMM defined in
> > -github.com/aparri/memory-model/blob/master/Documentation/explanation.txt
> > +https://github.com/aparri/memory-model/blob/master/Documentation/explanation.txt
> >  
> >  memory-barriers.txt and atomic_t.txt provide more background to the
> >  memory ordering in general and for atomic operations specifically.
> > -- 
> > 2.17.0
> >   



Thanks,
Mauro
