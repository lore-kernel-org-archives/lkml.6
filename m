Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A854C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C134520844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C134520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbeIGRZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:25:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36166 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIGRZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:25:24 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyG7i-0001aY-L0; Fri, 07 Sep 2018 14:44:30 +0200
Date:   Fri, 7 Sep 2018 14:44:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH resend 0/2] irqchip: convert to SPDX for Renesas
 drivers
In-Reply-To: <87ftymqdzh.wl-kuninori.morimoto.gx@renesas.com>
Message-ID: <alpine.DEB.2.21.1809071442340.1402@nanos.tec.linutronix.de>
References: <87ftymqdzh.wl-kuninori.morimoto.gx@renesas.com>
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

On Fri, 7 Sep 2018, Kuninori Morimoto wrote:

> 
> Hi Thomas, Marc, Jason
> 
> 2weeks passed. I resend this patch again

Unfortunately to the wrong people. pinctrl != irqchip

> Kuninori Morimoto (2):
>   pinctrl: sh-pfc: convert to SPDX identifiers
>   pinctrl: rza1: convert to SPDX identifiers

PIN CONTROL SUBSYSTEM
M:      Linus Walleij <linus.walleij@linaro.org>
L:      linux-gpio@vger.kernel.org

Hope that helps.

Thanks,

	tglx
