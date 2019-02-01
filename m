Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43517C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156AF20863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548992211;
	bh=IWzmsHFpszhTs7TF5E8ZwvQobKHoMTnvd370j1pGuiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0Qy3YatHOhFBuzZ7gO/CItJZbWEghrWsPNf/BavHNusFOdViaBQWhHAU0oFeGOBDB
	 LGHk4JZ2TLgi1najNAWi16fJahhxo2NBdUqNGxdVvFSDXixN8MhH+xT3L9UMDtcxi3
	 hpeW8CJdSCj9tE8O8p5Wdv2+r49cS8Ydiy/5VPSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfBADgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 22:36:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbfBADgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 22:36:48 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8EA920815;
        Fri,  1 Feb 2019 03:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548992207;
        bh=IWzmsHFpszhTs7TF5E8ZwvQobKHoMTnvd370j1pGuiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sGP2GuyolzfQnhK5k6cyctAxZ11903px1ql39KmOLUk0yXsXeBz6batfhS7bepW6o
         ktnUKHZx2dXDLyEMwAdopY6KqeAuaivxERIl6djD4aepDSLYISGTpCjz2RUdcuG0xe
         1pIQzvedJx+VPQKf728KjIRuNLXus2JX2Dx8abHc=
Date:   Fri, 1 Feb 2019 11:36:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     s.hauer@pengutronix.de, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        marcel.ziswiler@toradex.com, stefan@agner.ch,
        max.krummenacher@toradex.com,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 0/2] Adding DTS to support STMPE811 ADC on Toradex Boards
Message-ID: <20190201033633.GE19882@dragon>
References: <20190122132135.5012-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122132135.5012-1-dev@pschenker.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 02:21:33PM +0100, Philippe Schenker wrote:
> Philippe Schenker (2):
>   ARM: dts: Add stmpe-adc DT node to Toradex iMX6 modules
>   ARM: dts: Add stmpe-adc DT node to Toradex T30 modules

Applied both, thanks.
