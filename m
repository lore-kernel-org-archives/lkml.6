Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9B6C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6832120850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6832120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbeLFAAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 19:00:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:9112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbeLFAAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 19:00:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C52B3082A25;
        Thu,  6 Dec 2018 00:00:38 +0000 (UTC)
Received: from sky.random (ovpn-122-73.rdu2.redhat.com [10.10.122.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 252D15DE01;
        Thu,  6 Dec 2018 00:00:35 +0000 (UTC)
Date:   Wed, 5 Dec 2018 19:00:34 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        mhocko@kernel.org, ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
Message-ID: <20181206000034.GH11899@redhat.com>
References: <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com>
 <20181203185954.GM31738@dhcp22.suse.cz>
 <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com>
 <20181203201214.GB3540@redhat.com>
 <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com>
 <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com>
 <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz>
 <20181204104558.GV23260@techsingularity.net>
 <20181205204034.GB11899@redhat.com>
 <alpine.DEB.2.21.1812051316150.9633@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812051316150.9633@chino.kir.corp.google.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 06 Dec 2018 00:00:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Dec 05, 2018 at 01:59:32PM -0800, David Rientjes wrote:
> [..] and the kernel test robot has reported, [..]

Just for completeness you may have missed one email:
https://lkml.kernel.org/r/87tvk1yjkp.fsf@yhuang-dev.intel.com

'So I think the report should have been a "performance
improvement" instead of "performance regression".'
