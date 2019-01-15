Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E9BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE5E20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfAOKvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:51:05 -0500
Received: from foss.arm.com ([217.140.101.70]:47826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728642AbfAOKvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:51:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D78E51596;
        Tue, 15 Jan 2019 02:51:04 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A81443F70D;
        Tue, 15 Jan 2019 02:51:04 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 03A036801F9; Tue, 15 Jan 2019 10:51:02 +0000 (GMT)
Date:   Tue, 15 Jan 2019 10:51:02 +0000
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "James Qian Wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mali-dp tree
Message-ID: <20190115105102.GQ20661@e110455-lin.cambridge.arm.com>
References: <20190115104619.516be4b9@canb.auug.org.au>
 <20190115101219.GP20661@e110455-lin.cambridge.arm.com>
 <20190115214725.360798cf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190115214725.360798cf@canb.auug.org.au>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 09:47:25PM +1100, Stephen Rothwell wrote:
> Hi Liviu,
> 
> On Tue, 15 Jan 2019 10:12:19 +0000 Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> >
> > That looks like the right fix, thank you for that!
> 
> Thanks for your verification.
> 
> > I will roll your patch into my tree.
> 
> You can only do that when your tree is merged with the drm tree (and
> it should be part of the merge resolution).

I can also rebase on top of the latest drm-next tree, that should not be
a problem.

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
