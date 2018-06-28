Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506C0C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF24F224DD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF24F224DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932085AbeF1ESk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:18:40 -0400
Received: from smtprelay0113.hostedemail.com ([216.40.44.113]:53322 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751981AbeF1ESh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:18:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 40D27180273EA;
        Thu, 28 Jun 2018 04:18:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: north95_4afe6fda00e0c
X-Filterd-Recvd-Size: 1441
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Jun 2018 04:18:35 +0000 (UTC)
Message-ID: <2b13e28cea3a62bb57eb24a164772ea46a9fb6d3.camel@perches.com>
Subject: Re: [PATCH] proc: condemn myself to MAINTAINERS
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Date:   Wed, 27 Jun 2018 21:18:34 -0700
In-Reply-To: <20180627181300.49a572fe9fd28694e9102f5f@linux-foundation.org>
References: <20180627194840.GA18113@avx2>
         <99aa610d5052b986dca67daaa7e102a57096bd42.camel@perches.com>
         <20180627181300.49a572fe9fd28694e9102f5f@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-27 at 18:13 -0700, Andrew Morton wrote:
> On Wed, 27 Jun 2018 18:05:35 -0700 Joe Perches <joe@perches.com> wrote:
> 
> > On Wed, 2018-06-27 at 22:48 +0300, Alexey Dobriyan wrote:
> > > I know I'll regret it.
> > 
> > This wasn't applied back in February?
> 
> Well I thought it was, but I can't find such a patch anywhere.

https://patchwork.kernel.org/patch/10196137/

btw:

Isn't your mail archive the seed file for the new lkml archive?
https://www.kernel.org/lore.html

Maybe there are gaps there too?

