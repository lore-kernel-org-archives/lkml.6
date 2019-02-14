Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01092C10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EFF222D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439157AbfBNOCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:02:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52716 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389393AbfBNOCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:02:22 -0500
Received: from arch-x1c3 (unknown [IPv6:2a00:5f00:102:0:9665:9cff:feee:aa4d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: evelikov)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id DACCD260EB1;
        Thu, 14 Feb 2019 14:02:20 +0000 (GMT)
Date:   Thu, 14 Feb 2019 13:58:02 +0000
From:   Emil Velikov <emil.velikov@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.20 004/352] drm/vgem: Fix vgem_init to get drm device
 available.
Message-ID: <20190214135802.GB20918@arch-x1c3>
References: <20190211141846.543045703@linuxfoundation.org>
 <20190211141846.783223749@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211141846.783223749@linuxfoundation.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2019/02/11, Greg Kroah-Hartman wrote:
> 4.20-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> [ Upstream commit d5c04dff24870ef07ce6453a3f4e1ffd9cf88d27 ]
> 
> Modify vgem_init to take platform dev as parent in drm_dev_init.
> This will make drm device available at "/sys/devices/platform/vgem"
> in x86 chromebook.
> 
> v2: rebase, address checkpatch typo and line over 80 characters
> 
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Deepak Sharma <deepak.sharma@amd.com>
> Reviewed-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Link: https://patchwork.freedesktop.org/patch/msgid/20181023163550.15211-1-emil.l.velikov@gmail.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Zero objections to picking this for stable, although I'm curious what
flagged this commit as stable material.

Especially since it's closer to a feature than a bug-fix.

Can you share some light? Perhaps a link to a thread/document since I
would imagine you've been asked before.

Thanks
Emil
