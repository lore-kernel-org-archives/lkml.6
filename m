Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753057AbeDQLob (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:44:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:37435 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752684AbeDQLoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:44:30 -0400
Date: Tue, 17 Apr 2018 13:44:28 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Petr Mladek <pmladek@suse.com>
cc: Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Nicolai Stange <nstange@suse.de>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] livepatch: Allocate and free shadow variables
 more safely
In-Reply-To: <20180416113647.25288-1-pmladek@suse.com>
Message-ID: <nycvar.YFH.7.76.1804171343520.28129@cbobk.fhfr.pm>
References: <20180416113647.25288-1-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2018, Petr Mladek wrote:

> Nikolai started to use shadow variables and found that list_head
> is not initialized correctly using the existing API.
> 
> The problem is that LIST_HEAD_INIT() set pointers to itself.
> klp_shadow_alloc() then copies these pointers to another location.

Queued in for-4.17/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs
