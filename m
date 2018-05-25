Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965185AbeEYIhF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 04:37:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41922 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964791AbeEYIhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 04:37:04 -0400
Date: Fri, 25 May 2018 10:36:59 +0200
From: Borislav Petkov <bp@alien8.de>
To: Scott Wood <swood@redhat.com>
Cc: linux-kernel@vger.kernel.org, Pei Zhang <pezhang@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH] x86/microcode: Make update_lock raw
Message-ID: <20180525083659.GA23867@pd.tnic>
References: <20180524154420.24455-1-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180524154420.24455-1-swood@redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 10:44:20AM -0500, Scott Wood wrote:
> __reload_late() is called from stop_machine context and thus
> cannot acquire a non-raw spinlock on PREEMPT_RT.
> 
> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
>  arch/x86/kernel/cpu/microcode/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
