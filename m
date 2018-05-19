Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeESItL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 04:49:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55251 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752140AbeESItI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 04:49:08 -0400
Date: Sat, 19 May 2018 10:49:01 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 0/7] 5-level paging changes for v4.18
In-Reply-To: <20180518103528.59260-1-kirill.shutemov@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1805191048340.1599@nanos.tec.linutronix.de>
References: <20180518103528.59260-1-kirill.shutemov@linux.intel.com>
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

> Here's several patches that I would like to queue for v4.18. Please review
> and consider applying.
> 
> In this version I've addressed Thomas' feedback.
> 
> Changing __pgtable_l5_enabled to __initdata is not as trivial as I hoped.
> It requires few tricks to avoid section mismatch. I'm not sure if it worth
> the gain. We can keep it __ro_after_init.
> 
> If you feel it's too invasive, just drop last three patches.

Well done. Thanks for cleaning it up.

Thanks,

	tglx
