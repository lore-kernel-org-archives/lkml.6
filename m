Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B63C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBC724018
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CBC724018
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753845AbeGEQC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:02:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59016 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753317AbeGEQC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:02:28 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BCECAC74;
        Thu,  5 Jul 2018 16:02:27 +0000 (UTC)
Date:   Thu, 5 Jul 2018 18:02:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add myself as driver core changes reviewer
Message-ID: <20180705160225.GA7430@kroah.com>
References: <69592383.djb3pJg15x@aspire.rjw.lan>
 <20180705151907.GB11929@kroah.com>
 <6788986.P6xlqFbtdJ@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6788986.P6xlqFbtdJ@aspire.rjw.lan>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 05:56:17PM +0200, Rafael J. Wysocki wrote:
> On Thursday, July 5, 2018 5:19:07 PM CEST Greg Kroah-Hartman wrote:
> > On Thu, Jul 05, 2018 at 12:27:53PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > 
> > > I really need to look at driver core changes before they are applied
> > > due to PM dependencies and they sometimes get lost in the LKML
> > > traffic, so add myself as an official driver core reviewer.
> > 
> > YES!!!
> > 
> 
> So I'm assuming that you are going to apply it? ;-)
> 

Already queued up, I'm not going to let that chance go by :)

thanks again for doing this, much appreciated.

greg k-h
