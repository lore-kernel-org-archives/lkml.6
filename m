Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932968AbeCJNMU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 08:12:20 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55150 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932130AbeCJNMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 08:12:19 -0500
Date: Sat, 10 Mar 2018 14:12:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode/AMD: check microcode file sanity before
 loading it
Message-ID: <20180310131202.GB8261@pd.tnic>
References: <34e9d679-2eca-90cf-9a95-3864f0be060e@maciej.szmigiero.name>
 <20180310091838.GA8261@pd.tnic>
 <2cfade76-7d3d-38be-8da6-5927a043a91b@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2cfade76-7d3d-38be-8da6-5927a043a91b@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 10, 2018 at 01:26:00PM +0100, Maciej S. Szmigiero wrote:
> Without them, it is easy to crash the driver when just playing with
> microcode files

You're not supposed to play with the microcode files. If you do and
something breaks, you get to keep the pieces.

If the official microcode files have a problem, then I'm all ears.
Anything else contrived which doesn't actually happen unless someone
manipulates them is not an issue the microcode loader should protect
against.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
