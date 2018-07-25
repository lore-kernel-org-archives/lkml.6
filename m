Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1EDC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD1520671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD1520671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbeGYHn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 03:43:28 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:51039 "EHLO
        mail.osadl.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbeGYHn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 03:43:28 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id DE99C5C097D; Wed, 25 Jul 2018 06:31:37 +0000 (UTC)
Date:   Wed, 25 Jul 2018 06:31:37 +0000
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Graham Moore <grmoore@opensource.altera.com>,
        Vignesh R <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: spi-nor: cadence-quadspi: make return type fit
 wait_for_completion_timeout
Message-ID: <20180725063137.GB7194@osadl.at>
References: <1532189293-5975-1-git-send-email-hofrat@osadl.org>
 <20180724224626.777149ce@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724224626.777149ce@bbrezillon>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 10:46:26PM +0200, Boris Brezillon wrote:
> On Sat, 21 Jul 2018 18:08:13 +0200
> Nicholas Mc Guire <hofrat@osadl.org> wrote:
> 
> > wait_for_completion_timeout returns an unsigned long not int. declare a
> > suitably type timeout and fix up assignment and check.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Reported-by: Vignesh R <vigneshr@ti.com>
> > Fixes: 140623410536 ("mtd: spi-nor: Add driver for Cadence Quad SPI Flash Controller")
> 
> If you don't mind, I'd like to squash all wait_for_completion_timeout()
> fixes into a single commit.
>
makes sense - no objections to that at all.

thx!
hofrat 
