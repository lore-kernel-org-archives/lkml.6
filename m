Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E21CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 17:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C8020657
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 17:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p8g6+sRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfBWRLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 12:11:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55708 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfBWRLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 12:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3H66yYZF4gTjP8w372vLuOtWqbjp19r6sT0lQgeS9cE=; b=p8g6+sRqZMU+FwBYpoTzaFz72
        Ri4ra43L1rkxyzN6Uz+uf7qH+qB+DKylOsjCb/kcv4C+gPSEtmmAAZpV6sZvpeokOJkQqeTfCPFCM
        E9uSktumdN6VIMSt2NBopnatUJC/Gp2ewUSbI83Fn0nQi1fA07RWZx5gIKVOsM3dKQbpiBfeLco8O
        rXF2F0yHr+erNDnZ9iRBgUkZntjgJQ22tvW2sAQNoybeB6kgQD3moMvnMgB8b9aVZ9oK6H66FpnYC
        +Rg1gaLaxOBWQUcRr+pogf4J87ieMMZ0v2zMum/Qq8R/LYd0RJ6sEBSbld8lJroh/6sY4JlM/9+8C
        n2LXmLiBQ==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gxapH-0006Mx-WD; Sat, 23 Feb 2019 17:10:59 +0000
Date:   Sat, 23 Feb 2019 09:10:58 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the drivers-x86
 tree
Message-ID: <20190223171058.GA4722@wrath>
References: <20190224011925.6db87446@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190224011925.6db87446@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 01:19:25AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   9bfe33ba29d0 ("x86/CPU: Add Icelake model number")
> 
> is missing a Signed-off-by from its committer.

Thanks for the catch. Andy, please check your commit scripts as should
definitely be automated in our workflow.

I have corrected it.
-- 
Darren Hart
VMware Open Source Technology Center
