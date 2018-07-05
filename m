Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E12C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BDB24004
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BDB24004
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753749AbeGEP5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:57:47 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48478 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753363AbeGEP5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:57:46 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 6bbbebd846b73dd4; Thu, 5 Jul 2018 17:57:43 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add myself as driver core changes reviewer
Date:   Thu, 05 Jul 2018 17:56:17 +0200
Message-ID: <6788986.P6xlqFbtdJ@aspire.rjw.lan>
In-Reply-To: <20180705151907.GB11929@kroah.com>
References: <69592383.djb3pJg15x@aspire.rjw.lan> <20180705151907.GB11929@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 5, 2018 5:19:07 PM CEST Greg Kroah-Hartman wrote:
> On Thu, Jul 05, 2018 at 12:27:53PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > 
> > I really need to look at driver core changes before they are applied
> > due to PM dependencies and they sometimes get lost in the LKML
> > traffic, so add myself as an official driver core reviewer.
> 
> YES!!!
> 

So I'm assuming that you are going to apply it? ;-)


