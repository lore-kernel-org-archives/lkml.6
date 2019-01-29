Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9726C282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A0E20870
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfA2Bcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 20:32:48 -0500
Received: from smtprelay0137.hostedemail.com ([216.40.44.137]:59405 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726678AbfA2Bcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 20:32:48 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 9811C18224D66;
        Tue, 29 Jan 2019 01:32:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crook68_522bca3377236
X-Filterd-Recvd-Size: 1836
Received: from XPS-9350 (cpe-75-82-193-221.socal.res.rr.com [75.82.193.221])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue, 29 Jan 2019 01:32:44 +0000 (UTC)
Message-ID: <9d085583a1d9a1068838f4333a2f12156f77d246.camel@perches.com>
Subject: Re: [PATCH][RFC] module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2"
 bogosity
From:   Joe Perches <joe@perches.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Christoph Hellwig <hch@lst.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Date:   Mon, 28 Jan 2019 17:32:42 -0800
In-Reply-To: <alpine.DEB.2.21.1901282105450.1669@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1901282105450.1669@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-28 at 23:38 +0100, Thomas Gleixner wrote:
> Therefore remove the well meant, but ill defined, distinction between "GPL"
> and "GPL v2" and document that:
> 
>   - "GPL" and "GPL v2" both express that the module is licensed under GPLv2
>     (without a distinction of 'only' and 'or later') and is therefore kernel
>     license compliant.
> 
>   - None of the MODULE_LICENSE strings can be used for expressing or
>     determining the exact license
> 
>   - Their sole purpose is to decide whether the module is free software or
>     not.

Thanks Thomas.

Acked-by: Joe Perches <joe@perches.com>

if you want that.


