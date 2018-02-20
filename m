Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbeBTIgu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 03:36:50 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:60765 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750781AbeBTIgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 03:36:48 -0500
Date: Tue, 20 Feb 2018 09:36:57 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: David Woodhouse <dwmw@amazon.co.uk>
cc: karahmed@amazon.de, x86@kernel.org, kvm@vger.kernel.org,
        torvalds@linux-foundation.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org,
        jmattson@google.com, rkrcmar@redhat.com, arjan.van.de.ven@intel.com,
        dave.hansen@intel.com, mingo@kernel.org
Subject: Re: [PATCH v3 4/4] x86/retpoline: Support retpoline build with
 Clang
In-Reply-To: <1519037457-7643-5-git-send-email-dwmw@amazon.co.uk>
Message-ID: <alpine.DEB.2.21.1802200935300.24268@nanos.tec.linutronix.de>
References: <1519037457-7643-1-git-send-email-dwmw@amazon.co.uk> <1519037457-7643-5-git-send-email-dwmw@amazon.co.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2018, David Woodhouse wrote:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

> +/* Clang doesn't have a way to turn it off per-function, yet. */

Is that going to happen in the foreseable future? Hmm, why am I asking,
clang is going to break anyway once we require asm-gotos hard.

Thanks,

	tglx
