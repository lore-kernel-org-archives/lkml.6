Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54399C46475
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A7A2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A7A2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbeJ2RoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:44:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51360 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729429AbeJ2RoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:44:23 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gH3LZ-0005K8-Nw; Mon, 29 Oct 2018 09:56:29 +0100
Date:   Mon, 29 Oct 2018 09:56:29 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Horia Geanta <horia.geanta@nxp.com>
Cc:     Roy Pledge <roy.pledge@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Leo Li <leoyang.li@nxp.com>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: caam/qi - simplify CGR allocation, freeing
Message-ID: <20181029085629.55exxlamujlyvs3n@linutronix.de>
References: <20181005125443.dfhd2asqktm22ney@linutronix.de>
 <20181008110937.29198-1-horia.geanta@nxp.com>
 <20181009171101.jk6lgdx4g5rnq7cm@linutronix.de>
 <VI1PR0402MB3485A342A184BEBB004E74F998F70@VI1PR0402MB3485.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB3485A342A184BEBB004E74F998F70@VI1PR0402MB3485.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-25 14:05:32 [+0000], Horia Geanta wrote:
> > Now, what is the problem with the CPU limitation? Is this a HW
> > limitation that you can access the registers from a certain CPU?
> > 
> Roy confirmed the CPU limitation should actually be removed, there is nothing in
> HW requiring it.
> A clean-up patch will follow.

good. Thank you.

> Thanks,
> Horia

Sebastian
