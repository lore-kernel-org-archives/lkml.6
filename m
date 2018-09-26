Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE67C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F2721537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F2721537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeI0FYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 01:24:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:51290 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726107AbeI0FYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 01:24:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7B3F9B01F;
        Wed, 26 Sep 2018 23:08:42 +0000 (UTC)
Date:   Thu, 27 Sep 2018 00:08:38 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux-mm@ archive on lore.kernel.org (Was: [PATCH 0/2] thp
 nodereclaim fixes)
Message-ID: <20180926230838.GK1750@suse.de>
References: <20180925120326.24392-1-mhocko@kernel.org>
 <20180926130850.vk6y6zxppn7bkovk@kshutemo-mobl1>
 <20180926131445.GW6278@dhcp22.suse.cz>
 <20180926152200.8a3bfb1845de21937914feeb@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180926152200.8a3bfb1845de21937914feeb@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 03:22:00PM -0700, Andrew Morton wrote:
> On Wed, 26 Sep 2018 15:14:45 +0200 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > > Does anybody have good enough archive of the list to get started?
> > 
> > Maybe Andrew has. Mine is incomplete for sure.
> 
> fwiw, I have everything going back to 2001.   For some reason.

This is far better than mine and the only person I think could potentially
improve upon the archives is Rik. 2001 would cover the most interesting
periods when things like rmap was introduced. Back then the VM was relatively
simple and the concepts were generally covered by academic textbooks AFAIK.

-- 
Mel Gorman
SUSE Labs
