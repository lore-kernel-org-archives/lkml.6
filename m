Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032296AbeBNQQl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:16:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:43282 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032074AbeBNQQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:16:40 -0500
Date: Wed, 14 Feb 2018 17:16:37 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/7] livepatch: Atomic replace feature
In-Reply-To: <20180206103424.10829-1-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1802141714430.28578@pobox.suse.cz>
References: <20180206103424.10829-1-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2018, Petr Mladek wrote:

> The atomic replace allows to create cumulative patches. They
> are useful when you maintain many livepatches and want to remove
> one that is lower on the stack. In addition it is very useful when
> more patches touch the same function and there are dependencies
> between them.

So I ported my old silly kgraft modules to livepatch and it works well. It 
does not say that much, because the tests are really simple stupid, but at 
least something.

Miroslav
