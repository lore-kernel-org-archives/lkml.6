Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38272C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95D021567
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95D021567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbeHXRbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 13:31:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40019 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbeHXRbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 13:31:51 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ftCaB-0008Cx-NZ; Fri, 24 Aug 2018 15:56:59 +0200
Date:   Fri, 24 Aug 2018 15:56:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Juergen Gross <jgross@suse.com>
cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, hpa@zytor.com, mingo@redhat.com
Subject: Re: [PATCH v2] xen: move pv irq related functions under CONFIG_XEN_PV
 umbrella
In-Reply-To: <a5dca37c-8d97-33b6-41b1-7d08cab526f7@suse.com>
Message-ID: <alpine.DEB.2.21.1808241556300.1550@nanos.tec.linutronix.de>
References: <20180808061918.5033-1-jgross@suse.com> <b7909bb0-ed7c-2640-3f50-136c9e8abf3d@oracle.com> <a5dca37c-8d97-33b6-41b1-7d08cab526f7@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018, Juergen Gross wrote:

> On 08/08/18 17:13, Boris Ostrovsky wrote:
> > x86 maintainers, this needs you ack too even though it has "xen" tag in
> > the subject, thanks.
> 
> Ping?

I thought I sent one already, but here you go:

Acked-by: Thomas Gleixner <tglx@linutronix.de>
