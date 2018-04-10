Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753172AbeDJMaW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:30:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:32938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752692AbeDJMaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:30:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8CAB21785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AIpwx49grxubOJIJiAUzMrcwkIcBboNHpEt2ga3iGWtIhPA+PrhkkRZskvFobAoFaxjooEharML0TzENIvqCcFRCiHk=
MIME-Version: 1.0
In-Reply-To: <20180410102927.17787-1-lukma@denx.de>
References: <20180403101525.22369-1-lukma@denx.de> <20180410102927.17787-1-lukma@denx.de>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 10 Apr 2018 07:29:58 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJii+ssU8kjVgqvSn77smMb4+gkT=PcwfCwvavReuAo+g@mail.gmail.com>
Message-ID: <CAL_JsqJii+ssU8kjVgqvSn77smMb4+gkT=PcwfCwvavReuAo+g@mail.gmail.com>
Subject: Re: [PATCH v2] display: panel: Add AUO g070vvn01 display support (800x480)
To: Lukasz Majewski <lukma@denx.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 5:29 AM, Lukasz Majewski <lukma@denx.de> wrote:
> This commit adds support for AUO's 7.0" display.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
>
> ---
> Changes for v2:
> - Add *.txt suffix to the auo,g070wn01 file
> - Remove not needed bus-format-override = "rgb565"; property
> ---
>  .../bindings/display/panel/auo,g070vvn01.txt       | 30 +++++++++++++++++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 31 ++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/auo,g070vvn01.txt

Reviewed-by: Rob Herring <robh@kernel.org>
