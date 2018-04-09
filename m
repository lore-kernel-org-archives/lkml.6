Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753250AbeDIQ3P (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:29:15 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33193 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753178AbeDIQ3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:29:14 -0400
X-Google-Smtp-Source: AIpwx4+E4FpTR1cuMdurtRgODuFs0LC2RNfy0Wesa3W7yzrD/45mcgU5e9hjdi/WqCp7lszwZTeUmw==
Date: Mon, 9 Apr 2018 18:29:10 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] x86/entry/64: Drop idtentry's manual stack switch for
 user entries
Message-ID: <20180409162910.macimdsmka5ecfmm@gmail.com>
References: <90aab80c1f906e70742eaa4512e3c9b5e62d59d4.1522794757.git.luto@kernel.org>
 <CALCETrX=B37UsduZRW2Qo_S28V=hFqTVeqHHnqKQpM+-sE=CnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrX=B37UsduZRW2Qo_S28V=hFqTVeqHHnqKQpM+-sE=CnQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Lutomirski <luto@kernel.org> wrote:

> On Tue, Apr 3, 2018 at 3:39 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > For non-paranoid entries, idtentry knows how to switch from the
> > kernel stack to the user stack, as does error_entry.  This results
> > in pointless duplication and code bloat.  Make idtentry stop
> > thinking about stacks for non-paranoid entries.
> >
> > This reduces text size by 5377 bytes.
> >
> 
> Just a quick ping to make sure you all noticed this.

LOL, incidentally I have applied it a couple of minutes ago! :-)

Thanks

	Ingo
