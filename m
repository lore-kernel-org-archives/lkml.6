Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbeDQIPh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 04:15:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37498 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751096AbeDQIPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 04:15:35 -0400
Date: Tue, 17 Apr 2018 10:14:58 +0200
From: Borislav Petkov <bp@alien8.de>
To: =?utf-8?B?SsO2cmc=?= Otte <jrg.otte@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 4.17.0-rc1 doesn't boot.
Message-ID: <20180417081458.GA2894@pd.tnic>
References: <CADDKRnAp1EKCAosD-kLNRaJ4qJppUtmmP1n76wzcvNUVa0fQzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADDKRnAp1EKCAosD-kLNRaJ4qJppUtmmP1n76wzcvNUVa0fQzg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 10:00:25AM +0200, Jörg Otte wrote:
> Maybe the problem came in with:
> 6b0a02e:  "Merge branch 'x86-pti-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip"

Fetch latest Linus master and try again - there might be a relevant fix
there.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
