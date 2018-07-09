Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDB8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5F420840
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5F420840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933649AbeGIRGO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:06:14 -0400
Received: from smtprelay0139.hostedemail.com ([216.40.44.139]:46646 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933287AbeGIRGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:06:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 84894180A812C;
        Mon,  9 Jul 2018 17:06:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: legs49_8d66dc93f4f0f
X-Filterd-Recvd-Size: 1528
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon,  9 Jul 2018 17:06:11 +0000 (UTC)
Message-ID: <58278ce28b15bf747d6945748a3ad93f997d3214.camel@perches.com>
Subject: Re: [PATCH] spdxcheck: Work with current HEAD LICENSES/ directory
From:   Joe Perches <joe@perches.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 09 Jul 2018 10:06:10 -0700
In-Reply-To: <alpine.DEB.2.21.1806052122120.1584@nanos.tec.linutronix.de>
References: <7eeefc862194930c773e662cb2152e178441d3b8.camel@perches.com>
         <alpine.DEB.2.21.1806052122120.1584@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-05 at 21:22 +0200, Thomas Gleixner wrote:
> On Tue, 5 Jun 2018, Joe Perches wrote:
> 
> > Depending on how old your -next tree is, it may
> > not have a master that has the LICENSES directory.
> > 
> > Change the lookup to HEAD and find whatever
> > LICENSE directory files are used in that branch.
> > 
> > Miscellanea:
> > 
> > o Remove the checkpatch test as it will have its own
> >   SPDX license identifier.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Can either of you apply this?

https://patchwork.kernel.org/patch/10448573/

