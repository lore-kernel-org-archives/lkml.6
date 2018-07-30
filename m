Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC5713F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB9320894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB9320894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbeG3Nyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 09:54:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56093 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeG3Nyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 09:54:33 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fk79Q-0001z6-6L; Mon, 30 Jul 2018 14:19:48 +0200
Date:   Mon, 30 Jul 2018 14:19:47 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mukesh Ojha <mojha@codeaurora.org>
cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Mathieu Malaterre <malat@debian.org>, gkohli@codeaurora.org,
        neeraju@codeaurora.org
Subject: Re: [PATCH v2] cpu/hotplug: Fix cpuhp_step name for timers
In-Reply-To: <1cf38a28-e95e-a8e4-9e1f-a83a6973436a@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1807301411010.2518@nanos.tec.linutronix.de>
References: <1532443668-26810-1-git-send-email-mojha@codeaurora.org> <1cf38a28-e95e-a8e4-9e1f-a83a6973436a@codeaurora.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mukesh,

On Thu, 26 Jul 2018, Mukesh Ojha wrote:

> Hi All,
> 
> Can i get input on this ?

Sure.

> Thanks,
> Mukesh
> On 7/24/2018 8:17 PM, Mukesh Ojha wrote:

The input you get is that it's unprofessional to poke people after TWO days
about a patch which is purely cosmetic.

It's perfectly fine to send a reminder after a week for important changes
and after two for trivial cleanups like this. You really cannot expect that
maintainers and other developers permanentely sit there twiddling thumbs
and wait for new mail to arrive in order to reply immediately.

Thanks,

	tglx

