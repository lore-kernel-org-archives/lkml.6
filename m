Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE63EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B667221848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfBSJWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:22:10 -0500
Received: from smtprelay0024.hostedemail.com ([216.40.44.24]:44880 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727736AbfBSJWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:22:09 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id A6E9A18030164;
        Tue, 19 Feb 2019 09:22:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: brain16_128ee52e8ea5b
X-Filterd-Recvd-Size: 1347
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 Feb 2019 09:22:07 +0000 (UTC)
Message-ID: <0cc49d981dac5a51d9810b58b95ea8ccf82f3a7b.camel@perches.com>
Subject: Re: [PATCH] checkpatch: warn on bad commit description in 'Fixes'
 tag
From:   Joe Perches <joe@perches.com>
To:     Changbin Du <changbin.du@gmail.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Tue, 19 Feb 2019 01:22:06 -0800
In-Reply-To: <20190219063611.19955-1-changbin.du@gmail.com>
References: <20190219063611.19955-1-changbin.du@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-19 at 06:36 +0000, Changbin Du wrote:
> There are some complaints about bad commit description in 'Fixes' tag.
> Most cases are SHA1 should be at least 12 digits long. Let's extend
> the existing check in checkpatch.pl to include commit description of
> 'Fixes' tag.

I sent a suggested patch a bit ago

https://lore.kernel.org/lkml/40bfc40958fca6e2cc9b86101153aa0715fac4f7.camel@perches.com/


