Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6161C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1AA208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1AA208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeH1KuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 06:50:00 -0400
Received: from verein.lst.de ([213.95.11.211]:37578 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbeH1KuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 06:50:00 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0FBA868C46; Tue, 28 Aug 2018 09:02:18 +0200 (CEST)
Date:   Tue, 28 Aug 2018 09:02:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stefan Agner <stefan@agner.ch>
Cc:     linux@armlinux.org.uk, arnd@arndb.de, hch@lst.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: wire up io_pgetevents syscall
Message-ID: <20180828070217.GA10549@lst.de>
References: <20180827200505.21991-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827200505.21991-1-stefan@agner.ch>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 10:05:05PM +0200, Stefan Agner wrote:
> Wire up the new io_pgetevents syscall for ARM.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Looks good to me:

Acked-by: Christoph Hellwig <hch@lst.de>
