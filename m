Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753162AbeDRNxu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 09:53:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42820 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752560AbeDRNxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 09:53:49 -0400
Date: Wed, 18 Apr 2018 15:53:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/10] x86/microcode/AMD: Subtract SECTION_HDR_SIZE
 from file leftover length
Message-ID: <20180418135327.GA4795@pd.tnic>
References: <cover.1521150415.git.mail@maciej.szmigiero.name>
 <b4854b17-e3ba-54d6-488d-0e0bfffe4c71@maciej.szmigiero.name>
 <20180318161200.GA2036@cz.tnic>
 <fe58b934-eafe-9ed6-a089-a58caaf90fc8@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe58b934-eafe-9ed6-a089-a58caaf90fc8@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 02:39:27PM +0200, Maciej S. Szmigiero wrote:
> Can't really find this commit in any tree I have looked at (bp.git and
> tip.git at kernel.org).
> Was it pushed somewhere else?

No. Still waiting for the rest.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
