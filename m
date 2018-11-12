Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB15AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82ACA22504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82ACA22504
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbeKMFPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:15:36 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52987 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeKMFPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:15:36 -0500
Received: from node-1w7jr9qsvbxfi9ota9omrl6fe.ipv6.telus.net ([2001:569:7bc5:1000:8103:8419:bf24:e6ca])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gMHlY-0005Bz-LB; Mon, 12 Nov 2018 20:20:57 +0100
Date:   Mon, 12 Nov 2018 11:20:44 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Yixun Lan <yixun.lan@amlogic.com>
cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 1/3] dt-bindings: reset: Add bindings for the Meson-AXG
 SoC Reset Controller
In-Reply-To: <20171110084650.31325-1-yixun.lan@amlogic.com>
Message-ID: <alpine.DEB.2.21.1811121115520.14703@nanos.tec.linutronix.de>
References: <20171110084650.31325-1-yixun.lan@amlogic.com>
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

Yixun,

On Fri, 10 Nov 2017, Yixun Lan wrote:

> +/*
> + *
> + * Copyright (c) 2016 BayLibre, SAS.
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + *
> + * Copyright (c) 2017 Amlogic, inc.
> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR BSD)

There are two things wrong:

  1) The placement. See Documentation/process/license-rules.rst

  2) BSD is not a valid license id. You really have to decide which BSD
     variant to use.

Please get that fixed as especially #2 is broken. The goal of using SPDX is
to provide reliable license information for compliance tools.

Thanks,

	tglx
