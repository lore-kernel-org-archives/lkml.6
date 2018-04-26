Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754556AbeDZXfj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 19:35:39 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36247 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbeDZXfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 19:35:37 -0400
X-Google-Smtp-Source: AB8JxZqrZmaFL1ARE8wIFu/Ziaki3xkMBlTfThQRo0SqIdyaZV3gTVlSX/7bhyxM+02vrC4Xur+K8w==
From: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: meson-gx: add device reset
Organization: BayLibre
References: <20180426103817.12675-1-jbrunet@baylibre.com>
Date: Thu, 26 Apr 2018 16:35:34 -0700
In-Reply-To: <20180426103817.12675-1-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Thu, 26 Apr 2018 12:38:17 +0200")
Message-ID: <7ha7tp35ix.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Trigger the reset line of the mmc controller while probing, if available
> The reset should be optional for now, at least until all related DT node
> have the reset property
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
