Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DB2C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA3D24001
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="anllweMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA3D24001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932900AbeGFMSw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:18:52 -0400
Received: from 8bytes.org ([81.169.241.247]:53600 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932483AbeGFMSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:18:51 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 51295298; Fri,  6 Jul 2018 14:18:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1530879530; bh=peoSTd4TZv8mTkDgZedtdYchv/CRySqaMQ+hV4ZG/PQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=anllweMYzn+JSWA7JSSD+GzNQRNcTsWYnCbEjPauvFyHqkfBVGX3UNRa0Yul0T7gA
         BOPyf58nQa5VRnLUOhRljo4LBcvOhWX5Fb9CFfRy2RbmFnfwO0T/CgtQta7siiPcm0
         AQ/lu+vOVoqvo8u0s+BDI3dCMH2knkcGBdbC1KS0NMHLO2EYQZ0ZjVxuHqbsA2NQ2f
         67GXtgYjCM4NHTHCc91JiFJ7zYKGlR86QdvHQ65/ezCYr3oeEZBOTsK1YeDv1226qv
         WitFNlpeTvjUw09k2JU5kjtDk2Rk5KpZJoXTS9osFdGyoqY+Cincon8vZ5U4OKP6sG
         BWIeazq9QBTFA==
Date:   Fri, 6 Jul 2018 14:18:45 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Remove unnecessary WARN_ON()
Message-ID: <20180706121845.epkykop5br2a62gk@8bytes.org>
References: <1529376559-25759-1-git-send-email-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529376559-25759-1-git-send-email-baolu.lu@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:49:19AM +0800, Lu Baolu wrote:
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-svm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

