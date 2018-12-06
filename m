Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F17C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09D1214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09D1214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbeLFJcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:32:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:56174 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727575AbeLFJcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:32:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5B4E1AFDE;
        Thu,  6 Dec 2018 09:32:01 +0000 (UTC)
Date:   Thu, 6 Dec 2018 10:32:00 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 00/11] livepatch: Atomic replace feature
In-Reply-To: <20181206075404.rv4qyw2u5auvfiuz@pathway.suse.cz>
Message-ID: <alpine.LSU.2.21.1812061031030.17628@pobox.suse.cz>
References: <20181129094431.7801-1-pmladek@suse.com> <176e592d-6e9c-8e1c-abe6-d07ba9b10d54@redhat.com> <20181206075404.rv4qyw2u5auvfiuz@pathway.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > I don't have many code comments as the changes appear to safely and
> > correctly do what the say.  (We are at v14 after all :)  I mainly
> > compared the text and comments to the implementation and noted typos
> > (marked by substitution s/old/new) and awkward wordings (marked by
> > "re-wording suggestion").  That said, I ack'd each patch as I wouldn't
> > want these to hold up the patchset.
> 
> Thanks a lot both you and Miroslav for the review.
> 
> I'll give it some more days before I prepare v15. I wonder if Josh
> could find some cycle to look at it at least from the top level.

For what is worth, I'm fine with all the changes Joe proposed and you can 
preserve my acks there.

Miroslav
