Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A422C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72AFD20850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfAHOet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:34:49 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51909 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbfAHOes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:34:48 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ggsSf-0003po-Md; Tue, 08 Jan 2019 15:34:33 +0100
Date:   Tue, 8 Jan 2019 15:34:27 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/irq: drop arch_early_irq_init()
In-Reply-To: <bd521390-8925-2ed5-c694-84789c358504@c-s.fr>
Message-ID: <alpine.DEB.2.21.1901081534020.10743@nanos.tec.linutronix.de>
References: <dc0760e25a38ce64dd6cfde78b717c8e4a601a1e.1546947335.git.christophe.leroy@c-s.fr> <bd521390-8925-2ed5-c694-84789c358504@c-s.fr>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-62582376-1546958073=:10743"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-62582376-1546958073=:10743
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 8 Jan 2019, Christophe Leroy wrote:

> Oops, forgot to actually copy Thomas.
> 
> Le 08/01/2019 à 12:37, Christophe Leroy a écrit :
> > arch_early_irq_init() does nothing different than
> > the weak arch_early_irq_init() in kernel/softirq.c
> > 
> > Fixes: 089fb442f301 ("powerpc: Use ARCH_IRQ_INIT_FLAGS")
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
--8323329-62582376-1546958073=:10743--
