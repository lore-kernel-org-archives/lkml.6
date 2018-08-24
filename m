Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4E7C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FB021567
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FB021567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbeHXRgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 13:36:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40254 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbeHXRgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 13:36:35 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ftCen-0008To-23; Fri, 24 Aug 2018 16:01:45 +0200
Date:   Fri, 24 Aug 2018 16:01:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Juergen Gross <jgross@suse.com>
cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        akataria@vmware.com, rusty@rustcorp.com.au,
        boris.ostrovsky@oracle.com, hpa@zytor.com, mingo@redhat.com,
        peterz@infradead.org
Subject: Re: [PATCH v2 02/11] x86/paravirt: remove clobbers parameter from
 paravirt patch functions
In-Reply-To: <20180813073739.26108-3-jgross@suse.com>
Message-ID: <alpine.DEB.2.21.1808241601270.1550@nanos.tec.linutronix.de>
References: <20180813073739.26108-1-jgross@suse.com> <20180813073739.26108-3-jgross@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2018, Juergen Gross wrote:

> The clobbers parameter from paravirt_patch_default() et al isn't used
> any longer. Remove it.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
