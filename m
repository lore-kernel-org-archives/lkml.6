Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B318C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B3C2175B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbfBDSm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:42:56 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:43401 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfBDSm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:42:56 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id A65E82001E;
        Mon,  4 Feb 2019 19:42:52 +0100 (CET)
Date:   Mon, 4 Feb 2019 19:42:51 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Joe Perches <joe@perches.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/19] drm/panel: drmP.h removal and DRM_DEV*
Message-ID: <20190204184251.GA2834@ravnborg.org>
References: <20190131192619.9763-1-sam@ravnborg.org>
 <20190131200723.GZ114153@art_vandelay>
 <20190131210312.GA8947@ravnborg.org>
 <20190131215417.GA13156@mithrandir>
 <20190201133704.GA25680@ravnborg.org>
 <7399cb84e16538d6ff7c8b4f7718b692c831476b.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7399cb84e16538d6ff7c8b4f7718b692c831476b.camel@perches.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=wfCFqB2ZVZZljlFqULsA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe.

> My preference would also convert all the
> DRM_DEV_<level> uses to drm_dev_<level> eventually.
> 
> Also, the macros themselves could change to use a
> more consistent mechanism.
> 
> This would make the drm logging mechanisms more like
> other logging mechanisms used in the kernel.
> 
> Something like:

I like your patch, but do not have the time to follow-up on it.
It is for now saved and I will re-visit it when I have a bit more
time on my hands.

Thanks,

	Sam
