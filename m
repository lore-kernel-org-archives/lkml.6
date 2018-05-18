Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeEROYW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:24:22 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:44306 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbeEROYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:24:19 -0400
X-Google-Smtp-Source: AB8JxZpQd6eSOgC0E1yNifB3MaS7ju5h3wR5TUit0htRlIYsczPHsNpBrrHQUWv3ltnCyyK3wCYkfg==
Date: Fri, 18 May 2018 09:24:18 -0500
From: Rob Herring <robh@kernel.org>
To: David Lechner <david@lechnology.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 24/27] dt-bindings: timer: new bindings for TI
 DaVinci timer
Message-ID: <20180518142418.GA2298@rob-hp-laptop>
References: <20180509172606.29387-1-david@lechnology.com>
 <20180509172606.29387-25-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509172606.29387-25-david@lechnology.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 12:26:03PM -0500, David Lechner wrote:
> This adds new device tree bindings for the timer IP block of TI
> DaVinci-like SoCs.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v10 changes:
> - changed compatible to "ti,da830-timer"
> - added interrupts and interrupt-names properties
> - fixed grammatical error
> 
> v9 changes:
> - new patch in v9
> 
> 
>  .../bindings/timer/ti,davinci-timer.txt       | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/ti,davinci-timer.txt

Reviewed-by: Rob Herring <robh@kernel.org>
