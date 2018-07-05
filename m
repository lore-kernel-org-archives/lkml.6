Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBD3C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3B422535
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3B422535
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753483AbeGEW6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 18:58:01 -0400
Received: from smtprelay0041.hostedemail.com ([216.40.44.41]:57491 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753001AbeGEW6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 18:58:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 86FA2181D341D;
        Thu,  5 Jul 2018 22:57:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mass08_45ae2635e613b
X-Filterd-Recvd-Size: 1572
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu,  5 Jul 2018 22:57:58 +0000 (UTC)
Message-ID: <4ec61ff7041d5e68b8bce48c58b54129da701ea4.camel@perches.com>
Subject: Re: [PATCH 2/6] device: Add #define dev_fmt similar to #define
 pr_fmt
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 05 Jul 2018 15:57:56 -0700
In-Reply-To: <20180625005142.GB23869@kroah.com>
References: <cover.1525878372.git.joe@perches.com>
         <3f213f4f9ee604c1797af67360d8da1836b34271.1525878372.git.joe@perches.com>
         <53ed025e7f188c931b99f83066457b2266e69cd6.camel@perches.com>
         <35e73723b9f982a400d5313df405972c09f9b374.camel@perches.com>
         <20180625005142.GB23869@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-25 at 08:51 +0800, Greg Kroah-Hartman wrote:
> On Sun, Jun 24, 2018 at 08:41:03AM -0700, Joe Perches wrote:
> > On Tue, 2018-06-19 at 06:31 -0700, Joe Perches wrote:
> > > Greg?  Ping?
> > > 
> > > The patches to impi have hit -next and the impi code
> > > works differently without this patch.
> > 
> > Greg?
> > 
> > You are listed as the maintainer for this subsystem.
> > Do you want me to  get this applied via someone else?
> 
> I am traveling in Asia right now, please give me a chance to catch up on
> patches...

Caught up yet?

