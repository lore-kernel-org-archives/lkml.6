Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669FFC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D05E206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfAITft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:35:49 -0500
Received: from smtprelay0199.hostedemail.com ([216.40.44.199]:45188 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728202AbfAITfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:35:48 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 8D84B100E86C0;
        Wed,  9 Jan 2019 19:35:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: horse61_4f9089db27b3f
X-Filterd-Recvd-Size: 1456
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Wed,  9 Jan 2019 19:35:46 +0000 (UTC)
Message-ID: <f936ab2a7c34974c67ade29e97fe15bb5781ac39.camel@perches.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: fix bad file reference into
 Documentation
From:   Joe Perches <joe@perches.com>
To:     Otto Sabart <ottosabart@seberm.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Date:   Wed, 09 Jan 2019 11:35:45 -0800
In-Reply-To: <4b57943b57cb76af841015ec0ca04fd15f7e081f.1547060579.git.ottosabart@seberm.com>
References: <4b57943b57cb76af841015ec0ca04fd15f7e081f.1547060579.git.ottosabart@seberm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-09 at 20:09 +0100, Otto Sabart wrote:
> There is no `samsung,exynos5250-trng.txt` file in the documentation and
> I do not think it ever existed.

There was a patch for this

https://patchwork.kernel.org/patch/10623153/

But is is still unapplied...

> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -13309,7 +13309,6 @@ M:	Łukasz Stelmach <l.stelmach@samsung.com>
>  L:	linux-samsung-soc@vger.kernel.org
>  S:	Maintained
>  F:	drivers/char/hw_random/exynos-trng.c
> -F:	Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt


