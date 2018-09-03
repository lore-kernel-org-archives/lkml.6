Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B0DC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5D520843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5D520843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbeICXHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:07:13 -0400
Received: from ms.lwn.net ([45.79.88.28]:49732 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727472AbeICXHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:07:13 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8B4674B7;
        Mon,  3 Sep 2018 18:45:46 +0000 (UTC)
Date:   Mon, 3 Sep 2018 12:45:45 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Henrik Austad <henrik@austad.us>
Cc:     Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] Drop all 00-INDEX files from Documentation/
Message-ID: <20180903124545.089ead51@lwn.net>
In-Reply-To: <20180903105542.GA9485@sisyphus.home.austad.us>
References: <1535545728-8402-1-git-send-email-henrik@austad.us>
        <58648986219ce0173ff45d34def0da9f9f34b55f.camel@perches.com>
        <20180903105542.GA9485@sisyphus.home.austad.us>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2018 12:55:42 +0200
Henrik Austad <henrik@austad.us> wrote:

> On Wed, Aug 29, 2018 at 09:20:30AM -0700, Joe Perches wrote:
> > On Wed, 2018-08-29 at 14:28 +0200, Henrik Austad wrote:  
> > > The 00-INDEX files are supposed to give a summary of all files present
> > > in a directory, but these files are horribly out of date and their
> > > usefulness is brought into question.
> > > 
> > > A few years back it was mentioned that these files were no longer
> > > needed, and they have since then grown further out of date, so perhaps
> > > it is time to just throw them out.  
> > 
> > Good idea.
> > 
> > .rst is becoming more common and these 00-INDEX files
> > are unnecessary and occasionally misleading.  
> 
> Ok, should I respin and clean up all the other files referencing 00-INDEX 
> and send to a wider audience?

Wider audience might be good.  I've not yet decided whether I think this
is a good idea or not.  We certainly don't need those files for stuff
that's in the RST doctree, that's what the index.rst files are for.  But I
suspect some people might complain about losing them for the rest of the
content.  I do get patches from people updating them, so some folks do
indeed look at them...

jon
