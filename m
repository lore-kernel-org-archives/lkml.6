Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AFCECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DA72084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8DA72084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbeGSGtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 02:49:07 -0400
Received: from ozlabs.org ([203.11.71.1]:39719 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbeGSGtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 02:49:05 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41WNpf5qnDz9s78; Thu, 19 Jul 2018 16:07:38 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 00c376fdd7ed6cc083da3a3c51a63a75f270d647
In-Reply-To: <20180702074205.12837-1-aik@ozlabs.ru>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org
Subject: Re: [kernel] powerpc/powernv/ioda2: Add 256M IOMMU page size to the default POWER8 case
Message-Id: <41WNpf5qnDz9s78@ozlabs.org>
Date:   Thu, 19 Jul 2018 16:07:38 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 07:42:05 UTC, Alexey Kardashevskiy wrote:
> The sketchy bypass uses 256M pages so add this page size as well.
> 
> This should cause no behavioral change but will be used later.
> 
> Fixes: 477afd6ea6 "powerpc/ioda: Use ibm,supported-tce-sizes for IOMMU page size mask"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/00c376fdd7ed6cc083da3a3c51a63a

cheers
