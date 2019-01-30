Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133C4C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8D2205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548862200;
	bh=IXgzgPI1HHyYdEP5PJixV7WwTg2x7VC9pHLBFT0zbTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kPCRZkMKBig0z4C3BnmpqI9n1xu3j8eVbWjCeFJrsgIaG9BQuytVQAAaf4HgN/UWR
	 hvPToM5+ejqOmskmIedhZ7udVGKDdsWUP5l+kgycUjhehdSSdnnugEjzIYBfaX3aUE
	 mnyzKCI/x+4OlCmbB+wbPdOkSK6ufLessTJo3log=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbfA3P37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:29:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:35590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbfA3P37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:29:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37AE9205C9;
        Wed, 30 Jan 2019 15:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548862198;
        bh=IXgzgPI1HHyYdEP5PJixV7WwTg2x7VC9pHLBFT0zbTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fs8YZApBs2jFVZzSUXIg74H1W73LNFl6Bl++1JoUY1booKCMgMZpWomZdQRANqMkO
         z60EB1jQWDvvIse25Q3j3bNuHUK/PSivLTaRFdZ8D7/b/bAdE0RBgh2V5XY3ouYqoA
         g4tX+xnN5Vvpb5OGXVms5Wc0jJWKLLJWTQ5fjGYg=
Date:   Wed, 30 Jan 2019 16:29:56 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Carlos Henrique Lima Melara <charlesmelara@outlook.com>
Cc:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "neil@brown.name" <neil@brown.name>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] staging: mt7621-eth/ethtool.c: Correction of SPDX
 license identifier
Message-ID: <20190130152956.GA4195@kroah.com>
References: <SC1P15201MB2014C3E0CAB4DA9ADF330797A8900@SC1P15201MB2014.LAMP152.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SC1P15201MB2014C3E0CAB4DA9ADF330797A8900@SC1P15201MB2014.LAMP152.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 02:48:27PM +0000, Carlos Henrique Lima Melara wrote:
> 	This patch fix the checkpatch.p1 warning:
> 
> 	WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> 	+/*

Why did you not fix up the indentation that was already mentioned?

> 	It includes the SPDX expression for GPL-2.0 and corrects the comment format to suit the kernel's coding style.

Always properly line-wrap your comments.

> 
> Signed-off-by: Carlos (Charles) Henrique Lima Melara <charlesmelara@outlook.com>

This needs to match your "From:" line.

thanks,

greg k-h
