Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756276AbeBOWiR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 17:38:17 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:35835 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756260AbeBOWiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 17:38:15 -0500
X-Google-Smtp-Source: AH8x227x6HkQXLcXl9iK+o2MGTFKZg0/FW1XFLE/5wkbuV+7hWbsodJOfzeleZmWIq6kg9OOKYF3plSYcqCTM8QKDXc=
MIME-Version: 1.0
In-Reply-To: <1518701959-22899-2-git-send-email-tali.perry1@gmail.com>
References: <1518701959-22899-1-git-send-email-tali.perry1@gmail.com> <1518701959-22899-2-git-send-email-tali.perry1@gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 15 Feb 2018 14:38:12 -0800
Message-ID: <CAFd5g44gBJp0-mYEWGdyiA67BCi2pZWAG2bYPS-WdJEwH1oA5A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] clk: npcm750: update text with fixed clocks
To: Tali Perry <tali.perry1@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>, Rick Altherr <raltherr@google.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Nancy Yuen <yuenn@google.com>, Patrick Venture <venture@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 5:39 AM, Tali Perry <tali.perry1@gmail.com> wrote:
>
> Signed-off-by: Tali Perry <tali.perry1@gmail.com>
>
 <snip>

I think this should probably be rolled into [PATCH v2 1/1] npcm750: add fixed
clocks (moved from drivers/clk/clk-npcm7xx.c):
https://www.spinics.net/lists/arm-kernel/msg634678.html

Cheers
