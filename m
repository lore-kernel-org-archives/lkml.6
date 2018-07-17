Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9306ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D16208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8PrshQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D16208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbeGQHT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:19:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbeGQHT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:19:29 -0400
Received: from dragon (unknown [104.237.91.210])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5610D208AD;
        Tue, 17 Jul 2018 06:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531810106;
        bh=LXSm2lWezC7+G3qI4YCsrvxVUayOr/aSr4Wo6oWTCWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k8PrshQm3SDTnq6IybG82l+Jf2/30Z8kIHEJp4p3aUeIK6QxIAW64CSammbth9au1
         5Jrt/rxTs1eb2xu32i3cBUh0qmHG2YBaY1JBqHH487xoRWja8tGSw3vsbWVVCU6de+
         G5UHw0szldyDwuoOVPfkrWmSub1y9+ufbgyE67mw=
Date:   Tue, 17 Jul 2018 14:48:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2] ARM: dts: imx6sl-evk: add missing GPIO iomux setting
Message-ID: <20180717064815.GL4576@dragon>
References: <1531533238-8816-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531533238-8816-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 09:53:58AM +0800, Anson Huang wrote:
> On i.MX6SL EVK board, the MX6SL_PAD_KEY_ROW5 pin is
> used as lcd 3v3 regulator control pin, need to make
> sure MX6SL_PAD_KEY_ROW5 is muxed as GPIO function
> for controlling lcd 3v3 regulator.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
