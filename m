Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753505AbeEAISj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 04:18:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45806 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751081AbeEAISh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 04:18:37 -0400
Date: Tue, 1 May 2018 10:18:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/6] x86/microcode/AMD: Add microcode container data
 checking functions
Message-ID: <20180501081819.GB31863@pd.tnic>
References: <cover.1524515406.git.mail@maciej.szmigiero.name>
 <ea8b42f1d7a0fa75b2a13758f71f6c486862ab47.1524515406.git.mail@maciej.szmigiero.name>
 <20180430090447.GA6509@pd.tnic>
 <c4a49546-a4bb-c7a5-116a-be537bacb688@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4a49546-a4bb-c7a5-116a-be537bacb688@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 12:27:17AM +0200, Maciej S. Szmigiero wrote:
> These checking functions are supposed to be called in order:

We don't do magical rules like that - you either verify fully and
correctly or you don't bother at all. And since you're adamant that this
verification needs to happen, then please do it completely.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
