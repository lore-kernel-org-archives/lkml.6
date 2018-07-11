Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3587AC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0938208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6CE1KmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0938208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387702AbeGKNGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:06:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732420AbeGKNGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:06:16 -0400
Received: from dragon (unknown [45.56.152.98])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B9342086B;
        Wed, 11 Jul 2018 13:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531314121;
        bh=ZhgiBeAosw2bRn8dGNbY70j7bCe48wtd4D1a3UTZFg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f6CE1KmYNdt6rnzHYTL8/VAOQCXkLXBnDOEQe5jKYD864sICbc9RDvDadYBAeOtyn
         dAbAcVTuy1NsmjIZb5Jc4GugIDAXg+81xSHNIPOMBuBkpL9LrsxU3re/ThctSIeygK
         V4mD+WJfMt6ulTBCiq696mczWBGan0+OxSXCGhK0=
Date:   Wed, 11 Jul 2018 21:01:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, marcel.ziswiler@toradex.com,
        max.krummenacher@toradex.com, maitysanchayan@gmail.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] ARM: dts: imx6q-apalis: add chosen node
Message-ID: <20180711130123.GH6959@dragon>
References: <20180709154848.5401-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709154848.5401-1-stefan@agner.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 05:48:41PM +0200, Stefan Agner wrote:
> Add Apalis UART1 as default serial console.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied all, thanks.
