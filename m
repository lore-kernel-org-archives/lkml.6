Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031760AbeEXOS4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:18:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:38533 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030516AbeEXOSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:18:52 -0400
Date: Thu, 24 May 2018 15:38:54 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Petr Mladek <pmladek@suse.com>
cc: Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch: Remove not longer valid limitations from the
 documentation
In-Reply-To: <20180523074742.20171-1-pmladek@suse.com>
Message-ID: <nycvar.YFH.7.76.1805241538430.27054@cbobk.fhfr.pm>
References: <20180523074742.20171-1-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 May 2018, Petr Mladek wrote:

> Semantic changes are possible since the commit d83a7cb375eec21f04
> ("livepatch: change to a per-task consistency model").
> 
> Also data structures can be patched since the commit 439e7271dc2b63de37
> ("livepatch: introduce shadow variable API").
> 
> It is a high time we removed these limitations from the documentation.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
> I have found this when working on v12 of the atomic replace. It looks
> like a no-brainer and does not conflict with the patchset, so ... ;-)

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
