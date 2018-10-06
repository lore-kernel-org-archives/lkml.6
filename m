Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382A3C00449
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 00:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC95921473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 00:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC95921473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbeJFHi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 03:38:56 -0400
Received: from smtprelay0090.hostedemail.com ([216.40.44.90]:36976 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726399AbeJFHiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 03:38:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id EE038813E;
        Sat,  6 Oct 2018 00:37:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: soup12_2692f2d9d8c46
X-Filterd-Recvd-Size: 1253
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sat,  6 Oct 2018 00:37:44 +0000 (UTC)
Message-ID: <c53084c6be538d127db8b88dec4babc7eb7c6a9f.camel@perches.com>
Subject: Re: [PATCH] staging/rtlwifi: Fixing formatting warnings from
 checkpatch.pl.
From:   Joe Perches <joe@perches.com>
To:     Scott Tracy <scott.a.tracy@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Fri, 05 Oct 2018 17:37:43 -0700
In-Reply-To: <20181005225859.GA19554@hax0rtop>
References: <20181005225859.GA19554@hax0rtop>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-05 at 16:58 -0600, Scott Tracy wrote:
> Fixing formatting warnings in rtlwifi found by checkpatch.pl
> Changes include breaking up functions calls into multi line calls.
> No functional/logical changes. 

I believe the code is better before most of these changes.

There are various tradeoffs do source code formatting.

Here you are changing some alignment to open parentheses
and converting to < 80 columns.


