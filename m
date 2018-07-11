Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D1EC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BF220B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIe56Nq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BF220B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbeGKMvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:51:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeGKMvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:51:04 -0400
Received: from dragon (unknown [45.56.152.98])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15BCA2089B;
        Wed, 11 Jul 2018 12:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531313213;
        bh=o+ebfizzbg2/5xKOn//Iq0hWamhAN6e6nlcfwEs5n2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nIe56Nq6T9TAeFANqeXxzxXE8/tVEF86fH9XL1bojO2dHc+7/vzvl92DJxImGisPC
         GD8JiQTEDvHjs+GES0cnIxWWkHcfRgUuhJ3723nf585b1XKepMSNZNOm+StdO3Q0Ic
         DRzRaNPeBXmXltacIUAiL/irUnvMO/C1sw/CxX+k=
Date:   Wed, 11 Jul 2018 20:46:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>, cphealy@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Subject: Re: [PATCH] ARM: dts: imx: Add ZII SCU2 Mezz board
Message-ID: <20180711124617.GF6959@dragon>
References: <20180707024902.439-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707024902.439-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 07:49:02PM -0700, Andrey Smirnov wrote:
> Add support for the Zodiac Inflight Innovations SCU2 Mezz
> board (i.MX51-based).
> 
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: cphealy@gmail.com
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Applied, thanks.
