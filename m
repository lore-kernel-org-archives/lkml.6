Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7C2C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87ED020831
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87ED020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeJ3Su3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:50:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53513 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbeJ3Su3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:50:29 -0400
Received: from tmo-115-37.customers.d1-online.com ([80.187.115.37] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gHQlr-0003ka-G3; Tue, 30 Oct 2018 10:57:11 +0100
Date:   Tue, 30 Oct 2018 10:57:09 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Luwei Kang <luwei.kang@intel.com>
cc:     kvm@vger.kernel.org, x86@kernel.org, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, pbonzini@redhat.com,
        rkrcmar@redhat.com, joro@8bytes.org, songliubraving@fb.com,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        thomas.lendacky@amd.com, konrad.wilk@oracle.com,
        mattst88@gmail.com, Janakarajan.Natarajan@amd.com,
        dwmw@amazon.co.uk, jpoimboe@redhat.com, marcorr@google.com,
        ubizjak@gmail.com, sean.j.christopherson@intel.com,
        jmattson@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 05/12] perf/x86/intel/pt: add new capability for
 Intel PT
In-Reply-To: <1540368316-12998-6-git-send-email-luwei.kang@intel.com>
Message-ID: <alpine.DEB.2.21.1810301056490.5984@nanos.tec.linutronix.de>
References: <1540368316-12998-1-git-send-email-luwei.kang@intel.com> <1540368316-12998-6-git-send-email-luwei.kang@intel.com>
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

On Wed, 24 Oct 2018, Luwei Kang wrote:

> This adds support for "output to Trace Transport subsystem"
> capability of Intel PT. It means that PT can output its
> trace to an MMIO address range rather than system memory buffer.
> 
> Acked-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>

For patches 1-5:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
