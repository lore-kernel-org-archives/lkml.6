Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935099AbeCAHfX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 02:35:23 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50402 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932243AbeCAHfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 02:35:22 -0500
Date: Thu, 1 Mar 2018 08:35:20 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Woody Suwalski <terraluna977@gmail.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        William Grant <william.grant@canonical.com>
Subject: Re: 4.16 regression: s2ram broken on non-PAE i686
In-Reply-To: <80bffdab-be19-17f3-f3ba-bf96050130ee@gmail.com>
Message-ID: <alpine.DEB.2.21.1803010834150.1392@nanos.tec.linutronix.de>
References: <CAM6Zs0WTjWW+Lw3ws_iAH-K1dJgd5r9s0oC=u4TgEFUyC5bxig@mail.gmail.com> <alpine.DEB.2.21.1802280959180.1886@nanos.tec.linutronix.de> <da61401a-5d97-c925-ef0b-fcd937c2712a@gmail.com> <alpine.DEB.2.21.1802282137290.1392@nanos.tec.linutronix.de>
 <80bffdab-be19-17f3-f3ba-bf96050130ee@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2018, Woody Suwalski wrote:
> Thanks for the patch, good news, it did fix the problem.
> I did 2 builds and both worked OK over the s2ram cycle.

Good.

> It will be necessary to add the patch to 4.15-stable and 4.14-stable, I
> believe that both have now broken s2ram.

Right, it's already tagged for stable.

Thanks,

	tglx
