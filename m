Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F5CC4160E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C802054F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbfARWb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:31:59 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50580 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbfARWb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 17:31:58 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gkcg2-0000Xx-J1; Fri, 18 Jan 2019 23:31:50 +0100
Date:   Fri, 18 Jan 2019 23:31:49 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Liming Sun <lsun@mellanox.com>
cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        David Woods <dwoods@mellanox.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mmc: dw_mmc-bluefield: : Fix the license
 information
In-Reply-To: <7f45f1c645ec166b25afe51aa9ae1decdae0b600.1547834838.git.lsun@mellanox.com>
Message-ID: <alpine.DEB.2.21.1901182331080.1647@nanos.tec.linutronix.de>
References: <7f45f1c645ec166b25afe51aa9ae1decdae0b600.1547834838.git.lsun@mellanox.com>
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

Liming,

On Fri, 18 Jan 2019, Liming Sun wrote:

> The SPDX license identifier and the boiler plate text are
> contradicting. Only the SPDX license identifier is needed. The
> other one is removed.
> 
> Fixes: 86958dcc5ad7 ("mmc: dw_mmc-bluefield: Add driver extension")
> Cc: stable@vger.kernel.org
> Reviewed-by: David Woods <dwoods@mellanox.com>
> Signed-off-by: Liming Sun <lsun@mellanox.com>

Thanks for fixing this!

       tglx
