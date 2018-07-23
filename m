Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D201ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE5820854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE5820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388963AbeGWNfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:35:52 -0400
Received: from verein.lst.de ([213.95.11.211]:48973 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388783AbeGWNfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:35:52 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E712468D52; Mon, 23 Jul 2018 14:38:12 +0200 (CEST)
Date:   Mon, 23 Jul 2018 14:38:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Fabio Coatti <fabio.coatti@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: iwlwifi problem with iommu/intel-iommu: Enable
        CONFIG_DMA_DIRECT_OPS=y and clean up intel_{alloc,free}_coherent()
Message-ID: <20180723123812.GA2715@lst.de>
References: <1537224.nkESeFtY4z@hobbes> <20180702131951.GA5786@lst.de> <2006717.WYUGMmW7i0@hobbes> <20180705193218.GA28794@lst.de> <CADpTngUNvFZefnoMHJUhWT0LL_OXHpSzgYF+XxKbceRvKhFSjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADpTngUNvFZefnoMHJUhWT0LL_OXHpSzgYF+XxKbceRvKhFSjQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 02:28:16PM +0200, Fabio Coatti wrote:
> Hi, any hope to see this backported to 4.17.X as well? Just to avoid to
> revert that commit at every new release :)

You can send the patch to stable@.
