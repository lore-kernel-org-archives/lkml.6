Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA149C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77BD62081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77BD62081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbeKATTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:19:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57211 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeKATTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:19:02 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gIA1l-0002P6-DD; Thu, 01 Nov 2018 11:16:37 +0100
Date:   Thu, 1 Nov 2018 11:16:36 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Hurwitz, Sherry" <sherry.hurwitz@amd.com>
cc:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "longli@microsoft.com" <longli@microsoft.com>
Subject: Re: Tested-by test
In-Reply-To: <1541010174-28621-1-git-send-email-sherry.hurwitz@amd.com>
Message-ID: <alpine.DEB.2.21.1811011115350.1642@nanos.tec.linutronix.de>
References: <20181023014044.15888-1-longli@linuxonhyperv.com> <1541010174-28621-1-git-send-email-sherry.hurwitz@amd.com>
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

Sherry,

On Wed, 31 Oct 2018, Hurwitz, Sherry wrote:

please do not rewrite the subject when replying to a patch.

Thanks,

	tglx
