Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F44C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0998721759
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0998721759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeHCNiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:38:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39635 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbeHCNiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:38:17 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1flYTL-0007IZ-MG; Fri, 03 Aug 2018 13:42:19 +0200
Date:   Fri, 3 Aug 2018 13:42:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [PATCH] nohz: Fix missing tick reprog while interrupting inline
 timer softirq
In-Reply-To: <20180801210822.GA20627@lerouge>
Message-ID: <alpine.DEB.2.21.1808031341270.1745@nanos.tec.linutronix.de>
References: <1533077570-9169-1-git-send-email-frederic@kernel.org> <alpine.DEB.2.21.1808011812160.1835@nanos.tec.linutronix.de> <20180801210822.GA20627@lerouge>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2018, Frederic Weisbecker wrote:
> On Wed, Aug 01, 2018 at 07:46:10PM +0200, Thomas Gleixner wrote:
> 
> In fact I should remove this whole paragraph, it's about code history that's
> not relevant anymore and it confuses the whole explanation which should
> concern nohz_full only.

Care to send an updated version?

Thanks,

	tglx
