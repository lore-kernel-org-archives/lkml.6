Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89312C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2992080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfBFPWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:22:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbfBFPWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:22:43 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D68446202;
        Wed,  6 Feb 2019 15:22:43 +0000 (UTC)
Received: from treble (ovpn-119-156.phx2.redhat.com [10.3.119.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 357A76155B;
        Wed,  6 Feb 2019 15:22:39 +0000 (UTC)
Date:   Wed, 6 Feb 2019 09:22:37 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] livepatch: Followup changes for the atomic
 replace patchset
Message-ID: <20190206152237.vhoq2jsz6el2yysq@treble>
References: <20190204135653.31406-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190204135653.31406-1-pmladek@suse.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 06 Feb 2019 15:22:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 02:56:49PM +0100, Petr Mladek wrote:
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

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
