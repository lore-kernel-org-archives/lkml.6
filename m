Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0CAC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C2420830
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C2420830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbeKGI1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 03:27:15 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:39563 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbeKGI1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 03:27:15 -0500
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gKAJv-0004Rw-CY; Tue, 06 Nov 2018 23:59:39 +0100
Date:   Tue, 6 Nov 2018 23:59:38 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Long Li <longli@microsoft.com>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [Patch v4] genirq/matrix: Choose CPU for managed IRQs based on
 how many of them are allocated
In-Reply-To: <20181106040000.27316-1-longli@linuxonhyperv.com>
Message-ID: <alpine.DEB.2.21.1811062357200.1635@nanos.tec.linutronix.de>
References: <20181106040000.27316-1-longli@linuxonhyperv.com>
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

Long,

On Tue, 6 Nov 2018, Long Li wrote:

> From: Long Li <longli@microsoft.com>
> 
> On a large system with multiple devices of the same class (e.g. NVMe disks,
> using managed IRQs), the kernel tends to concentrate their IRQs on several
> CPUs.

Thanks for addressing the comments. Well done.

I've merged it, but took the liberty to rework the changelog so all the
background information which we exchanged over the various iterations is
preserved there.

Thanks,

	tglx
