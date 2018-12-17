Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3AEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C9A2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbeLQJRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:17:50 -0500
Received: from 8bytes.org ([81.169.241.247]:54462 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbeLQJRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:17:50 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 214BE3F4; Mon, 17 Dec 2018 10:17:49 +0100 (CET)
Date:   Mon, 17 Dec 2018 10:17:47 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v4 1/1] dt-bindings: arm-smmu: Add binding doc for
 Qcom smmu-500
Message-ID: <20181217091747.dgo65nejzviadklv@8bytes.org>
References: <20181213090507.6269-1-vivek.gautam@codeaurora.org>
 <20181213104524.GA31177@edgewater-inn.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213104524.GA31177@edgewater-inn.cambridge.arm.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 10:45:24AM +0000, Will Deacon wrote:
> Joerg -- please can you take this on top of the pull request I sent already?
> Vivek included it as part of a separate series which I thought was going
> via arm-soc, but actually it needs to go with the other arm-smmu patches
> in order to avoid conflicts.

Applied, thanks.
