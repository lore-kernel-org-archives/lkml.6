Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752711AbeFAOe4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751792AbeFAOey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:34:54 -0400
X-Google-Smtp-Source: ADUXVKLqrnWRphfSvj7lKmL1DKukWcPJ43m1YZXs54YfVibrGOc6ykC4wYrMiWMoEvMAj9xYZITmyG5WHv5XihCOZyU=
MIME-Version: 1.0
In-Reply-To: <20180601082259.17563-5-johan@kernel.org>
References: <20180601082259.17563-1-johan@kernel.org> <20180601082259.17563-5-johan@kernel.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 1 Jun 2018 09:34:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJrOysayG5g6cGbvMVmBxkrjkSuAs4qb=DyuoTPwcrWRQ@mail.gmail.com>
Message-ID: <CAL_JsqJrOysayG5g6cGbvMVmBxkrjkSuAs4qb=DyuoTPwcrWRQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] dt-bindings: gnss: add u-blox binding
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andreas Kemnade <andreas@kemnade.info>, Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Pavel Machek <pavel@ucw.cz>, Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 3:22 AM, Johan Hovold <johan@kernel.org> wrote:
> Add binding for u-blox GNSS receivers.
>
> Note that the u-blox product names encodes form factor (e.g. "neo"),
> chipset (e.g. "8") and variant (e.g. "q"), but that only formfactor and
> chipset is used for the compatible strings (for now).
>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  .../devicetree/bindings/gnss/u-blox.txt       | 44 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt   |  1 +
>  2 files changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gnss/u-blox.txt

Reviewed-by: Rob Herring <robh@kernel.org>
