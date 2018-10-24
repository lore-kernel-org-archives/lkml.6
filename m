Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F384C46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F6B2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F6B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeJXLVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:21:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbeJXLVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:21:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A26A18046C;
        Wed, 24 Oct 2018 02:55:47 +0000 (UTC)
Received: from treble (ovpn-123-230.rdu2.redhat.com [10.10.123.230])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AA7760603;
        Wed, 24 Oct 2018 02:55:42 +0000 (UTC)
Date:   Tue, 23 Oct 2018 21:55:41 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Miroslav Benes <mbenes@suse.cz>, Jiri Kosina <jikos@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 06/12] livepatch: Simplify API by removing
 registration step
Message-ID: <20181024025541.7mhiyvgad53ktrdc@treble>
References: <20180828143603.4442-7-pmladek@suse.com>
 <alpine.LSU.2.21.1809051108440.7768@pobox.suse.cz>
 <20181012130120.f5berowklyccd7lj@pathway.suse.cz>
 <alpine.LSU.2.21.1810151756290.11383@pobox.suse.cz>
 <20181018145456.nrekm2iuyf5ztw3n@pathway.suse.cz>
 <20181018153027.x4nk2ihgs5ehsln2@treble>
 <alpine.LSU.2.21.1810191400320.4692@pobox.suse.cz>
 <20181019143604.35zgwus4arkolbwr@treble>
 <20181022132509.6vxrdvq42e5j2bpx@pathway.suse.cz>
 <20181023163943.ex65stywf2cwqvep@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181023163943.ex65stywf2cwqvep@treble>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 24 Oct 2018 02:55:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 11:39:43AM -0500, Josh Poimboeuf wrote:
> Given this discussion, I'm thinking there wouldn't be much to discuss at
> LPC for this topic unless we had a prototype to look at (which I won't
> have time to do).  So I may drop my talk in favor of giving more time
> for other more tangible discussions.

I dropped my talk to give us time for the other topics, and I somewhat
arbitrarily added 5 minutes to each of the first 3 talks.  Suggestions
welcome.

-- 
Josh
