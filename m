Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752665AbeDRO75 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:59:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45342 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751520AbeDRO74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:59:56 -0400
Date: Wed, 18 Apr 2018 16:59:36 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/10] x86/microcode/AMD: Subtract SECTION_HDR_SIZE
 from file leftover length
Message-ID: <20180418145936.GC4795@pd.tnic>
References: <cover.1521150415.git.mail@maciej.szmigiero.name>
 <b4854b17-e3ba-54d6-488d-0e0bfffe4c71@maciej.szmigiero.name>
 <20180318161200.GA2036@cz.tnic>
 <fe58b934-eafe-9ed6-a089-a58caaf90fc8@maciej.szmigiero.name>
 <20180418135327.GA4795@pd.tnic>
 <a3e54b86-412b-9d91-15d5-1055344eaa24@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3e54b86-412b-9d91-15d5-1055344eaa24@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 03:57:23PM +0200, Maciej S. Szmigiero wrote:
> So, should this patch be included in a respin or not?

Yes please. Do them all ontop of tip/master.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
