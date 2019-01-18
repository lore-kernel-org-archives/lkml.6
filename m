Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74735C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D38020855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfARKoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:44:01 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54454 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfARKoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:44:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B3E1EBD;
        Fri, 18 Jan 2019 02:44:00 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B4453F557;
        Fri, 18 Jan 2019 02:44:00 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id AEEB4682081; Fri, 18 Jan 2019 10:43:58 +0000 (GMT)
Date:   Fri, 18 Jan 2019 10:43:58 +0000
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "James Qian Wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: Re: linux-next: build warning after merge of the mali-dp tree
Message-ID: <20190118104358.GG20661@e110455-lin.cambridge.arm.com>
References: <20190118112811.091dd962@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190118112811.091dd962@canb.auug.org.au>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 11:28:11AM +1100, Stephen Rothwell wrote:
> Hi Liviu,
> 
> After merging the mali-dp tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> drivers/gpu/drm/arm/display/komeda/komeda_dev.c: In function 'komeda_parse_dt':
> drivers/gpu/drm/arm/display/komeda/komeda_dev.c:52:26: warning: unused variable 'pdev' [-Wunused-variable]
>   struct platform_device *pdev = to_platform_device(dev);
>                           ^~~~
> 
> Introduced by commit
> 
>   7e8d4fcf8daf ("drm: arm/komeda: Remove IRQ parsing from initial series")

Argh, sorry about that! I'll get it fixed!

Thanks for reporting it,
Liviu

> 
> -- 
> Cheers,
> Stephen Rothwell



-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
