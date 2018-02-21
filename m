Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933529AbeBULjJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 06:39:09 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46189 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932228AbeBULjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 06:39:08 -0500
X-Google-Smtp-Source: AH8x2241eoa9KdvewlKW7Fg3OpLEw8I4ak6mHBpnxCVxdK8YUcjmKIQiKQbNlUhBr3NzN0KoDNmMeQ==
Date: Wed, 21 Feb 2018 12:39:05 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] x86/MCE: Put private structures and definitions into
 the internal header
Message-ID: <20180221113905.hwderlbfbx2dkisn@gmail.com>
References: <20180221101900.10326-1-bp@alien8.de>
 <20180221101900.10326-2-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221101900.10326-2-bp@alien8.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> ... because they don't need to be exported outside of MCE.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/include/asm/mce.h                | 52 -------------------------------
>  arch/x86/kernel/cpu/mcheck/mce-internal.h | 52 +++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+), 52 deletions(-)

Hm, this doesn't apply to latest upstream anymore:

 Hunk #1 FAILED at 113.
 1 out of 1 hunk FAILED -- saving rejects to file arch/x86/kernel/cpu/mcheck/mce-internal.h.rej

mind forward porting it?

Thanks,

	Ingo
