Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E03C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C2020823
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfBHQd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:33:58 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36511 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfBHQd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:33:58 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gs965-00054l-6U; Fri, 08 Feb 2019 17:33:49 +0100
Message-ID: <1549643628.3305.12.camel@pengutronix.de>
Subject: Re: [PATCH v3] dt-bindings: reset: meson: add g12a bindings
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 08 Feb 2019 17:33:48 +0100
In-Reply-To: <6bdabea0-9870-66d1-a737-9695067ba8e6@baylibre.com>
References: <20190201125003.25022-1-jbrunet@baylibre.com>
         <1549535746.4557.3.camel@pengutronix.de>
         <6bdabea0-9870-66d1-a737-9695067ba8e6@baylibre.com>
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

On Thu, 2019-02-07 at 14:10 +0100, Neil Armstrong wrote:
[...]
> The controller is the exact same as Meson8, GXBB, and AXG.
> 
> We had doubts since the previous datasheets were not clear, but for G12A we
> are sure it's 100% same to at least GXBB and AXG, thus using the same
> compatible as AXG since they share most of same architecture.

Ok, thank you. I've applied the patch to the reset/next branch.

regards
Philipp
