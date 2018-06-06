Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mfzu7iF6"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 15A706070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933576AbeFFRRD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:17:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932977AbeFFRRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:17:02 -0400
X-Google-Smtp-Source: ADUXVKKNUzH/BjEmUuYzbb/ik2LYQOc/6YKGhdMo2HCF7Iu7GXppZZ929obs//y0IFBq6CXXLQPK3RLe9xhd1FIxO6Q=
MIME-Version: 1.0
References: <1528302199-29619-1-git-send-email-chang.seok.bae@intel.com> <1528302199-29619-7-git-send-email-chang.seok.bae@intel.com>
In-Reply-To: <1528302199-29619-7-git-send-email-chang.seok.bae@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 6 Jun 2018 10:16:48 -0700
X-Gmail-Original-Message-ID: <CALCETrWaFE2TF8gvd6xf=kkavO53yrXaUqLMXe_UkC_tAagOGw@mail.gmail.com>
Message-ID: <CALCETrWaFE2TF8gvd6xf=kkavO53yrXaUqLMXe_UkC_tAagOGw@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] x86/segments/64: Rename PER_CPU segment to CPU_NUMBER
To: "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc: Andrew Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 9:23 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> 64-bit doesn't use the entry for per CPU data, but for CPU
> numbers. The change will clarify the real usage of this
> entry in GDT.

Acked-by: Andy Lutomirski <luto@kernel.org>

This is a *huge* improvement.
