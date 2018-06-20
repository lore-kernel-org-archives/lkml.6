Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7474AC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A22120693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A22120693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754981AbeFTJcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:32:00 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59585 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754755AbeFTJb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:31:57 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVZSz-0002Mv-46; Wed, 20 Jun 2018 11:31:53 +0200
Date:   Wed, 20 Jun 2018 11:31:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Meelis Roos <mroos@linux.ee>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Subject: Re: 4.18-rc1: Bad or missing .orc_unwind table. Disabling
 unwinder.
In-Reply-To: <alpine.LRH.2.21.1806201128240.28187@math.ut.ee>
Message-ID: <alpine.DEB.2.21.1806201131350.10546@nanos.tec.linutronix.de>
References: <alpine.LRH.2.21.1806201128240.28187@math.ut.ee>
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

On Wed, 20 Jun 2018, Meelis Roos wrote:

> HP Proliant DL360 G6 displays the following on bootup with 
> 4.18.0-rc1-00023-g9ffc59d57228 (4.17 did not display this warning):
> 
> [    0.000000] WARNING: WARNING: Bad or missing .orc_unwind table.  Disabling unwinder.

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1713797.html
