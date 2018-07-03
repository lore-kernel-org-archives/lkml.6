Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4F3C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C2924E2C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgI5KR2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C2924E2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbeGCF7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 01:59:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754001AbeGCF7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 01:59:19 -0400
Received: from dragon (unknown [104.237.91.44])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E97E24E2B;
        Tue,  3 Jul 2018 05:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530597558;
        bh=wE1XK1pTy91b7wzXE2BvW7G8cYU/HInLKutkJKDYjtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TgI5KR2KeknYdLcevrcYxWYg2EJ4L34uwxiqfbiOjBnpeFIRlZYigo7r+ebFfBVu5
         I0rlVbEOvFyCFUPpbnz1LonnwWemu/Atf/72FRvk87w6a35p6KaUCbmLeJd4G1wib6
         b0zOVX/VieEhe+5f0nclp+enLpYG07Z55wq6+bqc=
Date:   Tue, 3 Jul 2018 13:59:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv2 1/2] ARM: dts: imx53: PPD: Add fixed-regulator
 information
Message-ID: <20180703055902.GE4348@dragon>
References: <20180628163639.1078-1-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628163639.1078-1-sebastian.reichel@collabora.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 06:36:38PM +0200, Sebastian Reichel wrote:
> Add information about 3V3 power rail to avoid kernel warnings,
> that dummy regulators have been added.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

I changed subject prefix to 'ARM: dts: imx53-ppd: ...', and applied
both.

Shawn
