Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933346AbeEIAOm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 20:14:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933175AbeEIAOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 20:14:40 -0400
Date: Tue, 8 May 2018 19:14:32 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>, live-patching@vger.kernel.org
Subject: Re: [PATCH v3] ppc64le livepatch: implement reliable stacktrace for
 newer consistency models
Message-ID: <20180509001432.5nd55ictwf5yi7sm@treble>
References: <20180305164928.GA17953@lst.de>
 <20180308162616.yhbymodggnfzpskx@treble>
 <20180309174718.2700b29e@blackhole.lan>
 <20180312153536.7avozx64ku4lvd3e@treble>
 <20180504123834.GA16581@lst.de>
 <20180507154208.jo4s43olrf5a3hw4@treble>
 <20180508103832.085378b9@blackhole.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180508103832.085378b9@blackhole.lan>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 10:38:32AM +0200, Torsten Duwe wrote:
> On Mon, 7 May 2018 10:42:08 -0500
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > The subject doesn't actively describe what the patch does, maybe
> > change it to something like:
> > 
> >   powerpc: Add support for HAVE_RELIABLE_STACKTRACE
> > 
> > or maybe
> > 
> >   powerpc: Add support for livepatch consistency model
> 
> Maybe $SUBJECT? You're absolutely right, the old subject was just a
> leftover of my original attempt to just set the flag, before Miroslav
> corrected me. I just kept on copying it without a second thought. Thanks
> for noting.

Generally we refer to it as "the consistency model".  So I would
propose a minor edit:

  ppc64le/livepatch: Implement reliable stack tracing for the consistency model

> > Otherwise it looks great to me.
> > 
> > Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > 
> Thanks.
> 
> 	Torsten
> 

-- 
Josh
