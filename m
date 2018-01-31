Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeAaAEi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 19:04:38 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39626 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbeAaAEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 19:04:35 -0500
X-Google-Smtp-Source: AH8x224aLhYDIMm8l1IVseZ2a3n4dDjYDYF8SFfSEpisZTZWHKfBpUvKCPwG0IWMBYPBxu2gwhzdYA==
From: Kevin Hilman <khilman@baylibre.com>
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: <devicetree@vger.kernel.org>, Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Carlo Caione <carlo@caione.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] ARM64: dts: meson-axg: UART DT updates
Organization: BayLibre
References: <20180111023401.125658-1-yixun.lan@amlogic.com>
Date: Tue, 30 Jan 2018 16:04:31 -0800
In-Reply-To: <20180111023401.125658-1-yixun.lan@amlogic.com> (Yixun Lan's
        message of "Thu, 11 Jan 2018 10:33:56 +0800")
Message-ID: <7hr2q6c2r4.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yixun Lan <yixun.lan@amlogic.com> writes:

> HI Kevin
>  These are the UART DT updates for the Meson-AXG platform.
>
>  The patch 1 is a general fix.
> Other patches are about adding clock & pinctrl info, then using them.
> Last patch enable UART_A which connect to a BT module on the S400 board.

Applied to v4.16/dt64,

Thanks,

Kevin
