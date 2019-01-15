Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C35C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEA420866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfAONLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:11:18 -0500
Received: from verein.lst.de ([213.95.11.211]:52966 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729178AbfAONLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:11:18 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1486B67358; Tue, 15 Jan 2019 14:11:17 +0100 (CET)
Date:   Tue, 15 Jan 2019 14:11:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix PCI kconfig menu organization
Message-ID: <20190115131116.GA28672@lst.de>
References: <20190114213546.9921-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114213546.9921-1-robh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 03:35:46PM -0600, Rob Herring wrote:
> After commit eb01d42a7778 ("PCI: consolidate PCI config entry in
> drivers/pci"), all the PCI kconfig options appear below "PCI support"
> rather than within a sub-menu. This is because menuconfig expects all
> kconfig entries to be enclosed in an if/endif section. Add the missing
> if/endif.
> 
> With this, "depends on PCI" is redundant in the sub-menu  entries and
> can be removed.

Thanks, this looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
