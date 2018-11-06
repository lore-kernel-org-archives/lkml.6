Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A25C46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B9C20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B9C20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389090AbeKGBUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:20:53 -0500
Received: from mailoutvs21.siol.net ([185.57.226.212]:46384 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388554AbeKGBUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:20:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 21FCE521900;
        Tue,  6 Nov 2018 16:54:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7ZLFe05Db-_r; Tue,  6 Nov 2018 16:54:58 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id ADE185218F4;
        Tue,  6 Nov 2018 16:54:58 +0100 (CET)
Received: from jernej-laptop.localnet (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id F37015218F0;
        Tue,  6 Nov 2018 16:54:56 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     wens@csie.org, robh+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, airlied@linux.ie, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 00/28] Allwinner H6 DE3 and HDMI support
Date:   Tue, 06 Nov 2018 16:54:56 +0100
Message-ID: <4663462.5OBby1Icb2@jernej-laptop>
In-Reply-To: <20181105094341.qedt7jvnxooiojki@flea>
References: <20181104182705.18047-1-jernej.skrabec@siol.net> <20181105094341.qedt7jvnxooiojki@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 05. november 2018 ob 10:43:41 CET je Maxime Ripard napisal(a):
> On Sun, Nov 04, 2018 at 07:26:37PM +0100, Jernej Skrabec wrote:
> > This series adds support for Display Engine 3.0 and HDMI 2.0a, which
> > can be found on H6 SoC.
> > 
> > Display Engine 3.0 in comparison to 2.0 mostly adds features needed for
> > displaying and processing 10-bit and AFBC formats, which are not yet
> > supported by this series.
> > 
> > H6 is also the first SoC which supports IOMMU, but support for it is
> > not yet added.
> > 
> > This series is based on linux-next at next-20181102.
> > 
> > I suggest all patches go through allwinner tree, except DRM patches,
> > which should go through drm-misc tree.
> 
> Applied all patches up to the 26. The two last one however should not
> use the clk bindings define you added in the first clk patches, since
> clk and dt patches are going through different tree.

Thanks!

Should I send remaining 2 patches as v4 or can be send separately?

Best regards,
Jernej



