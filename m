Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753485AbeDVSrI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 14:47:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52860 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753385AbeDVSrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 14:47:07 -0400
Date: Sun, 22 Apr 2018 20:47:05 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT pull] x86 fixes for 4.17
In-Reply-To: <CA+55aFwLa72-0n4PQj5A2ruGCPSyRS7cJM3Z+wKCO9_TCn7YnQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1804222046170.6136@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1804221251260.6136@nanos.tec.linutronix.de> <CA+55aFwLa72-0n4PQj5A2ruGCPSyRS7cJM3Z+wKCO9_TCn7YnQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Apr 2018, Linus Torvalds wrote:

> On Sun, Apr 22, 2018 at 4:04 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > A small set of fixes for x86:
> 
> Hmm. Not the fixes for the global bit problems that caused a couple of
> pretty bad issues?
> 
> I realize that they wanted testing, but considering how bad the
> current situation is...

They hit my inbox on friday night and given the issues the first set had, I
rather let them exposed to 0bot and review them carefully.

Thanks,

	tglx
