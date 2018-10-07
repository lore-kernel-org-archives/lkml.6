Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2E9C65C24
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 20:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275C02088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 20:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275C02088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbeJHDIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 23:08:39 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40074 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbeJHDIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 23:08:38 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g9FDn-0001Rw-To; Sun, 07 Oct 2018 22:00:12 +0200
Date:   Sun, 7 Oct 2018 22:00:11 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Marek Vasut <marex@denx.de>
cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] clocksource/drivers/dw_apb: Add reset control
In-Reply-To: <d27e6960-5f59-4a81-09c2-8606f0bce344@denx.de>
Message-ID: <alpine.DEB.2.21.1810072159220.5454@nanos.tec.linutronix.de>
References: <20181005143253.GE1881@mai> <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org> <1538750143-4282-13-git-send-email-daniel.lezcano@linaro.org> <alpine.DEB.2.21.1810061433170.5454@nanos.tec.linutronix.de> <5ebc1d90-2067-8cb5-0c93-1c9f0677abc5@linaro.org>
 <alpine.DEB.2.21.1810061907030.5454@nanos.tec.linutronix.de> <d27e6960-5f59-4a81-09c2-8606f0bce344@denx.de>
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

On Sun, 7 Oct 2018, Marek Vasut wrote:
> 
> I reported this to Dinh and gave him some prototype patches to start
> with, since I didn't have the time to write a patch. You can change it
> to Reported-by: if you want.

Marek, thanks for clarification!
