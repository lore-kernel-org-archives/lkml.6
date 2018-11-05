Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5052CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131F42081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131F42081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbeKEWjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:39:53 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34851 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728966AbeKEWjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:39:53 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gJenX-0005kh-QD; Mon, 05 Nov 2018 14:20:07 +0100
Date:   Mon, 5 Nov 2018 14:20:07 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
cc:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V3 0/3] Unmap EFI boot services code/data regions after
 boot.
In-Reply-To: <CAKv+Gu_2cPZ5HKo2oDeYsLGAXgnENzWskZOcT_Z509Shbct+2Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1811051419230.1566@nanos.tec.linutronix.de>
References: <20181104201019.26142-1-sai.praneeth.prakhya@intel.com> <CAKv+Gu_2cPZ5HKo2oDeYsLGAXgnENzWskZOcT_Z509Shbct+2Q@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Nov 2018, Ard Biesheuvel wrote:
> On 4 November 2018 at 21:10, Sai Praneeth Prakhya
> <sai.praneeth.prakhya@intel.com> wrote:
> Thanks Sai.
> 
> I have queued these up in efi/next for now, but I'd still like a fresh
> ack from the x86 maintainers.

I've reviewed the CPA part and for the rest feel free to add

Acked-by: Thomas Gleixner <tglx@linutronix.de>

