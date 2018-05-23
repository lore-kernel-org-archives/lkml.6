Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932946AbeEWNHI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:07:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:54662 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932089AbeEWNHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:07:07 -0400
Date: Wed, 23 May 2018 15:07:05 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch: Remove not longer valid limitations from the
 documentation
In-Reply-To: <20180523074742.20171-1-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1805231504240.26696@pobox.suse.cz>
References: <20180523074742.20171-1-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/Remove not longer/Remove no longer/

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

Acked-by: Miroslav Benes <mbenes@suse.cz>

M
