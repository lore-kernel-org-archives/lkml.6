Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2796FC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE752075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE752075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934959AbeFRUFJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:05:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51008 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755364AbeFRUFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:05:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AB844207D4; Mon, 18 Jun 2018 22:05:05 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 64C78207A5;
        Mon, 18 Jun 2018 22:04:55 +0200 (CEST)
Date:   Mon, 18 Jun 2018 22:04:55 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 00/14] ARM: pxa: switch to DMA slave maps
Message-ID: <20180618220455.1810f2a5@bbrezillon>
In-Reply-To: <87d0wnrhqz.fsf@belgarion.home>
References: <20180617170217.24177-1-robert.jarzmik@free.fr>
        <20180618104159.24b9fffb@bbrezillon>
        <87d0wnrhqz.fsf@belgarion.home>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2018 21:56:20 +0200
Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> Boris Brezillon <boris.brezillon@bootlin.com> writes:
> 
> > Hi Robert,
> >
> > On Sun, 17 Jun 2018 19:02:03 +0200
> > Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> >  
> >> As I gathered almost all the required acks, this is an information only post
> >> before queuing to the PXA tree.  
> >
> > We'll need an immutable branch/tag containing those changes, just in
> > case other conflicting changes get submitted to the NAND driver.  
> Sure, this branch will be usable from next Wednesday onward, here :
>  - git fetch https://github.com/rjarzmik/linux.git
>    tags/pxa-for-4.19-dma_slave_map
> 
> I must insist on "Wednesday", as I need to have one last pass from 0-day kernel
> checker to be fully covered, and I'd like as well to know which tree the ASoC
> patch will take, ie. if Mark commits to take it, or rather wants to pull from
> the imutable branch.
> 
> Until Wednesday, even if the branch exist, consider it doesn't please, and
> Thursday morning you can pull if you wish.

Don't worry, we're not planning to merge it unless it happens to be
required (Stephen Rothwell reporting a merge conflict in next), and we
don't have conflicting changes in the pipeline so far.
