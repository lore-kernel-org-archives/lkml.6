Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932201AbeCEOmJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:42:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751818AbeCEOmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:42:06 -0500
Date: Mon, 5 Mar 2018 08:42:03 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Joe Lawrence <joe.lawrence@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Jiri Kosina <jikos@kernel.org>, Jason Baron <jbaron@akamai.com>,
        Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 7/8] livepatch: Correctly handle atomic replace for
 not yet loaded modules
Message-ID: <20180305144203.2u3i2jzznsb7swsn@treble>
References: <20180221132914.4809-1-pmladek@suse.com>
 <20180221132914.4809-8-pmladek@suse.com>
 <alpine.LSU.2.21.1802222145160.21576@pobox.suse.cz>
 <20180301102859.zwrt6w36ub474nb2@pathway.suse.cz>
 <7f920ec3-dfe0-6a4d-dd25-5d5c4fa75714@redhat.com>
 <alpine.LSU.2.21.1803051050330.26605@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1803051050330.26605@pobox.suse.cz>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 10:54:16AM +0100, Miroslav Benes wrote:
> > I think this problem is contained to only replacement patches that need
> > the nop-revert feature... if the replacement patch provides a new
> > function definition, then it shouldn't be affected.
> > 
> > Man, we need a regression test suite for all these cases :)
> 
> Any volunteer?

I'd strongly prefer that we get such selftests in place before merging
any more major features...

-- 
Josh
