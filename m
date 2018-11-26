Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70073C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D78B2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D78B2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbeKZWzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:55:35 -0500
Received: from gloria.sntech.de ([185.11.138.130]:55420 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbeKZWzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:55:35 -0500
Received: from we0660.dip.tu-dresden.de ([141.76.178.148] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gRFa4-00009j-22; Mon, 26 Nov 2018 13:01:36 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Otavio Salvador <otavio.salvador@ossystems.com.br>
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Kernel development list <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ARM: dts: rv1108: enable eMMC support
Date:   Mon, 26 Nov 2018 13:01:35 +0100
Message-ID: <64323039.5I5JKdABON@phil>
In-Reply-To: <CAP9ODKoVG0ceSdRdpMz705=a9Wh0vubE6=ja=bwSF35ORzVOwA@mail.gmail.com>
References: <20181125211427.4926-1-otavio@ossystems.com.br> <2374110.cSv9E7W1qs@phil> <CAP9ODKoVG0ceSdRdpMz705=a9Wh0vubE6=ja=bwSF35ORzVOwA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 26. November 2018, 12:58:49 CET schrieb Otavio Salvador:
> On Mon, Nov 26, 2018 at 7:03 AM Heiko Stuebner <heiko@sntech.de> wrote:
> > Am Sonntag, 25. November 2018, 22:14:27 CET schrieb Otavio Salvador:
> > > Enable eMMC support for rv1108.dtsi as it can be used across multiple
> > > boards.
> > >
> > > Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> >
> > applied for 4.21 after reordering the emmc pinctrl nodes a bit
> > and modifying the suject + commit message to be a bit more specific
> > in that we only add the common pin settings.
> 
> Which tree is it applied? I'd like to rebase the patches on top of it.

https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/

and now also pushed to there.


Heiko


