Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8B1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF33120675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbfAPVpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:45:34 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:40052 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730413AbfAPVpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:45:33 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 0B57B804F1;
        Wed, 16 Jan 2019 22:45:30 +0100 (CET)
Date:   Wed, 16 Jan 2019 22:45:28 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: linux-next: Fixes tag needs some work in the drm-misc tree
Message-ID: <20190116214528.GA24059@ravnborg.org>
References: <20190117081351.661539c5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117081351.661539c5@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=B5kwd7KtsP0F6PBsUscA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

> Commit
> 
>   94520db52fc0 ("drm: fix alpha build after drm_util.h change")
> 
> has a malformed Fixes tag:
> 
>   Fixes: 733748ac37b45 ("drm: move drm_can_sleep() to drm_util.h")
> 
> The SHA1 does not reference a commit currently in the tree.  Maybe it
> was meant to be e9eafcb58921.

I can confirm that Stephen is right and that e9eafcb58921 is the proper SHA-1.
I guess the SHA-1 I used was from a rebased tree.
The mails from 0-DAY used the correct SHA-1 - which should have been a hint to me.

Sigh

	Sam
