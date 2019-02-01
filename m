Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB26CC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09C420863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548991711;
	bh=6IRQ6TE7MoOGbgZSTXbJ+AGEA8navF+oYn+tcMg5YwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dCT2RltPckEB4k7bXe4KdNANkT+pO2veZLTUlksha45gT53+pMZnPLVU4znBMV6F+
	 WM8XqQgMiGuBfz+qCIthU5VkBCxjtlckwm00yyCddQq1sqYo4HvleyO0f3NzsQN32Y
	 eI9p6keUk698oPaQwithN+DNnFYpSATjfaztIZNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfBAD2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 22:28:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:42860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbfBAD22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 22:28:28 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 603E220863;
        Fri,  1 Feb 2019 03:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548991707;
        bh=6IRQ6TE7MoOGbgZSTXbJ+AGEA8navF+oYn+tcMg5YwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mb3wkYitQJn+UYktH7AmTDRF3pb+XBszzsQEtobymtORbCX/XSbut0bcBUGzhZ0kK
         bmG9QxqCdysLpsiJy6yXv+w8ml9A/jymjHz/o7JUeuaL5W3VTGx96HaCMIS2HxMO/U
         fa9Ewm8hH73bXs5DcPRqDHfJwrjriM7aqFFWmE6w=
Date:   Fri, 1 Feb 2019 11:28:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.tropschug@ebs-systart.com,
        m.bittner@ebs-systart.com, amit.kucheria@linaro.org
Subject: Re: [PATCH v3 0/5] Add Oxalis board support
Message-ID: <20190201032816.GD19882@dragon>
References: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 09:51:42AM +0530, Manivannan Sadhasivam wrote:
> Manivannan Sadhasivam (5):
>   dt-bindings: arm: fsl: Fix bindings for LS1012A and LS1021A based
>     boards
>   ARM: dts: Add devicetree compatibles for LS1021A based boards
>   dt-bindings: vendor-prefixes: Add EBS-SYSTART GmbH Vendor Prefix
>   dt-bindings: arm: fsl: Add devicetree binding for Oxalis
>   arm64: dts: freescale: Add devicetree for Oxalis

Applied all, thanks.
