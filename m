Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A821BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5889F21735
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dl+ACniP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5889F21735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeH0LX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:23:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbeH0LX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:23:27 -0400
Received: from dragon (unknown [45.56.155.152])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3417C208D8;
        Mon, 27 Aug 2018 07:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535355480;
        bh=AYbxoML4kFlOhv1E9LLH0MsD68IwXhH7v9oAhAxoPVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dl+ACniPDj91iqjdZFARXKOOXy7fCs+YWUBoqJQhtmi9ldHmILC5QYL5ic6zpAtVD
         k+ar9nsqpriXUv9P4a1yGUbYreME46Wg1fehBfo8h0g837Fp3RcQDPMaLVxypymg7n
         cMH5/V1wSrcs3htvXxrKwHfgTFmhqZIFM9/T4F1g=
Date:   Mon, 27 Aug 2018 15:37:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tuomas Tynkkynen <tuomas@tuxera.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: imx6qdl-wandboard: Add stdout-path
Message-ID: <20180827073705.GJ3850@dragon>
References: <20180820210718.18636-1-tuomas@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820210718.18636-1-tuomas@tuxera.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 12:07:18AM +0300, Tuomas Tynkkynen wrote:
> Setting a stdout-path in the .dtb is convenient because then the user
> gets a serial console on the RS-232 connector without any extra effort
> of figuring out the relevant 'console=' boot parameter.
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>

Applied, thanks.
