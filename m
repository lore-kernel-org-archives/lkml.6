Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B196CC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA7623FD2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA7623FD2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754074AbeGFOmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:42:46 -0400
Received: from smtprelay0136.hostedemail.com ([216.40.44.136]:60968 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753839AbeGFOmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:42:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 70383182CF668;
        Fri,  6 Jul 2018 14:42:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: gate90_17a91cb2a2f0c
X-Filterd-Recvd-Size: 2036
Received: from XPS-9350 (mbb2736d0.tmodns.net [208.54.39.187])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Jul 2018 14:42:42 +0000 (UTC)
Message-ID: <67152e68ebe906b8dbb192efbc2fe0cf8fe9a4bb.camel@perches.com>
Subject: Re: [PATCH 2/6] device: Add #define dev_fmt similar to #define
 pr_fmt
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 06 Jul 2018 07:42:39 -0700
In-Reply-To: <20180706133808.GC1466@kroah.com>
References: <cover.1525878372.git.joe@perches.com>
         <3f213f4f9ee604c1797af67360d8da1836b34271.1525878372.git.joe@perches.com>
         <53ed025e7f188c931b99f83066457b2266e69cd6.camel@perches.com>
         <35e73723b9f982a400d5313df405972c09f9b374.camel@perches.com>
         <20180625005142.GB23869@kroah.com>
         <4ec61ff7041d5e68b8bce48c58b54129da701ea4.camel@perches.com>
         <20180706133808.GC1466@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-06 at 15:38 +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 05, 2018 at 03:57:56PM -0700, Joe Perches wrote:
> > On Mon, 2018-06-25 at 08:51 +0800, Greg Kroah-Hartman wrote:
> > > On Sun, Jun 24, 2018 at 08:41:03AM -0700, Joe Perches wrote:
> > > > On Tue, 2018-06-19 at 06:31 -0700, Joe Perches wrote:
> > > > > Greg?  Ping?
> > > > > 
> > > > > The patches to impi have hit -next and the impi code
> > > > > works differently without this patch.
> > > > 
> > > > Greg?
> > > > 
> > > > You are listed as the maintainer for this subsystem.
> > > > Do you want me to  get this applied via someone else?
> > > 
> > > I am traveling in Asia right now, please give me a chance to catch up on
> > > patches...
> > 
> > Caught up yet?
> 
> Nope!

The patch was sent May 9th.

https://lkml.org/lkml/2018/5/9/610

I think it's well past the time
for you to be able to review and
apply it.

