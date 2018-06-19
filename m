Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18E3C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A37C20883
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxBp6KFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A37C20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755513AbeFSEcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 00:32:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750961AbeFSEcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 00:32:04 -0400
Received: from localhost (unknown [106.200.222.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB8E920874;
        Tue, 19 Jun 2018 04:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529382724;
        bh=OEjQCZ3w76+cv0xxvyIO440GT/9pkQAdGVxky81h9IM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fxBp6KFkKc1kAOijgR/3aM6lu0GRe4nHFSLfFCub7eGxafjzMJ8DCiPajkyFbvH0s
         O9haTOvTzllIs9aL9/xK8h0KQx2vL0zDNTDQMV9eR4K1y9cSf7MDwNjZPLPRaL0UFo
         l/oi+WyWQlCUk0ZRfPIbdd+wUqW3swFQL2vl4ndo=
Date:   Tue, 19 Jun 2018 10:01:56 +0530
From:   Vinod <vkoul@kernel.org>
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     dmaengine@vger.kernel.org, timur@codeaurora.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update email-id of Sinan Kaya
Message-ID: <20180619043156.GO25852@vkoul-mobl>
References: <1528983482-31028-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528983482-31028-1-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-06-18, 09:37, Sinan Kaya wrote:
> I'm no longer with QCOM. I am still interested in maintaining or reviewing
> PCI/DMA engine patches. Update email-id to an active one.

Applied, thanks

-- 
~Vinod
