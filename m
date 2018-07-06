Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4E9C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037ED23C3F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M38rZyG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 037ED23C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934259AbeGFSNL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:13:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933704AbeGFSNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:13:09 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DB1F23C54;
        Fri,  6 Jul 2018 18:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530900789;
        bh=W7Qf9TLOpeRwjkJ0eEotpOdkIOmvEAoKe8RINnJkb70=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=M38rZyG9nRvgTxCUo5tkxwMEqRPFM5HtGtomqvlrDWr6v1/S4k7Aq54m8slBfE7h/
         UZRZ/gdOTtDj0/CCXGUPd1oiDz7Xryf4bi0/nMgsmOAExmerQ7ZIq1SlQBdWway57l
         B0U1SNdXb/GlFl5iE9LZgKBRKcE7I+WerrQwDvMI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        alexandre.belloni@bootlin.com, alsa-devel@alsa-project.org,
        boris.brezillon@bootlin.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        nicolas.ferre@microchip.com, robh+dt@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180618141239.10892-2-codrin.ciubotariu@microchip.com>
Cc:     Cristian.Birsan@microchip.com
References: <20180618141239.10892-1-codrin.ciubotariu@microchip.com>
 <20180618141239.10892-2-codrin.ciubotariu@microchip.com>
Message-ID: <153090078877.143105.7037682541187931406@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 1/5] dt-bindings: clk: at91: add an I2S mux clock
Date:   Fri, 06 Jul 2018 11:13:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Codrin Ciubotariu (2018-06-18 07:12:35)
> The I2S mux clock can be used to select the I2S input clock. The
> available parents are the peripheral and the generated clocks.
> =

> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---

Applied to clk-next

