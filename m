Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbeBWKld (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:41:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:46579 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751089AbeBWKlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:41:31 -0500
Date: Fri, 23 Feb 2018 11:41:28 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 8/8] livepatch: Atomic replace and cumulative patches
 documentation
In-Reply-To: <20180221132914.4809-9-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1802231139030.26550@pobox.suse.cz>
References: <20180221132914.4809-1-pmladek@suse.com> <20180221132914.4809-9-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2018, Petr Mladek wrote:

> User documentation for the atomic replace feature. It makes it easier
> to maintain livepatches using so-called cumulative patches.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

Joe, are you planning to extend shadow vars documentation you mentioned 
before (v7), or do you want Petr to do it?

Thanks,
Miroslav
