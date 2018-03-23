Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeCWSpb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 14:45:31 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:37643 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbeCWSp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 14:45:28 -0400
X-Google-Smtp-Source: AIpwx48rIvQId2HuTQASH+l8W2lwyQ8j7Ya9gkBuSgX8oabcFKjTNexPONjOh/TPT629PNbTq8ERBchF2G+DQPv2eLk=
MIME-Version: 1.0
In-Reply-To: <20180323181452.GJ5799@atomide.com>
References: <20180323181452.GJ5799@atomide.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 23 Mar 2018 15:45:27 -0300
Message-ID: <CAOMZO5Bmpk4cwav-qTnNA6L16DwdDPp5LeKC-jY9=QzfVBuKSQ@mail.gmail.com>
Subject: Re: Regression with arm in next with stack protector
To: Tony Lindgren <tony@atomide.com>
Cc: Huacai Chen <chenhc@lemote.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Rich Felker <dalias@libc.org>,
        Russell King <linux@arm.linux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-omap@vger.kernel.org,
        James Hogan <james.hogan@mips.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 3:14 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> Looks like commit 5638790dadae ("zboot: fix stack protector in
> compressed boot phase") breaks booting on arm.

Yes, almost all imx are broken in linux-next due to this commit:
https://kernelci.org/soc/imx/job/next/kernel/next-20180323/
