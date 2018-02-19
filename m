Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753027AbeBSOtK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:49:10 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41361 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeBSOtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:49:07 -0500
X-Google-Smtp-Source: AH8x227tILHqsR0882CgUexROVoPzpvvMW0w3TfXk795FKTBSJWeVyOX0Bg/Cx9yEOh7ie/M2fMi+g==
Date: Mon, 19 Feb 2018 08:49:05 -0600
From: Rob Herring <robh@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Tali Perry <tali.perry1@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>, Rick Altherr <raltherr@google.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Nancy Yuen <yuenn@google.com>, Patrick Venture <venture@google.com>
Subject: Re: [PATCH v2 1/1] clk: npcm750: update text with fixed clocks
Message-ID: <20180219144905.bfrycjnas7dcuo34@rob-hp-laptop>
References: <1518701959-22899-1-git-send-email-tali.perry1@gmail.com>
 <1518701959-22899-2-git-send-email-tali.perry1@gmail.com>
 <CAFd5g44gBJp0-mYEWGdyiA67BCi2pZWAG2bYPS-WdJEwH1oA5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g44gBJp0-mYEWGdyiA67BCi2pZWAG2bYPS-WdJEwH1oA5A@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 02:38:12PM -0800, Brendan Higgins wrote:
> On Thu, Feb 15, 2018 at 5:39 AM, Tali Perry <tali.perry1@gmail.com> wrote:
> >
> > Signed-off-by: Tali Perry <tali.perry1@gmail.com>
> >
>  <snip>
> 
> I think this should probably be rolled into [PATCH v2 1/1] npcm750: add fixed
> clocks (moved from drivers/clk/clk-npcm7xx.c):
> https://www.spinics.net/lists/arm-kernel/msg634678.html

No, binding docs, dts files and driver code should all be separate 
patches.

Rob
