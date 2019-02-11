Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060D3C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24AA20844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfBKLJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 06:09:42 -0500
Received: from 8bytes.org ([81.169.241.247]:39396 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfBKLJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 06:09:42 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9AE8339A; Mon, 11 Feb 2019 12:09:40 +0100 (CET)
Date:   Mon, 11 Feb 2019 12:09:40 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/7] iommu: Minor cleanups and dev_printk() usage
Message-ID: <20190211110940.GC32526@8bytes.org>
References: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 04:05:33PM -0600, Bjorn Helgaas wrote:
> I've had these minor iommu cleanups lying around for a while, but the ugly
> dmesg logs from [1] prompted me to finally post them.  Take what you like,
> ignore the rest, and tell me so I can clear out my queue of old stuff.
> 
> These fix no actual bugs.
> 
> [1] https://lore.kernel.org/linux-pci/1547649064-19019-1-git-send-email-liudongdong3@huawei.com

Applied patches 1-6 to their respective branches, thanks Bjorn.
