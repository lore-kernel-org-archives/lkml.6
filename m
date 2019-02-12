Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF52C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB2720821
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549962613;
	bh=juo7FCnQMIuEyX8VOz5Vmyjk9rOLVg1YY8bxa+Cl9kU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Owp9KFYwPS+ASDUGFXgy50zyK4f2yraHNvJ6JmuWLvfTs31+BHD3wvhSJ18LGEJgC
	 Ch4VoZ0lRJS/ax+UCxOIhZmt7hYVD0pBPHZCc8eOufb2+PFgGlHS9vISVR7lXaCFrM
	 1JEGssg+A56uDFFqXcOSk4jAHqolxtD7CgUnGJ2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfBLJKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:10:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:52294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728353AbfBLJKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:10:11 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A608020836;
        Tue, 12 Feb 2019 09:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549962610;
        bh=juo7FCnQMIuEyX8VOz5Vmyjk9rOLVg1YY8bxa+Cl9kU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vLKDn+VHO+xsxtWtvy8MYUwC7LnwBNyL6S/BIeQMpUi3OgURalWwQ/cpf7/JIRdqO
         efKZDPisvP4iAKzbWJlaH+t9tWKICrBvcNj3mCFNRj5gwWfDHCt4eg8jnvpqsMycvl
         hVy4hF9VqFJLUegG1P51zPik/j3vXKxuz8epTP2U=
Date:   Tue, 12 Feb 2019 17:09:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        marcel.ziswiler@toradex.com, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org, stefan@agner.ch,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        thierry.reding@gmail.com, NXP Linux Team <linux-imx@nxp.com>,
        max.krummenacher@toradex.com, linux-tegra@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] Adding DTS to support STMPE811 ADC on Toradex Boards
Message-ID: <20190212090954.GP22487@dragon>
References: <20190122132135.5012-1-dev@pschenker.ch>
 <20190201033633.GE19882@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201033633.GE19882@dragon>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 11:36:34AM +0800, Shawn Guo wrote:
> On Tue, Jan 22, 2019 at 02:21:33PM +0100, Philippe Schenker wrote:
> > Philippe Schenker (2):
> >   ARM: dts: Add stmpe-adc DT node to Toradex iMX6 modules
> >   ARM: dts: Add stmpe-adc DT node to Toradex T30 modules
> 
> Applied both, thanks.

Sorry, the T30 one shouldn't be applied by me.  Dropped from my tree.

Shawn
