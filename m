Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69A2C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A8D20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A8D20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbeLFMhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:37:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:39072 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729038AbeLFMhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:37:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A2582AFCC;
        Thu,  6 Dec 2018 12:37:00 +0000 (UTC)
Date:   Thu, 6 Dec 2018 13:37:00 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 00/11] livepatch: Atomic replace feature
Message-ID: <20181206123700.ljiybm6w6wvmiy7c@pathway.suse.cz>
References: <20181129094431.7801-1-pmladek@suse.com>
 <176e592d-6e9c-8e1c-abe6-d07ba9b10d54@redhat.com>
 <20181206075404.rv4qyw2u5auvfiuz@pathway.suse.cz>
 <alpine.LSU.2.21.1812061031030.17628@pobox.suse.cz>
 <20181206101555.cydbzb7smubzsavn@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206101555.cydbzb7smubzsavn@pathway.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-12-06 11:15:55, Petr Mladek wrote:
> On Thu 2018-12-06 10:32:00, Miroslav Benes wrote:
> > 
> > > > I don't have many code comments as the changes appear to safely and
> > > > correctly do what the say.  (We are at v14 after all :)  I mainly
> > > > compared the text and comments to the implementation and noted typos
> > > > (marked by substitution s/old/new) and awkward wordings (marked by
> > > > "re-wording suggestion").  That said, I ack'd each patch as I wouldn't
> > > > want these to hold up the patchset.
> > > 
> > > Thanks a lot both you and Miroslav for the review.
> > > 
> > > I'll give it some more days before I prepare v15. I wonder if Josh
> > > could find some cycle to look at it at least from the top level.
> > 
> > For what is worth, I'm fine with all the changes Joe proposed and you can 
> > preserve my acks there.
> 
> We need enough time for bikeshedding about comments and documentation.
> I need some time to recover. And I still hope that Josh can give it
> a spin.

Please, forget the above paragraph. I did not get Mirek's one correctly.
I understood it as "Why do we need to wait? You have two acks.
Jump on it and send us v15 immediately."

Best Reards,
Petr
