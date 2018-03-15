Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbeCOA5O (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 20:57:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34844 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751405AbeCOA5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 20:57:13 -0400
Date: Thu, 15 Mar 2018 01:56:34 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/9] x86/microcode/AMD: install_equiv_cpu_table()
 should not return (signed) int
Message-ID: <20180315005634.GC11061@pd.tnic>
References: <cover.1520973389.git.mail@maciej.szmigiero.name>
 <cf57ed15-df47-087e-c98f-527e4ce1e0f8@maciej.szmigiero.name>
 <20180314175824.GG16605@pd.tnic>
 <b913d9fd-9722-d5cc-cf94-426885947890@maciej.szmigiero.name>
 <20180314235812.GB11061@pd.tnic>
 <21fe4521-0fc7-c5ed-5a2a-4c7e93097385@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21fe4521-0fc7-c5ed-5a2a-4c7e93097385@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 01:13:07AM +0100, Maciej S. Szmigiero wrote:
> This can be done if this function is modified to return only the CPU
> equivalence table length (without the container header length), leaving
> its single caller the job of adding the container header length to skip
> to the fist patch section.

Sure, it leaves the function to deal with the equiv table length only
and the caller then adds the header length. Which is actually cleaner.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
