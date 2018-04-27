Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757577AbeD0L6i (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 07:58:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51361 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751608AbeD0L6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 07:58:37 -0400
X-Google-Smtp-Source: AB8JxZqd5gQ5XfXCbq7tiOdvj0wP1rmH2KP96G8llShYMTeXwS9yKdyeHD5HXGpJqtPDYi+RsHehEg==
Date: Fri, 27 Apr 2018 13:58:33 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/PCI: Make pci=earlydump output neat
Message-ID: <20180427115833.sv5pykbeojlivc7s@gmail.com>
References: <20180425101507.51531-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425101507.51531-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Currently the early dump of PCI configuration space looks quite unhelpful, e.g.
> 
> [    0.000000]   60:
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]
> 
> which makes really hard to get anything out of this. Convert the function to
> use print_hex_dump() to make output neat.
> 
> In the result we will have
> 
> [    0.000000] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> which is much, much better.
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
