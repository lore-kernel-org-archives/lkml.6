Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752926AbeBFQ6e (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:58:34 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:52930 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753010AbeBFQ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:58:19 -0500
X-Google-Smtp-Source: AH8x227GJUJRI8SQK5ROXyEAy9YrHGdNHc1K0HphItEombJ0C/80IcMu/KTfHsAj1KhwdCfXJK/JB6JaMzEjMzNJEU4=
MIME-Version: 1.0
In-Reply-To: <20180206165009.GJ12679@lunn.ch>
References: <1517930036-17618-1-git-send-email-svendev@arcx.com>
 <20180206161447.GF12679@lunn.ch> <CAGngYiWYChnZmU7n9i1+nbY+1oWGXQGOopBhNiPHPUoYvTdgaw@mail.gmail.com>
 <20180206165009.GJ12679@lunn.ch>
From: Sven Van Asbroeck <thesven73@gmail.com>
Date: Tue, 6 Feb 2018 11:58:17 -0500
Message-ID: <CAGngYiWR-ayfg4KiH4yzoey+7P-jjV9MjEv8STmS65aC9JTX5Q@mail.gmail.com>
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

On Tue, Feb 6, 2018 at 11:50 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> And a DSA driver does not need to be complex. You can start simple,
> and add more features later.

I see. Would it be possible/practical to start with just phy_read/write,
port_enable/disable in dsa_switch_ops ? And just add a sysfs bin file
for userspace register access ?
