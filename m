Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B21C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 04:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDBE24099
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 04:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DDBE24099
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbeF2EOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 00:14:23 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:33798 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbeF2EOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 00:14:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 468EF28D70;
        Fri, 29 Jun 2018 00:14:18 -0400 (EDT)
Date:   Fri, 29 Jun 2018 14:15:21 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Christoph Hellwig <hch@lst.de>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nubus: Set default dma mask for nubus_board devices
In-Reply-To: <20180628142713.GA16044@lst.de>
Message-ID: <alpine.LNX.2.21.1806291411150.8@nippy.intranet>
References: <142066981b41910f4e645590a8b1734a1ea72fb8.1529926655.git.fthain@telegraphics.com.au> <20180628142713.GA16044@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2018, Christoph Hellwig wrote:

> On Mon, Jun 25, 2018 at 09:46:11PM +1000, Finn Thain wrote:
> > A 32-bit mask is used by default because a NuBus slot has 32 
> > address/data lines and a NuBus board is free to use all of them.
> 
> Looks good:

Thanks for looking it over. But did you forget to include an 
acked-by/reviewed-by tag?

-- 
