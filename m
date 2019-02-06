Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DD6C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F78D206C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfBFK3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:29:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:55812 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726977AbfBFK3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:29:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E59B3B6AF;
        Wed,  6 Feb 2019 10:29:36 +0000 (UTC)
Date:   Wed, 6 Feb 2019 11:29:36 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] livepatch: Followup changes for the atomic
 replace patchset
Message-ID: <20190206102936.hjuvq3d4xa7redra@pathway.suse.cz>
References: <20190204135653.31406-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204135653.31406-1-pmladek@suse.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-02-04 14:56:49, Petr Mladek wrote:
> This patchset implements ideas that were mentioned and postponed during
> the review of the atomic replace patchset.
> 
> The patches apply on top of livepatching.git, branch
> origin/for-5.1/atomic-replace.
> 
> 
> Changes against v1:
> 
>   + Added Joe's patch that fixed ptr_id() error code [Joe]
>   + Did proper error handling in the shadow variable sefttest [All]
>   + Removed the controversial patch that was removing patch->enabled flag [All].
>   + Fixed few typo's [Joe]
>   + Added available Acks.
> 
> 
> Joe Lawrence (1):
>   livepatch: return -ENOMEM on ptr_id() allocation failure
> 
> Petr Mladek (3):
>   livepatch: Introduce klp_for_each_patch macro
>   livepatch: Proper error handling in the shadow variables selftest
>   livepatch: Module coming and going callbacks can proceed with all
>     listed patches

I have applied all 4 paches into for-5.1/atomic-replace branch.

Best Regards,
Petr
