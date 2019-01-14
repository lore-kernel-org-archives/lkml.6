Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D7FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34A4205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfANL3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:29:19 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59774 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbfANL3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:29:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6829380D;
        Mon, 14 Jan 2019 03:29:18 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 382E13F5BD;
        Mon, 14 Jan 2019 03:29:18 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 933AC68012C; Mon, 14 Jan 2019 11:29:16 +0000 (GMT)
Date:   Mon, 14 Jan 2019 11:29:16 +0000
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the mali-dp tree
Message-ID: <20190114112916.GN20661@e110455-lin.cambridge.arm.com>
References: <20190114110909.39a7285c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190114110909.39a7285c@canb.auug.org.au>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 11:09:09AM +1100, Stephen Rothwell wrote:
> Hi Liviu,

Hi Stephen,

> 
> Commits
> 
>   31849148cb41 ("drm/komeda: Add komeda_framebuffer")
>   b347a024e10b ("drm/komeda: Add komeda_format_caps for format handling")
>   274d16527e45 ("drm/komeda: Add DT parsing")
>   f20978344694 ("drm/komeda: Build komeda to be a platform module")
>   f8eff4b21a16 ("drm/arm: Delete redundant CONFIG_DRM_ARM")
> 
> are missing a Signed-off-by from their committer.

Sorry about that! I have now fixed those commits and also the build
failure you were seeing.

Best regards,
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
