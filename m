Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B3CC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682F821501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682F821501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbeHBOJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:09:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37284 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbeHBOJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:09:48 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1flCZ7-0005eQ-4s; Thu, 02 Aug 2018 14:18:49 +0200
Date:   Thu, 2 Aug 2018 14:18:48 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sinan Kaya <okaya@kernel.org>
cc:     linux-kernel@vger.kernel.org, Don Zickus <dzickus@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] watchdog: Reduce message verbosity
In-Reply-To: <20180730190949.141996-1-okaya@kernel.org>
Message-ID: <alpine.DEB.2.21.1808021418000.2037@nanos.tec.linutronix.de>
References: <20180730190949.141996-1-okaya@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018, Sinan Kaya wrote:

> Reducing the verbosity level to debug for people that are interested in
> debugging watchdog issues.
> 
> [    0.152492] NMI watchdog: Perf event create on CPU 0 failed with -2
> [    0.156002] NMI watchdog: Perf NMI watchdog permanently disabled

This changelog is utterly useless. 

Thanks,

	tglx
