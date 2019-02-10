Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD6AC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3ED2145D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfBJU1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:27:05 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:37315 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfBJU1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 15:27:05 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gsvgs-0000kn-22; Sun, 10 Feb 2019 21:27:02 +0100
Date:   Sun, 10 Feb 2019 21:27:01 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [GIT PULL 1/2] arch: System call unification and cleanup
In-Reply-To: <CAK8P3a3pPwnOW7pXjOhU386zCekAda+p8AgzbOM6ybT=dKMGwA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1902102125410.8784@nanos.tec.linutronix.de>
References: <CAK8P3a3pPwnOW7pXjOhU386zCekAda+p8AgzbOM6ybT=dKMGwA@mail.gmail.com>
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

On Sat, 9 Feb 2019, Arnd Bergmann wrote:

> The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:
> 
>   Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
> tags/y2038-syscall-cleanup

Went over the lot with a fine comb. This looks really good. Nice work!

Pulled into tip timers/2038

Thanks,

	tglx
