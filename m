Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeC3ISI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 04:18:08 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40128 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbeC3IQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 04:16:37 -0400
X-Google-Smtp-Source: AIpwx48Tj3g7xIh5PyAnWiU8/rdVCWeMRLyu0DwSI12161IgTRYcZupstjnht88kj8sZ/i8goc929A==
MIME-Version: 1.0
In-Reply-To: <20180206044905.30508-9-icenowy@aosc.io>
References: <20180206044905.30508-1-icenowy@aosc.io> <20180206044905.30508-9-icenowy@aosc.io>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 30 Mar 2018 16:16:13 +0800
X-Gmail-Original-Message-ID: <CAGb2v65_w4LY-5RJqZN2+Rd3jwnD2upJovibgnUY2FrPwVPROw@mail.gmail.com>
Message-ID: <CAGb2v65_w4LY-5RJqZN2+Rd3jwnD2upJovibgnUY2FrPwVPROw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 08/10] ARM: sun8i: h3: Add SY8106A
 regulator to Orange Pi PC
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Ondrej Jirman <megous@megous.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 6, 2018 at 12:49 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> Add SY8106A regulator to r_i2c bus and enable the r_i2c bus on
> Orange Pi PC, then set the power supply of the ARM cores to this
> regulator, in order to enable DVFS.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> [Icenowy: Enable DVFS in this patch, slight changes and change commit
>  message]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
