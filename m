Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756427AbeEJFIK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 01:08:10 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:37792 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbeEJFII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 01:08:08 -0400
Date: Thu, 10 May 2018 07:08:03 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/8] export.h: remove code for prefixing symbols with
 underscore
Message-ID: <20180510050803.GA19160@ravnborg.org>
References: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
 <1525850632-10921-6-git-send-email-yamada.masahiro@socionext.com>
 <20180509160727.GA7459@ravnborg.org>
 <CAK7LNATojTR5QbWNS2LCeRXTX-8Rj3P2VoZaYZQhY5Kb0fv1Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATojTR5QbWNS2LCeRXTX-8Rj3P2VoZaYZQhY5Kb0fv1Mg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
        a=kj9zAlcOel0A:10 a=inz-ai5mh7p5OQTDc6UA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mashahiro

> Anyway VMLINUX_SYMBOL(), VMLINUX_SYMBOL_STR() will not live long.
> I need some cycles for tree-wide cleaning, though.

Fine, then there is no need to discuss the details of their
current definition.

	Sam
