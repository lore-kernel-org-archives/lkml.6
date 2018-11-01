Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9408CC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6289B2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6289B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbeKBAcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:32:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57644 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbeKBAcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:32:32 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gIEu1-0006Ha-5A; Thu, 01 Nov 2018 16:28:57 +0100
Date:   Thu, 1 Nov 2018 16:28:56 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peng Hao <penghao122@sina.com.cn>
cc:     rkrcmar@redhat.com, pbonzini@redhat.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: Re: [PATCH v2] x86/kvmclock : convert to SPDX identifiers
In-Reply-To: <1541084421-4797-1-git-send-email-penghao122@sina.com.cn>
Message-ID: <alpine.DEB.2.21.1811011623040.1642@nanos.tec.linutronix.de>
References: <1541084421-4797-1-git-send-email-penghao122@sina.com.cn>
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

Peng,

On Thu, 1 Nov 2018, Peng Hao wrote:

> This patch updates license to use SPDX-License-Identifier
> instead of verbose license text

Again:

 git grep 'This patch' Documentation/process/

This leads you to:

 "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour."

Documentation is there for a reason.

IOW, writing 'This patch does ....' is not the proper way for writing a
changelog. It's entirely clear that this is a patch. No need to mention
it. Imperative mood means something like this:

Replace the verbose license text with the matching SPDX license identifier.

Thanks,

	tglx
