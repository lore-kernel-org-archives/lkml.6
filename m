Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA59AC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6924A2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6924A2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936834AbeFRT4X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:56:23 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:34940 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935743AbeFRT4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:56:22 -0400
Received: from belgarion ([90.55.203.186])
        by mwinf5d79 with ME
        id 0KwL1y00E41oiFu03KwL1u; Mon, 18 Jun 2018 21:56:21 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 18 Jun 2018 21:56:21 +0200
X-ME-IP: 90.55.203.186
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 00/14] ARM: pxa: switch to DMA slave maps
References: <20180617170217.24177-1-robert.jarzmik@free.fr>
        <20180618104159.24b9fffb@bbrezillon>
X-URL:  http://belgarath.falguerolles.org/
Date:   Mon, 18 Jun 2018 21:56:20 +0200
In-Reply-To: <20180618104159.24b9fffb@bbrezillon> (Boris Brezillon's message
        of "Mon, 18 Jun 2018 10:41:59 +0200")
Message-ID: <87d0wnrhqz.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boris Brezillon <boris.brezillon@bootlin.com> writes:

> Hi Robert,
>
> On Sun, 17 Jun 2018 19:02:03 +0200
> Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>
>> As I gathered almost all the required acks, this is an information only post
>> before queuing to the PXA tree.
>
> We'll need an immutable branch/tag containing those changes, just in
> case other conflicting changes get submitted to the NAND driver.
Sure, this branch will be usable from next Wednesday onward, here :
 - git fetch https://github.com/rjarzmik/linux.git
   tags/pxa-for-4.19-dma_slave_map

I must insist on "Wednesday", as I need to have one last pass from 0-day kernel
checker to be fully covered, and I'd like as well to know which tree the ASoC
patch will take, ie. if Mark commits to take it, or rather wants to pull from
the imutable branch.

Until Wednesday, even if the branch exist, consider it doesn't please, and
Thursday morning you can pull if you wish.

Cheers.

-- 
Robert
