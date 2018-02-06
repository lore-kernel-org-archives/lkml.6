Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeBFFZ2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 00:25:28 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:44074 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbeBFFZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 00:25:21 -0500
X-Google-Smtp-Source: AH8x2273b7SoErI6aZf+V7oK9x3YjXiyzbvV9YiDWPbrl2HyBrS4C14T2lh0bFXIGJtY3T0+OePzTxBOytkGQGYAVrE=
MIME-Version: 1.0
In-Reply-To: <20180205105838.GZ31354@dragon>
References: <1517766571-409-1-git-send-email-jagan@amarulasolutions.com> <20180205105838.GZ31354@dragon>
From: Jagan Teki <jagannadh.teki@gmail.com>
Date: Tue, 6 Feb 2018 10:55:20 +0530
Message-ID: <CAD6G_RSp_8xWWRfvu_58rdvkE-V16otnE9ifxQkiNry76-TMXQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] ARM: dts: imx6q: engicam LVDS panel changes
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
        devicetree <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 4:28 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Sun, Feb 04, 2018 at 11:19:24PM +0530, Jagan Teki wrote:
>> Series adda LVDS panel attributes on panel drivers instead of defining
>> them in dts nodes, and also added new icorem6 engicam boards.
>>
>> Jagan Teki (7):
>>   drm/panel: simple: add support for Ampire AM-800480AYTZQW-00H
>>   ARM: dts: imx6q-icore: Switch LVDS timings from panel-simple
>>   ARM: dts: imx6dl-icore: Add LVDS node
>>   drm/panel: simple: Add support for KEO TX31D200VM0BAA
>>   ARM: dts: imx6q-icore-ofcap12: Switch LVDS timings from panel-simple
>>   ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual OpenFrame Cap 7
>>     initial support
>>   ARM: dts: imx6q: Add Engicam i.CoreM6 1.5 Quad/Dual MIPI starter kit
>>     support
>>
>>  .../display/panel/ampire,am-800480aytzqw-00h.txt   | 25 +++++++++
>>  .../bindings/display/panel/koe,tx31d200vm0baa.txt  | 25 +++++++++
> ...
>>  drivers/gpu/drm/panel/panel-simple.c               | 54 ++++++++++++++++++
>
> The dts files should really be sent only after above bindings doc and
> driver changes get merged first.

OK, I will send drm/panel changes first.
