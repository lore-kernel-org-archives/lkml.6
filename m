Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753443AbeBSS3s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 13:29:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:60496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753272AbeBSS3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 13:29:46 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C642177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AH8x2268Qv5A4pfFCCV45gemwFJl48kaVFMI/AE7W5YC+DZieNqHuir1jEapoUIDVaW001pJ8OCqanqr+9x6VxVnuQw=
MIME-Version: 1.0
In-Reply-To: <61928ad523a7aeffb8f16d4caad56836b65ae407.1518424204.git.ryder.lee@mediatek.com>
References: <cover.1518424204.git.ryder.lee@mediatek.com> <61928ad523a7aeffb8f16d4caad56836b65ae407.1518424204.git.ryder.lee@mediatek.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 19 Feb 2018 12:29:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJgo0pKJjrs2fdw+q=DJYwht0X5L3Bomz8gf98mEN7hkg@mail.gmail.com>
Message-ID: <CAL_JsqJgo0pKJjrs2fdw+q=DJYwht0X5L3Bomz8gf98mEN7hkg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] dt-bindings: clock: mediatek: update audsys
 documentation to adapt MFD device
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Garlic Tseng <garlic.tseng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 5:28 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> The MediaTek audio hardware block that exposes functionalities that are
> handled by separate subsystems in the kernel.  These functions are all
> mapped somewhere at 0x112xxxxx, and there are some control bits are mixed
> up with other functions within the same registers.

I still don't think this change is necessary.

Just because a hardware block in DT maps to different subsystems in a
particular OS doesn't mean you need a DT node for each OS subsystem.
What we have subsystems for changes over time and DT shouldn't really
be changing based on that. And DT is not the only way to instantiate
drivers.

Rob
