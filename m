Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13583C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8462133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8462133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbeISDsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:48:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59016 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbeISDsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:48:31 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g2OFh-00054p-64; Wed, 19 Sep 2018 00:13:49 +0200
Date:   Wed, 19 Sep 2018 00:13:48 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
cc:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: Re: [GIT PULL 0/1] EFI fix for v4.19-rc
In-Reply-To: <20180918213652.5648-1-ard.biesheuvel@linaro.org>
Message-ID: <alpine.DEB.2.21.1809190013290.1468@nanos.tec.linutronix.de>
References: <20180918213652.5648-1-ard.biesheuvel@linaro.org>
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

On Tue, 18 Sep 2018, Ard Biesheuvel wrote:

> The following changes since commit 11da3a7f84f19c26da6f86af878298694ede0804:
> 
>   Linux 4.19-rc3 (2018-09-09 17:26:43 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git efi-urgent
> 
> for you to fetch changes up to d310959365942b100f79b56bcce859968fe7ca9c:
> 
>   efi/libstub/arm: default EFI_ARMSTUB_DTB_LOADER to y (2018-09-12 16:41:41 +0200)
> 
> ----------------------------------------------------------------
> Apply a fix from Scott to make the ARM stub's DTB loader opt-out rather
> than opt-in.

Pulled. Thanks Ard!

	tglx
