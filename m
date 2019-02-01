Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC079C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9564A21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbfBANhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:37:10 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:56029 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBANhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:37:09 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id B24A380482;
        Fri,  1 Feb 2019 14:37:05 +0100 (CET)
Date:   Fri, 1 Feb 2019 14:37:04 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/19] drm/panel: drmP.h removal and DRM_DEV*
Message-ID: <20190201133704.GA25680@ravnborg.org>
References: <20190131192619.9763-1-sam@ravnborg.org>
 <20190131200723.GZ114153@art_vandelay>
 <20190131210312.GA8947@ravnborg.org>
 <20190131215417.GA13156@mithrandir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131215417.GA13156@mithrandir>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=jsBZzwoqWuWrMCgolwsA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry.

> I'm slightly on the fence about this patch.

Please ignore patch 3-19, there is no consensus on the logging changes.
We do not want to apply these and then have to redo parts/all of
it later.

But the first two patches has not seen any feedback yet:

    [PATCH v1 01/19] drm/panel: drop drmP.h usage
    [PATCH v1 02/19] drm/panel: panel-innolux: drop unused variable

Please consider these, or maybe wait a little to see if someone
find time to review.

I can resend the patches if this is preferred.

	Sam
