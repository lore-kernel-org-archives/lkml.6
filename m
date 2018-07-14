Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF08ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 00:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98A9208A6
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 00:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98A9208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbeGNA24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 20:28:56 -0400
Received: from smtprelay0045.hostedemail.com ([216.40.44.45]:60824 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731021AbeGNA24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 20:28:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 75017999D;
        Sat, 14 Jul 2018 00:12:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cover26_11651a50a7535
X-Filterd-Recvd-Size: 2235
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sat, 14 Jul 2018 00:11:59 +0000 (UTC)
Message-ID: <751491f9b9d7ce18f048ba44fbdb17d8c699e674.camel@perches.com>
Subject: Re: [PATCH] get_maintainer.pl: Add optional
 .get_maintainer.MAINTAINERS override
From:   Joe Perches <joe@perches.com>
To:     Don Zickus <dzickus@redhat.com>
Cc:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org,
        jtoppins@redhat.com
Date:   Fri, 13 Jul 2018 17:11:58 -0700
In-Reply-To: <20180713185109.hanjstgdvl2fw4ry@redhat.com>
References: <20180626182505.4176-1-prarit@redhat.com>
         <601f0e6bf3baa88b9f6145e635d728a435542292.camel@perches.com>
         <20180706175419.6irtvs64e6dbz7hk@redhat.com>
         <c187fe5040cb616292dab6c106352273df95bc41.camel@perches.com>
         <20180706184411.ilzbt7fxuje2nhx6@redhat.com>
         <716eb88d-31ac-c488-f799-dec9c9afb5af@redhat.com>
         <948af2d06623e8fcca6f0c0fd300a65bbfd1c6fa.camel@perches.com>
         <20180706215851.sqpibusyqukbh55g@redhat.com>
         <5ebb181efcdd2cdb3c1ee8eac9bba26f5759a0ea.camel@perches.com>
         <9efeba75a47e9b0c40d5b9e5078598ff4a31f196.camel@perches.com>
         <20180713185109.hanjstgdvl2fw4ry@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-13 at 14:51 -0400, Don Zickus wrote:
> On Fri, Jul 06, 2018 at 03:14:28PM -0700, Joe Perches wrote:
> > On Fri, 2018-07-06 at 15:09 -0700, Joe Perches wrote:
> > > On Fri, 2018-07-06 at 17:58 -0400, Don Zickus wrote:
> > > > We have an internal use case of multiple MAINTAINER files, some folks have
> > > > more rights to patches than others so they are not allowed to be cc'd (think
> > > > embargoed stuff).
> > 
> > How about:
> 
> Hi Joe,
> 
> You are probably busy with stuff, but wanted to softly poke you to see what
> is going on with this patch and if there is anything we can help with?

Hey Don.  No worries.

Tell me again if the --find-maintainer-files=<path or file> should
be exclusive or should it also read any existing MAINTAINERS file?

What if anything is wrong with what I suggested?

cheers, Joe

