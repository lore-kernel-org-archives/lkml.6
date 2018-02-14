Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754629AbeBNINX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 03:13:23 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38930 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754585AbeBNINW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 03:13:22 -0500
X-Google-Smtp-Source: AH8x2250wg3WSLyKE6zgLwCeb6evY+Nnjr9830bF/Pn2kHDS6kIepUf1/Q6wXwMAD6mIYPUqgm9ufg==
Date: Wed, 14 Feb 2018 09:13:17 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Matt Turner <mattst88@gmail.com>
Cc: Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 2/2] x86: msr-index.h: Correct SNB_C1/C3_AUTO_UNDEMOTE
 defines
Message-ID: <20180214081317.wux6xnkksqq36hxa@gmail.com>
References: <20180213191205.7057-1-mattst88@gmail.com>
 <20180213191205.7057-2-mattst88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213191205.7057-2-mattst88@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Matt Turner <mattst88@gmail.com> wrote:

> According to the Intel Software Developers' Manual, Vol. 4, Order No.
> 335592, these macros have been reversed since they were added in the
> initial turbostat commit. The reversed definitions were presumably
> copied from turbostat.c to this file.
> 
> Fixes: 9c63a650bb10 ("tools/power/x86/turbostat: share kernel MSR #defines")
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
