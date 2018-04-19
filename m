Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbeDSLLb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 07:11:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39164 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbeDSLLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 07:11:30 -0400
Date: Thu, 19 Apr 2018 13:11:05 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Wang YanQing <udknight@gmail.com>
cc: daniel@iogearbox.net, ast@kernel.org, illusionist.neo@gmail.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf, x86_32: add eBPF JIT compiler for ia32 (x86_32)
In-Reply-To: <20180418093118.GA4184@udknight>
Message-ID: <alpine.DEB.2.21.1804191308580.1563@nanos.tec.linutronix.de>
References: <20180418093118.GA4184@udknight>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018, Wang YanQing wrote:
> @@ -0,0 +1,147 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* bpf_jit.S : BPF JIT helper functions

Please do not add these file names to the top level comment. They provide
no value and just become stale when the file gets moved/renamed.

> + *
> + * Copyright (C) 2018 Wang YanQing (udknight@gmail.com)
> + * Copyright (C) 2011 Eric Dumazet (eric.dumazet@gmail.com)
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; version 2
> + * of the License.

You have already the License Identifier. So you don't need the boiler plate
text.

Thanks,

	tglx
