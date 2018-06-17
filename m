Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D591C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 06:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA0A208A5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 06:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HY3GBCdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA0A208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754882AbeFQG5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 02:57:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754276AbeFQG5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 02:57:52 -0400
Received: from dragon (unknown [45.56.152.75])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 881E420896;
        Sun, 17 Jun 2018 06:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529218671;
        bh=8Yo100Whyb3x5GSh+aYqs6nWLZXQnoB08tO1Evox1R0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HY3GBCdwlaagDuYbStUlO9edwnHG8RGLyNSGg0cIa7QVKwQmNTXM4gwaUd77knL9h
         ZJnrHdhquzZaKU3iRu8ssesKtF2X3OXOAdUsNM2IAM1r2BuxGEEb3QLFCFGIl5KLii
         OCdPWhH4hfYjs2L6Gsd+FhVmLUVrllAbh850DhEA=
Date:   Sun, 17 Jun 2018 14:57:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] ARM: DTS: imx53: Add support for imx53 HSC/DDC boards
 from K+P
Message-ID: <20180617065700.GK16091@dragon>
References: <20180509153428.1440-1-lukma@denx.de>
 <20180612133208.22458-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612133208.22458-1-lukma@denx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 03:32:08PM +0200, Lukasz Majewski wrote:
> This commit provides support for HSC and DDC boards from
> Kieback&Peter GmbH vendor.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

"ARM: dts: ..." for prefix.  I fixed it up and applied the patch.

Shawn
