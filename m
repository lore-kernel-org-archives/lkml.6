Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4F7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605E020657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392137AbfAPKov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:44:51 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44670 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731552AbfAPKov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:44:51 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gjige-0005Jl-Px; Wed, 16 Jan 2019 11:44:45 +0100
Date:   Wed, 16 Jan 2019 11:44:44 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jerome Brunet <jbrunet@baylibre.com>
cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, Carlo Caione <carlo@caione.org>
Subject: Re: [PATCH] dt-bindings: reset: meson-axg: fix SPDX license id
In-Reply-To: <20190116103632.17754-1-jbrunet@baylibre.com>
Message-ID: <alpine.DEB.2.21.1901161144130.1655@nanos.tec.linutronix.de>
References: <20190116103632.17754-1-jbrunet@baylibre.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019, Jerome Brunet wrote:

> As reported, the SPDX license id is not placed correctly and the variant
> of the BSD License used should be specified.
> 
> Fixes: c16292578ffa ("dt-bindings: reset: Add bindings for the Meson-AXG SoC Reset Controller")
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

> ---
> 
>  Sorry for the delay Thomas.

Thanks for fixing it!

       tglx
