Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033CDC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B711420C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B711420C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbeJIDLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 23:11:25 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:33061 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeJIDLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 23:11:25 -0400
X-Originating-IP: 134.134.139.76
Received: from localhost (unknown [134.134.139.76])
        (Authenticated sender: josh@joshtriplett.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 9164C24000A;
        Mon,  8 Oct 2018 19:57:56 +0000 (UTC)
Date:   Mon, 8 Oct 2018 12:57:51 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the ambiguity
 about collecting email addresses
Message-ID: <20181008195750.GA5367@localhost>
References: <1538861738.4088.5.camel@HansenPartnership.com>
 <1538861799.4088.6.camel@HansenPartnership.com>
 <20181008152043.GA5796@localhost>
 <1539012620.4344.5.camel@HansenPartnership.com>
 <20181008162357.7004ba48@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181008162357.7004ba48@coco.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 04:23:57PM -0300, Mauro Carvalho Chehab wrote:
> Em Mon, 08 Oct 2018 08:30:20 -0700
> James Bottomley <James.Bottomley@HansenPartnership.com> escreveu:
> 
> > On Mon, 2018-10-08 at 08:20 -0700, Josh Triplett wrote:
> > > On Sat, Oct 06, 2018 at 02:36:39PM -0700, James Bottomley wrote:  
> > > > The current code of conduct has an ambiguity in the it considers
> > > > publishing private information such as email addresses unacceptable
> > > > behaviour.  Since the Linux kernel collects and publishes email
> > > > addresses as part of the patch process, add an exception clause for
> > > > email addresses ordinarily collected by the project to correct this
> > > > ambiguity.  
> > > 
> > > Upstream has now adopted a FAQ, which addresses this and many other
> > > questions. See https://www.contributor-covenant.org/faq .
> > > 
> > > Might I suggest adding that link to the bottom of the document,
> > > instead? (And then, optionally, submitting entries for that FAQ.)  
> > 
> > We can debate that as part of everything else, but my personal opinion
> > would be we should never point to an outside document under someone
> > else's control for guidance as to how our community would enforce its
> > own code of conduct.
> 
> Fully agreed on that. The same argument that we use for GPL 2 only
> applies here: we should stick with an specific version of this it, in
> a way that we won't be automatically bound to whatever new version
> of it would say.

Linking to a FAQ with useful clarifications in it doesn't make those
"binding". This is *not* a legal agreement.
