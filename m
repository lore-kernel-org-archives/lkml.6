Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC5DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC1D2188F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC1D2188F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeHQR4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:56:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:60722 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726888AbeHQR4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:56:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9E802ADC0;
        Fri, 17 Aug 2018 14:53:10 +0000 (UTC)
Date:   Fri, 17 Aug 2018 16:53:10 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jessica Yu <jeyu@kernel.org>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 00/10] livepatch: Atomic replace feature
Message-ID: <20180817145309.a2lqv5borwi5wrej@pathway.suse.cz>
References: <20180307082039.10196-1-pmladek@suse.com>
 <d40cb118-97d7-4d2f-4b39-265341bd9dac@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d40cb118-97d7-4d2f-4b39-265341bd9dac@virtuozzo.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-08-17 13:17:27, Evgenii Shatokhin wrote:
> Hi,
> 
> On 07.03.2018 11:20, Petr Mladek wrote:
> > The atomic replace allows to create cumulative patches. They
> > are useful when you maintain many livepatches and want to remove
> > one that is lower on the stack. In addition it is very useful when
> > more patches touch the same function and there are dependencies
> > between them.
> 
> Could you tell me what is the current status of this series? Looks like I
> lost track of it.
> 
> Is there anything else that should be done here before this series could be
> merged?

I have almost ready the rework suggested by Josh. I still need to
port the new tests and send.

Unfortunately I had to put it temporary on hold because of other
important tasks.

I am about to leave for vacation (one week off). I will try to
find some cycles, finish and send it once I am back.

Best Regards,
Petr
