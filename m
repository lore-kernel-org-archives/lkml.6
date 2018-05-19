Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752344AbeESIqf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 04:46:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55217 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752053AbeESIqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 04:46:32 -0400
Date: Sat, 19 May 2018 10:46:26 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] x86/mm: Introduce 'no5lvl' kernel parameter
In-Reply-To: <20180518103528.59260-5-kirill.shutemov@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1805191046150.1599@nanos.tec.linutronix.de>
References: <20180518103528.59260-1-kirill.shutemov@linux.intel.com> <20180518103528.59260-5-kirill.shutemov@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2018, Kirill A. Shutemov wrote:

> The kernel parameter allows to force kernel to use 4-level paging even
> if hardware and kernel support 5-level paging.
> 
> The option may be useful to workaround regressions related to 5-level
> paging.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
