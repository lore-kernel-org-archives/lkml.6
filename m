Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B27C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4179B214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4179B214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbeIZT1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:27:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:56288 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728382AbeIZT1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:27:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 21D1DAB7D;
        Wed, 26 Sep 2018 13:14:47 +0000 (UTC)
Date:   Wed, 26 Sep 2018 15:14:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux-mm@ archive on lore.kernel.org (Was: [PATCH 0/2] thp
 nodereclaim fixes)
Message-ID: <20180926131445.GW6278@dhcp22.suse.cz>
References: <20180925120326.24392-1-mhocko@kernel.org>
 <20180926130850.vk6y6zxppn7bkovk@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926130850.vk6y6zxppn7bkovk@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-09-18 16:08:50, Kirill A. Shutemov wrote:
> On Tue, Sep 25, 2018 at 02:03:24PM +0200, Michal Hocko wrote:
> > Thoughts, alternative patches?
> > 
> > [1] http://lkml.kernel.org/r/20180820032204.9591-1-aarcange@redhat.com
> > [2] http://lkml.kernel.org/r/20180830064732.GA2656@dhcp22.suse.cz
> > [3] http://lkml.kernel.org/r/20180820032640.9896-2-aarcange@redhat.com
> 
> All these links are broken. lore.kernel.org doesn't have linux-mm@ archive.

Yeah, this is really sad. But one good thing is that it gives possible
and usually correct references to marc.info so I keep using it and
hoping this will improve in the future.

> Can we get it added?

I would love to have it covered. You need to talk to Konstantin Ryabitsev.
 
> Does anybody have good enough archive of the list to get started?

Maybe Andrew has. Mine is incomplete for sure.
-- 
Michal Hocko
SUSE Labs
