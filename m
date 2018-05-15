Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752251AbeEOGyK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:54:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52312 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbeEOGyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:54:09 -0400
X-Google-Smtp-Source: AB8JxZrOpboGUrIVhUmUurHsRAnRHsIurThvveGkhw/bFTwB28YbkJPo4om7uPgyJYQmS0shlS6LiA==
Date: Tue, 15 May 2018 08:54:05 +0200
From: Ingo Molnar <mingo@kernel.org>
To: hpa@zytor.com
Cc: David Laight <David.Laight@ACULAB.COM>,
        "'Alexey Dobriyan'" <adobriyan@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86: pad assembly functions with INT3
Message-ID: <20180515065405.GA31240@gmail.com>
References: <20180507213755.GA32406@avx2>
 <20fb84fd5eef4c45b2d38d0290235d5d@AcuMS.aculab.com>
 <5c6762fe-5cbe-42ed-ac4e-a7144b8ef7ad@zytor.com>
 <83866d054b27419c9d9dd97d9c66c3de@AcuMS.aculab.com>
 <D6F6643E-1206-4D87-B8ED-5FF17C15A0EF@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D6F6643E-1206-4D87-B8ED-5FF17C15A0EF@zytor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* hpa@zytor.com <hpa@zytor.com> wrote:

> > I guess it won't try to speculatively execute the 'pad' instructions - but you 
> > can never really tell!
> >
> >	David
> 
> The CPU doesn't speculate down past an unconditional control transfer. Doing so 
> would be idiotic.

I think, when it comes to speculative execution, our general expectation that CPUs 
don't do idiotic things got somewhat weakened in the past year or so ...

Thanks,

	Ingo
