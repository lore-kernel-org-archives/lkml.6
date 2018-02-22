Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932382AbeBVNGk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:06:40 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:51985 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753821AbeBVNGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:06:38 -0500
X-Google-Smtp-Source: AG47ELt809oHVt3Fhhg4bl3h14por9RfRbg4d/KnFQ3Fj3f6dBMg5IqLGWhVDvZ5as0LobwczGS0BWZ64aVvX0hAJ/g=
MIME-Version: 1.0
In-Reply-To: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 14:06:37 +0100
Message-ID: <CACRpkdZYnQC5BusLyK5aAcA2q0NmvHu=TaLhFCfu2M0bgBcjrQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Introduce STMicroelectronics MultiFunction eXpander
To: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-gpio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amelie,

thanks a lot for your patches!

On Thu, Feb 8, 2018 at 3:27 PM, Amelie Delaunay <amelie.delaunay@st.com> wrote:

> This series adds support for STMicroelectronics MultiFunction eXpander
> (ST MFX), used on some STM32 discovery and evaluation boards.

So I take it that the department creating the STMPE
"ST MPE" or "ST Microelectronics MultiPurpose Expander"
Now created a new set of circuits?

Can we first establish whether this new family is really so
different from STMPE that it really needs a new driver in
MFD and GPIO (and I guess pin control as well)?

I would be annoyed to see later that it is just a few bytes
separating it from the STMPE, in that case I think it is
better to just reuse/improve the good old stmpe driver
and take it from there.

Yours,
Linus Walleij
