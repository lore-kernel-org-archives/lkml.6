Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0204C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61DE2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfBHLbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:31:48 -0500
Received: from gloria.sntech.de ([185.11.138.130]:36846 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbfBHLbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:31:48 -0500
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gs4Ng-0008Df-7r; Fri, 08 Feb 2019 12:31:40 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sandy Huang <hjc@rock-chips.com>
Subject: Re: linux-next: Fixes tag needs some work in the drm-fixes tree
Date:   Fri, 08 Feb 2019 12:31:38 +0100
Message-ID: <2145777.rZLEu8YqWI@diego>
In-Reply-To: <20190208220137.3b72799a@canb.auug.org.au>
References: <20190208220137.3b72799a@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 8. Februar 2019, 12:01:37 CET schrieb Stephen Rothwell:
> Hi all,
> 
> In commit
> 
>   053ff09f1a8f ("drm/rockchip: rgb: update SPDX license identifier")
> 
> Fixes tag
> 
>   Fixes: 1f0f01515172 ("Add support for Rockchip Soc RGB output interface")
> 
> has these problem(s):
> 
>   - Subject does not match target commit subject

we had this warning already from the drm-misc-fixes tree :-) .

And the drm-* history is very much fixed (due to it being a shared tree)
so we'll probably have to live with that mistake I made (missing the
"drm/rockchip:" prefix from the subject). But as I said the other time,
it should hopefully be still be identifiable.


Heiko





