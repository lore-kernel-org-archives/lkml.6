Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3306BECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73B32084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73B32084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbeGSNhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:37:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:32905 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbeGSNhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:37:47 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fg8S7-0007QJ-S1; Thu, 19 Jul 2018 14:54:40 +0200
Date:   Thu, 19 Jul 2018 14:54:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>
cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: Re: [PATCH V3 1/4] X86/Hyper-V: Add flush HvFlushGuestPhysicalAddressSpace
 hypercall support
In-Reply-To: <beee6107-0168-e32b-288c-220001a4557b@microsoft.com>
Message-ID: <alpine.DEB.2.21.1807191454240.1602@nanos.tec.linutronix.de>
References: <20180719083946.121493-1-Tianyu.Lan@microsoft.com> <20180719083946.121493-2-Tianyu.Lan@microsoft.com> <alpine.DEB.2.21.1807191404241.1602@nanos.tec.linutronix.de> <beee6107-0168-e32b-288c-220001a4557b@microsoft.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jul 2018, Tianyu Lan wrote:
> On 7/19/2018 8:05 PM, Thomas Gleixner wrote:
> > You already have the SPDX identifier. So the GPL boilerplate is not really
> > required, unless your legal departement insist on it.
> > 
> 
> Hi Thomas:
> 	Thanks for your reminder. How about the following?
> 
> 
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Hyper-V nested virtualization code.
> + *
> + * Copyright (C) 2018, Microsoft, Inc.
> + *
> + * Author : Lan Tianyu <Tianyu.Lan@microsoft.com>
> + */

Perfect :)
