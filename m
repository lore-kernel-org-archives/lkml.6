Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeCOVGc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 17:06:32 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39095 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbeCOVGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 17:06:30 -0400
X-Google-Smtp-Source: AG47ELv5nDPUO0t3E8P1Wr0zabZ29WILlLhUFmxfwOZCo6PvNGtykGXOfdKfloOXcfZ/t1WE6OE1Pls8fMaFZEY+NKs=
MIME-Version: 1.0
In-Reply-To: <20180316075629.019b6560@canb.auug.org.au>
References: <20180316075629.019b6560@canb.auug.org.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Mar 2018 22:06:29 +0100
X-Google-Sender-Auth: fFMtXnBJBbNBzgqL5XRI-9XR6OE
Message-ID: <CAK8P3a2-fUi0nnsLVJ6h_UuJCgwoNs2OEroYed2ofLd=FiPG0g@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the arm-soc tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 9:56 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Commit
>
>   9a5f4879cd8d ("ARM: dts: stih4xx: Add missing #sound-dai-cells")
>
> is missing a Signed-off-by from its committer.

Thanks for the report.

What script do you use to find those? I guess I should check for
missing signoffs as well when pulling a branch.

Patrice, I've dropped the merge now, and picked up the one
patch in it directly, with my signoff. This should fix the issue this
time, but please make sure you always sign off patches when
you apply them from the list.

        Arnd
