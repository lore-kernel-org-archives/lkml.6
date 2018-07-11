Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48923C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC2B20852
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uib54cVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC2B20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387993AbeGKNg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387997AbeGKNgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:36:25 -0400
Received: from dragon (unknown [45.56.152.98])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD0EF20846;
        Wed, 11 Jul 2018 13:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531315923;
        bh=jxM1z1M9dsnR4C9N50GGAc5MJv/ym2ZjPK8oStdBNgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uib54cVy3Kemosgm0UaTp9l975vaW8n1mm8M1fPvHhFmJfbmDM6RT0EyJ+Gbm21Dq
         /eBe2u2aOhGviM/QthJWtv34p8OWksszVb736swHXFCE2VAWqHBlCpZBDN3TeMz9DQ
         Ip+RQrYZ6rC27LgBB3n6WUSJghXFt6DING8SYGDc=
Date:   Wed, 11 Jul 2018 21:31:28 +0800
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
Subject: Re: [PATCH] ARM: dts: imx: Add ZII SCU3 ESB
Message-ID: <20180711133126.GL6959@dragon>
References: <20180711050704.11492-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711050704.11492-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 10:07:04PM -0700, Andrey Smirnov wrote:
> Add support for the Zodiac Inflight Innovations i.MX51-base SCU3 Ethernet
> Switch Board (ESB)
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
