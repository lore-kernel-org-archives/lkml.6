Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E4BC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DF22081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86DF22081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbeLJXdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:33:10 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:51150 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbeLJXdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:33:09 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990694AbeLJXcqG0UdG (ORCPT
        <rfc822;linux-arch@vger.kernel.org> + 2 others);
        Tue, 11 Dec 2018 00:32:46 +0100
Date:   Mon, 10 Dec 2018 23:32:46 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Paul Burton <paul.burton@mips.com>
cc:     Firoz Khan <firoz.khan@linaro.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>
Subject: Re: [PATCH v4 3/7] mips: rename macros and files from '64' to
 'n64'
In-Reply-To: <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
Message-ID: <alpine.LFD.2.21.1812102324500.11202@eddie.linux-mips.org>
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org> <1544073508-13720-4-git-send-email-firoz.khan@linaro.org> <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018, Paul Burton wrote:

> And I realise that undoing that but keeping n64 in our own filenames &
> macros is another type of inconsistency, but something imperfect is
> unavoidable at this point given that the engineers way back when decided
> to use "ABI64" for n64.

 My feeling has been n32 was invented at SGI as an afterthought, hence the 
choice of having ABI32 or ABI64 defined for the 32-bit (now o32) and the 
64-bit (now n64) ABI respectively was reasonable.

 FWIW,

  Maciej
