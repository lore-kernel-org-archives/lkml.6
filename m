Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965231AbeEITbw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:31:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36136 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964850AbeEITbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:31:50 -0400
Date: Wed, 9 May 2018 21:31:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 13/18] wait: wait.h: Get rid of a kernel-doc/Sphinx
 warnings
Message-ID: <20180509193138.GW12217@hirez.programming.kicks-ass.net>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
 <6b9b3184cbfabab1ad89c974ddf1c61631e8f1bf.1525684985.git.mchehab+samsung@kernel.org>
 <20180509084120.GF12217@hirez.programming.kicks-ass.net>
 <20180509084518.247650e2@lwn.net>
 <20180509152026.GA12198@hirez.programming.kicks-ass.net>
 <20180509123540.083b61d2@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509123540.083b61d2@lwn.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 12:35:40PM -0600, Jonathan Corbet wrote:
> On Wed, 9 May 2018 17:20:26 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > The whole rst wankery is detrimental to that interface in order to
> > pander to something else.. I don't see the value. I've objected before,
> > and I suppose I'll object again.
> 
> One person's wankery is another's integrated, browsable, and searchable
> documentation that shows some signs of having actually been thought about,
> I guess.

Browsable is what we have ctags/cscope for and searchable is git-grep, right?
