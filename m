Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF34C64EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7306A2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNHMvfIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7306A2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeJHNgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:36:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbeJHNgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:36:24 -0400
Received: from dragon (unknown [45.56.155.247])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E02F20841;
        Mon,  8 Oct 2018 06:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538979978;
        bh=ypYjnAsAfPV/ZUv6m6R/izYnW2dneJu5Lv3P+hP9oTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tNHMvfIB4f2wQjIOOdpC0jBggPKV3DomFgidQbZa/TTaXLsR9zcOzPVxIDJoov/DS
         RP8wjLLtEfX3jmCRYXtHOu1gLjmt7lfCo3YWvlHAWIYTPsJM08EsLuQB4xa8P7r8b4
         dfgFxGuxT9If11PGRfHI5ABAGW2uyNzvPSbNbMag=
Date:   Mon, 8 Oct 2018 14:25:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <glikely@secretlab.ca>,
        Kumar Gala <kumar.gala@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>, Tom Rini <trini@konsulko.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 04/36] dt-bindings: arm: fsl: Move DCFG and SCFG bindings
 to their own docs
Message-ID: <20181008062550.GK3587@dragon>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-5-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005165848.3474-5-robh@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 11:58:16AM -0500, Rob Herring wrote:
> In preparation to convert board-level bindings to json-schema, move
> various misc SoC bindings out to their own file.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Shawn Guo <shawnguo@kernel.org>
