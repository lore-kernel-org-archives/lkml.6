Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761ACC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 08:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1339520854
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 08:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogld0CO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1339520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbeKDSI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 13:08:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:59870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728890AbeKDSI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 13:08:57 -0500
Received: from tiger (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0BB62082E;
        Sun,  4 Nov 2018 08:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541321684;
        bh=pJApnj1PaQMT8EJ7WPDoVtwBYbAPqD8vff3OW0xqD/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ogld0CO/MVDSpKFz1w7uXz0lKEWSblOSJ9ntImOhLnwQ8JExDN2meJiNuID34tmQg
         flwccGRZHnzMDzBwhnFj7ya3+BDDKpp5eyGYq/Nx2f8u3LFPjsbOBMaxqxotYF+4rh
         zTiadvEDKediOjOr/v7imtgZAUeAa8MkM0VLoa9o=
Date:   Sun, 4 Nov 2018 16:54:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alex Gonzalez <alex.gonzalez@digi.com>
Cc:     thierry.reding@gmail.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 0/4] ARM: dts: ccimx6ulsbcpro: Add 10" AUO/Goodix LVDS
 panel accessory kit
Message-ID: <20181104085425.GG26016@tiger>
References: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 05:09:29PM +0200, Alex Gonzalez wrote:
> Alex Gonzalez (4):
>   drm/panel: simple: Add AUO G101EVN010 panel support
>   ARM: dts: ccimx6ulsbcpro: Enable AUO G101EVN010 lcdif panel
>   ARM: imx_v6_v7_defconfig: Select TOUCHSCREEN_GOODIX
>   ARM: dts: ccimx6ulsbcpro: Add support for Goodix touch controller

It looks good to me.  Ping me when the patch #1 gets accepted and I
will apply the test then.

Shawn
