Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754327AbeBGUFZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:05:25 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:55886 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753721AbeBGUFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:05:24 -0500
X-Google-Smtp-Source: AH8x225zwJ5PdHzUohmB39NNlF3kGcFxlgv8P7oYeb6HwPe4uWJJ/Em8EPKqloZ9ImH/k9MeSOVvsA==
Message-ID: <1518033920.1872.23.camel@redhat.com>
Subject: Re: [PATCH] x86/microcode/intel: print previous microcode revision
 during early update
From: Stanislav Kozina <skozina@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Petr Oros <poros@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 07 Feb 2018 21:05:20 +0100
In-Reply-To: <20180207152158.GB8698@pd.tnic>
References: <20180126103451.16863-1-poros@redhat.com>
         <20180126104109.slxxoq4vkqytqjxd@pd.tnic>
         <1516967135.2801.1.camel@redhat.com>
         <20180126115800.bvqrzik2f3hmmiah@pd.tnic>
         <1516974600.2801.10.camel@redhat.com>
         <20180126144918.7jiaezmdhjsiman5@pd.tnic>
         <1518012133.13585.13.camel@redhat.com> <20180207152158.GB8698@pd.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.2 (3.26.2-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Now let's take a step back: you don't really need the previous revision
> in the spectre case! Not really.

I understand all your points.

We submitted the patch to ease debugging of microcode issues where the
systems impacted are not yet identified and thus can't be blacklisted.

Best Regards,
-Stanislav
