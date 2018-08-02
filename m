Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E744C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C733214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C733214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbeHBL6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:58:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36308 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbeHBL6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:58:23 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1flAWQ-0003Kk-1Q; Thu, 02 Aug 2018 12:07:54 +0200
Date:   Thu, 2 Aug 2018 12:07:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jacek Tomaka <jacekt@dugeo.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jacek Tomaka <jacek.tomaka@poczta.fm>
Subject: Re: [PATCH v4] perf/x86/intel: Add support for MISPREDICT bit on
 Knights Landing cpus
In-Reply-To: <20180802013830.10600-1-jacekt@dugeo.com>
Message-ID: <alpine.DEB.2.21.1808021206090.2037@nanos.tec.linutronix.de>
References: <20180802013830.10600-1-jacekt@dugeo.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2018, Jacek Tomaka wrote:

The actiual purpose of sending V4 which is identical to V3 is?

> 
> Signed-off-by: Jacek Tomaka <jacek.tomaka@poczta.fm>
> ---

It's good practice to add a

V3 -> V4: changed foo
V2 -> V3: fixed bla
...

section to patches which have more than one version.

Thanks,

	tglx
