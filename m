Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A698C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F822089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F822089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbeJQBDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:03:07 -0400
Received: from smtprelay0106.hostedemail.com ([216.40.44.106]:42909 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727263AbeJQBDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:03:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 219C01804A321;
        Tue, 16 Oct 2018 17:11:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wish21_8372314a88721
X-Filterd-Recvd-Size: 2392
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 16 Oct 2018 17:11:43 +0000 (UTC)
Message-ID: <bbef856ec1671776f7b72107620beb6b4b2b16f5.camel@perches.com>
Subject: Re: patch "staging: MAINTAINERS: remove obsolete IPX staging
 directory" added to staging-testing
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Date:   Tue, 16 Oct 2018 10:11:41 -0700
In-Reply-To: <20181016115137.GA28641@kroah.com>
References: <15396867728666@kroah.com>
         <249981aa5af26de07565946fbe806e3c01f26c07.camel@perches.com>
         <20181016115137.GA28641@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-16 at 13:51 +0200, Greg KH wrote:
> On Tue, Oct 16, 2018 at 04:43:30AM -0700, Joe Perches wrote:
> > On Tue, 2018-10-16 at 12:46 +0200, gregkh@linuxfoundation.org wrote:
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     staging: MAINTAINERS: remove obsolete IPX staging directoryts
> > []
> > > From dd71c89b2c1ae049d2018107e9d7a41261db3f7b Mon Sep 17 00:00:00 2001
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Date: Tue, 16 Oct 2018 12:45:13 +0200
> > > Subject: staging: MAINTAINERS: remove obsolete IPX staging directory
> > > 
> > > The IPX code was removed from staging back in November 2017, but the
> > > MAINTAINERS entry stuck around.  Remove the invalid directory from the
> > > file as it does not actually point to anything anymore.
> > 
> > As the uapi ipx file still exists but the functionality
> > has been removed, perhaps some compiler message like
> > 
> > #pragma message "IPX functionality removed as of linux kernel v4.18"
> > 
> > should be added to the uapi file.
> 
> Eventually those files should be removed by the networking developers.
> It will take a bit of work for them to do it, it's not a straight
> "delete the file" work.

I understand that, but it's not the point.

#pragma message might still be useful because,
in the meantime, anyone
actually including the
uapi file would get some heads-up notification
that IPX doesn't work here anymore.


