Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC9EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9323523EF1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9323523EF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753842AbeGFI6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:58:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53793 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753476AbeGFI61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:58:27 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fbMZN-0004G6-Of; Fri, 06 Jul 2018 10:58:25 +0200
Date:   Fri, 6 Jul 2018 10:58:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mukesh Ojha <mojha@codeaurora.org>
cc:     john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        neeraju@codeaurora.org, gkohli@codeaurora.org,
        cpandya@codeaurora.org
Subject: Re: [PATCH v2] time: Fix sleeptime injection for non-stop clocksource
 & persistent clock
In-Reply-To: <be7701cb-c0f0-a357-ba99-8f86a18060c2@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1807061056320.1664@nanos.tec.linutronix.de>
References: <1527680699-16068-1-git-send-email-mojha@codeaurora.org> <alpine.DEB.2.21.1806222312340.1589@nanos.tec.linutronix.de> <e869c2ec-90fa-27e2-975c-a92469f56dac@codeaurora.org> <alpine.DEB.2.21.1806251701410.1821@nanos.tec.linutronix.de>
 <be7701cb-c0f0-a357-ba99-8f86a18060c2@codeaurora.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2018, Mukesh Ojha wrote:

> Hi Thomas,
> 
> Could you raise a formal patch on this as you are the author now?

I'm short of cycles ATM. Feel free to pick it up and write a nice
changelog. Just add

Originally-by: Thomas Gleixner <tglx@linutronix.de>

Thanks,

	tglx
