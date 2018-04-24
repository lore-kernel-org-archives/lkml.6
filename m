Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751095AbeDXXio (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 19:38:44 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:33550 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeDXXim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 19:38:42 -0400
Date: Wed, 25 Apr 2018 09:38:22 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sam Creasey <sammy@sammy.net>, linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] m68k: Fix off-by-one calendar month
In-Reply-To: <CAMuHMdVh8Pg9r9OoDzh9fWmkcuS1NDQUBOLzRQkiKXD+V+XbPA@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1804250921010.8@nippy.intranet>
References: <5add30d1.1c69fb81.b868a.84f1SMTPIN_ADDED_MISSING@mx.google.com> <CAMuHMdULPOWQPo1G1s5m52rNLzhmPFzfwxsZH0iR_OwVc8VRKw@mail.gmail.com> <20180424103737.GA19011@piout.net> <CAMuHMdVh8Pg9r9OoDzh9fWmkcuS1NDQUBOLzRQkiKXD+V+XbPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018, Geert Uytterhoeven wrote:

> 
> Upon closer look, it's not, as Amiga no longer provides mach_hwclk().

Right, Amiga is not affected. However, if you disable CONFIG_RTCHCTOSYS or 
CONFIG_RTC_DRV_GENERIC, you should see an improvement on Atari, BVME6000, 
Mac and Q40.

-- 
