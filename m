Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADDFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B94218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n/4NymAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbeLSPRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:17:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51004 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729903AbeLSPRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PAClkGWQY+TyBVW4crUR175JeC7/HxJ/DfM4/M9tw+s=; b=n/4NymAjtnpmKJ/q3vr56j53F
        ZVPRKZrVF+/Cvf4w1f9h+X/ocQdI4jx1dKcvGpsmCDyxDmTCodxkyZqeB2m+bnn6Qnc9mNY35w6fc
        LCS842qh2u3hcSimQfykbvRuVmvbLQvl9MLlqNSNsHnKRel5mb8WGlcdUndW3+srLW8iomCxoIRWn
        azY6mu0VYCsT+1XK6bG/+8jAfS30l+f+7vl9TTpz6LdGxhqR+A6XE6OmbXCrHxwT2GyimXGrCz5lu
        D+3dJIf/iCa+lzECo1i8tFOq4nWp/WtmUER0Gc20JctMlx2x3AqNLB+EIAt2Yj2ItEgGucHqtMRh3
        f6ZVy972A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZdar-0003DQ-4K; Wed, 19 Dec 2018 15:17:05 +0000
Date:   Wed, 19 Dec 2018 07:17:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vishal Sagar <vsagar@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ASoC: xlnx: change license header format style
Message-ID: <20181219151704.GA5040@infradead.org>
References: <1545212440-109949-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545212440-109949-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 03:10:40PM +0530, Maruthi Srinivas Bayyavarapu wrote:
> Changed License header from C to C++ style comment block.

Why this completely pointless uglification that goes counter to
the common style all over the kernel?
