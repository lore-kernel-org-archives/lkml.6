Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934395AbeCHBYs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 20:24:48 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41598 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755021AbeCHBYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 20:24:46 -0500
X-Google-Smtp-Source: AG47ELt5HVpGRo8Cv3GU/LonC5FJeLY+YKmPlI+T4qPkzrM7phmrtTVahEhqwR1sctXqYNH47KCUWQ==
From: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, ellierevves@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM64: dts: meson: reduce odroid-c2 eMMC maximum rate
Organization: BayLibre
References: <20180302134436.18844-1-jbrunet@baylibre.com>
Date: Wed, 07 Mar 2018 17:24:43 -0800
In-Reply-To: <20180302134436.18844-1-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Fri, 2 Mar 2018 14:44:36 +0100")
Message-ID: <7hy3j3fjfo.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Different modules maybe installed by the user on the eMMC connector
> of the odroid-c2. While the red modules are working without an issue,
> it seems some black modules (apparently Samsung based) are having
> issue at 200MHz
>
> While the tuning algorithm introduced in v4.14 enables high speed modes
> on every other tested designs, it seems a problem remains for this
> particular combination of board and eMMC module.
>
> Lowering the maximum frequency of the eMMC on this board until we can
> figure out a better solution.
>
> Fixes: d341ca88eead ("mmc: meson-gx: rework tuning function")
> Suggested-by: Ellie Reeves <ellierevves@gmail.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Applied to v4.17/dt64 and Cc'd to stable,

Kevin
