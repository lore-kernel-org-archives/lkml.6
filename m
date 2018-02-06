Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbeBFQl0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:41:26 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:37260 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbeBFQlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:41:16 -0500
X-Google-Smtp-Source: AH8x227+LJLaJ18UjSiznRkF3kYbyHDra29nBENt09cOPsf2VVnBdNvI/SpTC9PoFmC0mo8DC6sxFdnKCiDjn59Yp+c=
MIME-Version: 1.0
In-Reply-To: <20180206161447.GF12679@lunn.ch>
References: <1517930036-17618-1-git-send-email-svendev@arcx.com> <20180206161447.GF12679@lunn.ch>
From: Sven Van Asbroeck <thesven73@gmail.com>
Date: Tue, 6 Feb 2018 11:41:14 -0500
Message-ID: <CAGngYiWYChnZmU7n9i1+nbY+1oWGXQGOopBhNiPHPUoYvTdgaw@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] spi_ks8995: use regmap to access chip registers.
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sven Van Asbroeck <svendev@arcx.com>, Woojung.Huh@microchip.com,
        Tristram.Ha@microchip.com, f.fainelli@gmail.com,
        helmut.buchsbaum@gmail.com, Maarten.Blomme@flir.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 6, 2018 at 11:14 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> Rather than invest time in this driver, it would be better to look
> into writing a DSA driver.

Thank you Andrew. I know little of DSA, but at first sight it appears to
be a _very_ complicated beast for a switch PHY which only
needs a few static register settings applied to it on startup, and has
no further Linux interaction? That's how we use the part, anyway.
Not sure what its typical use case would be.

Woojung and Tristam, what do you think ?
ksz8795 datasheet:
http://ww1.microchip.com/downloads/en/DeviceDoc/00002112B.pdf
