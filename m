Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797B1C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9B7223B2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9B7223B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754251AbeGEQFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:05:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58497 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753868AbeGEQFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:05:40 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id bcc98e74f8a8d8f0; Thu, 5 Jul 2018 18:05:38 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add myself as driver core changes reviewer
Date:   Thu, 05 Jul 2018 18:04:12 +0200
Message-ID: <4953969.8lZNsc232p@aspire.rjw.lan>
In-Reply-To: <20180705160225.GA7430@kroah.com>
References: <69592383.djb3pJg15x@aspire.rjw.lan> <6788986.P6xlqFbtdJ@aspire.rjw.lan> <20180705160225.GA7430@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 5, 2018 6:02:25 PM CEST Greg Kroah-Hartman wrote:
> On Thu, Jul 05, 2018 at 05:56:17PM +0200, Rafael J. Wysocki wrote:
> > On Thursday, July 5, 2018 5:19:07 PM CEST Greg Kroah-Hartman wrote:
> > > On Thu, Jul 05, 2018 at 12:27:53PM +0200, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > > 
> > > > I really need to look at driver core changes before they are applied
> > > > due to PM dependencies and they sometimes get lost in the LKML
> > > > traffic, so add myself as an official driver core reviewer.
> > > 
> > > YES!!!
> > > 
> > 
> > So I'm assuming that you are going to apply it? ;-)
> > 
> 
> Already queued up, I'm not going to let that chance go by :)
> 
> thanks again for doing this, much appreciated.

You're very welcome. :-)

