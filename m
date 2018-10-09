Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FADECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8B9214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8B9214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeJJCO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 22:14:57 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:42887 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbeJJCO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 22:14:57 -0400
X-Greylist: delayed 86220 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Oct 2018 22:14:56 EDT
Received: from localhost (jfdmzpr03-ext.jf.intel.com [134.134.139.72])
        (Authenticated sender: josh@joshtriplett.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id EA6AA240007;
        Tue,  9 Oct 2018 18:56:31 +0000 (UTC)
Date:   Tue, 9 Oct 2018 11:56:23 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Rainer Fiebig <jrf@mailbox.org>
Cc:     james.bottomley@hansenpartnership.com,
        linux-kernel@vger.kernel.org,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the ambiguity
 about collecting email addresses
Message-ID: <20181009185622.GA20960@localhost>
References: <1538861738.4088.5.camel@HansenPartnership.com>
 <1538861799.4088.6.camel@HansenPartnership.com>
 <20181008152043.GA5796@localhost>
 <1718828.OxLgMoHbrt@siriux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1718828.OxLgMoHbrt@siriux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 08:29:24PM +0200, Rainer Fiebig wrote:
> Am Montag, 8. Oktober 2018, 08:20:44 schrieb Josh Triplett:
> > On Sat, Oct 06, 2018 at 02:36:39PM -0700, James Bottomley wrote:
> > > The current code of conduct has an ambiguity in the it considers publishing
> > > private information such as email addresses unacceptable behaviour.  Since
> > > the Linux kernel collects and publishes email addresses as part of the patch
> > > process, add an exception clause for email addresses ordinarily collected by
> > > the project to correct this ambiguity.
> > 
> > Upstream has now adopted a FAQ, which addresses this and many other
> > questions. See https://www.contributor-covenant.org/faq .
> > 
> > Might I suggest adding that link to the bottom of the document, instead?
> > (And then, optionally, submitting entries for that FAQ.)
> > 
> 
> The Code of Conflict has 28 lines, including the heading. 
> The Code of Conduct has 81 lines, including the heading. And it needs a FAQ. Hm.

Yes, it turns out to be a more complicated problem than it was
previously oversimplified to. People don't automatically share a common
understanding.
