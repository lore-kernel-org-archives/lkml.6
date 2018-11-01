Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8A2C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED772064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED772064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeKBCNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:13:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57780 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKBCNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:13:04 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gIGT0-0007TW-4P; Thu, 01 Nov 2018 18:09:10 +0100
Date:   Thu, 1 Nov 2018 18:09:09 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     X86 ML <x86@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/gart: Rewrite early_gart_iommu_check() comment
In-Reply-To: <20181101155314.30690-1-bp@alien8.de>
Message-ID: <alpine.DEB.2.21.1811011808540.1642@nanos.tec.linutronix.de>
References: <20181101155314.30690-1-bp@alien8.de>
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

On Thu, 1 Nov 2018, Borislav Petkov wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> ... to actually explain what the function is trying to do.
> 
> Reported-by: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
