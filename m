Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758888AbeD0TPn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 15:15:43 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36475 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758707AbeD0TPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 15:15:41 -0400
X-Google-Smtp-Source: AB8JxZpuOVeR+ZMICBXAybqtEQEqacnb1kvKF5mdU5IMD81y0qyvGJz3gK87y3mQmHko08rqlz/kcg==
From: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM64: dts: meson: disable sd-uhs modes on the libretech-cc
Organization: BayLibre
References: <20180426105046.14817-1-jbrunet@baylibre.com>
Date: Fri, 27 Apr 2018 12:15:39 -0700
In-Reply-To: <20180426105046.14817-1-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Thu, 26 Apr 2018 12:50:46 +0200")
Message-ID: <7hvacczcis.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> There is a problem with the sd-uhs mode when doing a soft reboot.
> Switching back from 1.8v to 3.3v messes with the card, which no longer
> respond (timeout errors). According to the specification, we should
> perform a card reset (power cycling the card) but this is something we
> cannot control on this design.
>
> Then the only solution to restore the communication with the card is an
> "unplug-plug" which is not acceptable
>
> Until we find a solution, if any, disable the sd-uhs modes on this design.
> For the people using uhs at the moment, there will a performance drop as
> a result.
>
> Fixes: 3cde63ebc85c ("ARM64: dts: meson-gxl: libretech-cc: enable high speed modes")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Applied to v4.17/fixes, and adding a Cc to stable.

Thanks,

Kevin
