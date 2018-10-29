Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5D3C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8DE2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8DE2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeJ2Kvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 06:51:32 -0400
Received: from smtprelay0243.hostedemail.com ([216.40.44.243]:52705 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728129AbeJ2Kvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 06:51:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id AE76752A4;
        Mon, 29 Oct 2018 02:05:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: need06_65d9d3a27641a
X-Filterd-Recvd-Size: 1831
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon, 29 Oct 2018 02:04:59 +0000 (UTC)
Message-ID: <381b8ca1faa35182cf57182a98484174f1b3d939.camel@perches.com>
Subject: Re: [PATCH 8/9] w1: fix whitespaces of struct declarations
From:   Joe Perches <joe@perches.com>
To:     Steffen Vogel <post@steffenvogel.de>
Cc:     linux-kernel@vger.kernel.org, Evgeniy Polyakov <zbr@ioremap.net>
Date:   Sun, 28 Oct 2018 19:04:58 -0700
In-Reply-To: <20181029020225.3i7wc2rg2omofzyb@cam.home.0l.dn42>
References: <20181028220927.56227-1-post@steffenvogel.de>
         <20181028220927.56227-9-post@steffenvogel.de>
         <795912c5ade5a813cf5c70d7085c14c24b553f1d.camel@perches.com>
         <20181029020225.3i7wc2rg2omofzyb@cam.home.0l.dn42>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-29 at 03:02 +0100, Steffen Vogel wrote:
> Hi Joe,
> 
> v2 of this patch set is almost ready.
> I reran checkpatch.pl with '--strict'. So more warnings will be fixed by
> the second version.
> 
> See my comments below.
> 
> On Sun, Oct 28, 2018 at 06:52:23PM -0700, Joe Perches wrote:
> > On Sun, 2018-10-28 at 23:09 +0100, Steffen Vogel wrote:
> > > This fixes a warning raised by the checkpatch tool.
> > 
> > checkpatch does not raise any whitespace errors on
> > this file.
> > 
> > It does suggest that braces could be moved.
> 
> Ah okay, I considered moving a brace also a whitespace change.
> Do you prefer the original indention of the struct members?
> I dont see it very often in kernel code.

The indentation doesn't matter to me.

The commit message description of a checkpatch warning
that does not exist is incorrect.



