Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DCDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96856208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96856208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbeGaQ33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:29:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59922 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732268AbeGaQ33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:29:29 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fkVww-0006Bu-8G; Tue, 31 Jul 2018 16:48:40 +0200
Date:   Tue, 31 Jul 2018 16:48:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Kohli, Gaurav" <gkohli@codeaurora.org>
cc:     john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] timers: Clear must_forward_clk inside base lock
In-Reply-To: <063840fb-3360-4208-2950-908ef76791c2@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1807311647040.1610@nanos.tec.linutronix.de>
References: <1532594522-28045-1-git-send-email-gkohli@codeaurora.org> <063840fb-3360-4208-2950-908ef76791c2@codeaurora.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gaurav,

On Tue, 31 Jul 2018, Kohli, Gaurav wrote:

> Can you please review below patch and update your comments:

It's on the todo list already. We're not machines and a week time before
sending a reminder is really appropriate.

Thanks,

	tglx


