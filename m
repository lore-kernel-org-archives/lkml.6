Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2995DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A704E2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c500qf07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A704E2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbeH2S26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbeH2S25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:28:57 -0400
Received: from dragon (unknown [45.56.155.152])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9515120850;
        Wed, 29 Aug 2018 14:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535553104;
        bh=9BD6XU6Cna6LsMoo36CTmAbl8NSBwc1cFtaLPYEje1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c500qf078b3YSxznDTQ9dHs9KA1tYdkj03nOI9QzXD+z+W1fksmLj6Q65q6B1aih5
         OXarbCVcEt6X69FJ63bCB0F7/c0SzsSYioHTeHgkHbcu6Fl6QMFHzviDGUeE3bmUXc
         xyg0D2Zjs2Tu8L/XB9EDgSnnKJPmYYs+KtqeW0d8=
Date:   Wed, 29 Aug 2018 22:30:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] ARM: dts: imx6sll: add gpio clocks
Message-ID: <20180829143032.GO3850@dragon>
References: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com>
 <1529649154-5724-2-git-send-email-Anson.Huang@nxp.com>
 <20180712025203.GQ6959@dragon>
 <DB3PR0402MB39163FACD5AE40052010B390F5090@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB39163FACD5AE40052010B390F5090@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 01:12:04AM +0000, Anson Huang wrote:
> Hi, Shawn
> 	I saw v4.19-rc1 is created, can you please apply this patch?
> 

Applied.  Thanks for reminding.

Shawn
