Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDB7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134C92082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392908AbfAPMzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:55:38 -0500
Received: from 8bytes.org ([81.169.241.247]:57954 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732803AbfAPMzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:55:38 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2CD1B273; Wed, 16 Jan 2019 13:55:36 +0100 (CET)
Date:   Wed, 16 Jan 2019 13:55:34 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/24] Tegra GART driver clean up and optimization
Message-ID: <20190116125534.354irioqwfu36ajj@8bytes.org>
References: <20181212203907.23461-1-digetx@gmail.com>
 <20181217091455.kkxpyojp4r4fyhrw@8bytes.org>
 <bbefe330-d3e8-3eea-0f9e-a2b0b7915120@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbefe330-d3e8-3eea-0f9e-a2b0b7915120@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 07:33:54PM +0300, Dmitry Osipenko wrote:
> Should I expect that the patches will appear in the IOMMU git and in
> -next consequently? Please let me know if there is any problem with
> the applying of the patches.

Hmm, I thought I applied these patches already, but obviously they
didn't show up in the iommu-tree. I have no idea how that happened, but
they are now applied.

Thanks for the reminder,

       Joerg
