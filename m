Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69C4C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889D5205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889D5205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeJWOci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 10:32:38 -0400
Received: from smtprelay0242.hostedemail.com ([216.40.44.242]:35764 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726837AbeJWOci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 10:32:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 771D718017BF5;
        Tue, 23 Oct 2018 06:10:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: snail41_6067c9cebc48
X-Filterd-Recvd-Size: 1741
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Oct 2018 06:10:41 +0000 (UTC)
Message-ID: <a401f973508662fa241b1410e08480884baca606.camel@perches.com>
Subject: Re: [Ksummit-discuss] [GIT PULL] code of conduct fixes for 4.19-rc8
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <greg@kroah.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Date:   Mon, 22 Oct 2018 23:10:40 -0700
In-Reply-To: <800b68eb-9cf4-9c72-104d-0d4d9ae26ea1@infradead.org>
References: <1540066514.3464.22.camel@HansenPartnership.com>
         <20181022211025.GA8911@kroah.com>
         <23e41205115d317908c63d37a20ee316b44a8404.camel@perches.com>
         <800b68eb-9cf4-9c72-104d-0d4d9ae26ea1@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-22 at 23:05 -0700, Randy Dunlap wrote:
> On 10/22/18 9:16 PM, Joe Perches wrote:
> > As James Bottomley has suggested multiple times,
> > I'd much rather kernel development use the debian
> > code of conduct verbatim than even this modified one.
> > 
> > https://www.debian.org/code_of_conduct
> 
> Yes, that and the Samba URL are good.
> 
> And it's disappointing how patches from James are acked or reviewed on the
> mailing lists and then mostly ignored (until the maintainer summit) while
> other patches are merged into the mainline git tree.
> 
> It seems to be very one-sided.

Perhaps an apt description is 'cabal like'.

