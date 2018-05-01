Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbeEAUDc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 16:03:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39098 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750785AbeEAUDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 16:03:31 -0400
Date: Tue, 1 May 2018 22:03:08 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/6] x86/microcode/AMD: Check microcode container data
 in the late loader
Message-ID: <20180501200308.GC13171@pd.tnic>
References: <cover.1524515406.git.mail@maciej.szmigiero.name>
 <8f204a953dc4b46477e214ebd291021d7ab6fa6c.1524515406.git.mail@maciej.szmigiero.name>
 <20180430090527.GC6509@pd.tnic>
 <bce73502-0d18-e50c-b78b-8159dc9f8f66@maciej.szmigiero.name>
 <20180501084317.GC31863@pd.tnic>
 <e10212ef-c876-4965-6279-967005f53950@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e10212ef-c876-4965-6279-967005f53950@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 06:19:56PM +0200, Maciej S. Szmigiero wrote:
> -EINVAL cast to unsigned int is 4294967274 and this value is also
> a valid count of bytes to skip that this function can return.

And where exactly in the *old* code do we do that?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
