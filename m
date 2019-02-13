Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C17C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E1B222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404887AbfBMSQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:16:44 -0500
Received: from verein.lst.de ([213.95.11.211]:44511 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730697AbfBMSQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:16:44 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 582B268C8E; Wed, 13 Feb 2019 19:16:41 +0100 (CET)
Date:   Wed, 13 Feb 2019 19:16:41 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org,
        arcml <linux-snps-arc@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org,
        SH-Linux <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/12] of: mark
 early_init_dt_alloc_reserved_memory_arch static
Message-ID: <20190213181641.GA19706@lst.de>
References: <20190211133554.30055-1-hch@lst.de> <20190211133554.30055-4-hch@lst.de> <CAL_JsqJ2Qt6=TTD250C9qW7Kv8rZn5PyB_C78FUhWwfgOnjPHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ2Qt6=TTD250C9qW7Kv8rZn5PyB_C78FUhWwfgOnjPHg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 02:24:19PM -0600, Rob Herring wrote:
> Looks like this one isn't a dependency, so I can take it if you want.

Sure, please go ahead.
