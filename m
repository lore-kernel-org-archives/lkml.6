Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E4DECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714FC208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xj4oq6ke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714FC208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbeGQHRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:17:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbeGQHRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:17:52 -0400
Received: from dragon (unknown [104.237.91.210])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E9C82086D;
        Tue, 17 Jul 2018 06:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531810009;
        bh=SO8mdKvFhUlxK9G/TpTFvXRpYyuZasnp7P6i4yds8vM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xj4oq6kezmA8ko/pruSbcPKuhb7h1lVxvcMaKPpuhWHUlxUSlQltMfoTvjs2GqSWo
         96UkFmcKpkCI9pazW4fGXTs2CsRf//bEKJTmOQL92Tg897Yf2LZ61qi3wNKUikzdvw
         CPjo/wOdg2exgNj58uWg4Pc2BEzoMo2YV13yzqyw=
Date:   Tue, 17 Jul 2018 14:46:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>, cphealy@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 0/2] Follow up fixes for SCU3 ESB
Message-ID: <20180717064639.GK4576@dragon>
References: <20180713173005.19552-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713173005.19552-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 10:30:03AM -0700, Andrey Smirnov wrote:
> Andrey Smirnov (2):
>   ARM: dts: imx51-zii-scu3-esb: Add switch IRQ line pinumx config
>   ARM: dts: imx51-zii-scu3-esb: Fix RAVE SP watchdog compatible string

Applied both, thanks.
