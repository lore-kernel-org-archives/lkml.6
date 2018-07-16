Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475E0ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096EF208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096EF208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbeGPKrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:47:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44721 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbeGPKrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:47:14 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ff0cD-0001uC-Kh; Mon, 16 Jul 2018 12:20:25 +0200
Message-ID: <1531736425.18173.11.camel@pengutronix.de>
Subject: Re: [PATCH v2 0/2]  reset: uniphier: add USB3 core reset support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Date:   Mon, 16 Jul 2018 12:20:25 +0200
In-Reply-To: <1531185257-16444-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1531185257-16444-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kunihiko,

On Tue, 2018-07-10 at 10:14 +0900, Kunihiko Hayashi wrote:
> This series add new USB3 core reset control support for UniPhier SoCs.
> This reset line belongs to USB3 glue layer.
> 
> Changes since v1:
> - dt-bindings: fix a typo, not "clock-names" but "reset-names"
> - dt-bindings: add description of glue layer
> - reuse soc_data for pxs2, ld20 and pxs3
> - put reset_simple_data into uniphier_usb3_reset_priv
> - replace clk operations with clk_bulk
> - move nclks and nrsts to soc_data
> - rewrite a header with C++ comment style
> - change the subject 'USB3 controller reset' to 'USB3 core reset'
> 
> Kunihiko Hayashi (2):
>   dt-bindings: reset: uniphier: add USB3 core reset support
>   reset: uniphier: add USB3 core reset control

Thank you, both applied to reset/next.

regards
Philipp
