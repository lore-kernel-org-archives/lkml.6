Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425531AbeCBJTf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 04:19:35 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53430 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425143AbeCBJS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 04:18:57 -0500
Date: Fri, 2 Mar 2018 10:18:46 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ivan Gorinov <ivan.gorinov@intel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3 0/3] x86: devicetree: re-enable x86-specific
 implementation
In-Reply-To: <20180301230445.GA48473@intel.com>
Message-ID: <alpine.DEB.2.21.1803021011160.1803@nanos.tec.linutronix.de>
References: <20180301230445.GA48473@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2018, Ivan Gorinov wrote:

> Fixing x86-specific DT implementation in the kernel allows reusing most of
> firmware code for SoC that have ARM core replaced with x86, e.g. SC9853i.
> 
> Changes since v2:
> 
>  * WARN_ON_ONCE instead of WARN_ON to aviod multiple warnings
>    when APIC ID is missing in CPU device tree nodes
> 
>  * Switched to Mutt because of white space issues:
>    "Preformatted" paragraph style does not work in Evolution 3.18.5.2

The patches can be applied now, but still the series is not threaded. That
means 1/3 - 3/3 lack a References: tag which contains the message-id of
0/3. Please figure out how to do that, it's annoying if patch series cannot
be collapsed.

Thanks,

	tglx
