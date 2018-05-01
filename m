Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754204AbeEAIoy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 04:44:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46620 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751920AbeEAIow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 04:44:52 -0400
Date: Tue, 1 May 2018 10:44:34 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/6] x86/microcode/AMD: Check microcode container data
 in the early loader
Message-ID: <20180501084434.GD31863@pd.tnic>
References: <cover.1524515406.git.mail@maciej.szmigiero.name>
 <60157b92eef72a73778d9e483b5376db737b5a97.1524515406.git.mail@maciej.szmigiero.name>
 <20180430090506.GB6509@pd.tnic>
 <587188f6-fe91-f2e4-4e41-cb9bc808ecf0@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <587188f6-fe91-f2e4-4e41-cb9bc808ecf0@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 12:27:34AM +0200, Maciej S. Szmigiero wrote:
> If we want to make the parser more resistant to garbage or
> forward-compatible to containers with a different main magic number in
> their headers we probably should return a length of a single byte here
> instead of 12 (CONTAINER_HDR_SZ) so the parser would correctly skip
> unknown data of size which isn't an integer multiple of this number.

Ok.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
