Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932971AbeEWNKx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:10:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932865AbeEWNKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:10:50 -0400
Date: Wed, 23 May 2018 08:10:47 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch: Remove not longer valid limitations from the
 documentation
Message-ID: <20180523131047.27dcmnazdnhkexx7@treble>
References: <20180523074742.20171-1-pmladek@suse.com>
 <alpine.LSU.2.21.1805231504240.26696@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1805231504240.26696@pobox.suse.cz>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 03:07:05PM +0200, Miroslav Benes wrote:
> 
> s/Remove not longer/Remove no longer/
> 
> On Wed, 23 May 2018, Petr Mladek wrote:
> 
> > Semantic changes are possible since the commit d83a7cb375eec21f04
> > ("livepatch: change to a per-task consistency model").
> > 
> > Also data structures can be patched since the commit 439e7271dc2b63de37
> > ("livepatch: introduce shadow variable API").
> > 
> > It is a high time we removed these limitations from the documentation.
> > 
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> 
> Acked-by: Miroslav Benes <mbenes@suse.cz>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
