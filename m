Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751944AbeCJJS5 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 04:18:57 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48598 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750829AbeCJJSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 04:18:55 -0500
Date: Sat, 10 Mar 2018 10:18:38 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode/AMD: check microcode file sanity before
 loading it
Message-ID: <20180310091838.GA8261@pd.tnic>
References: <34e9d679-2eca-90cf-9a95-3864f0be060e@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <34e9d679-2eca-90cf-9a95-3864f0be060e@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 10, 2018 at 01:34:45AM +0100, Maciej S. Szmigiero wrote:
> Currently, it is very easy to make the AMD microcode update driver crash
> or spin on a malformed microcode file since it does very little
> consistency checking on data loaded from such file.

Sorry but if one has enough permissions to install malformed microcode,
crashing the loader is the least of your problems. IOW, I don't see the
justification for the unnecessary complication with all those checks.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
