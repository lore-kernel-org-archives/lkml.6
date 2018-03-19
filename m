Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934462AbeCSXkB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 19:40:01 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:39735 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932750AbeCSXkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 19:40:00 -0400
X-Google-Smtp-Source: AG47ELsn2grdDW9GECa5bCVKogVEV4S6Xw4G1k7rO+7YtcEJavEpNtWmMKjl3Fg3i8L2txewtQ5yfA==
From: Kevin Hilman <khilman@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michal Lazo <michal.lazo@gmail.com>
Subject: Re: [PATCH] ARM64: dts: meson: bump mali450 clk to 744MHz
Organization: BayLibre
References: <1520853021-5412-1-git-send-email-narmstrong@baylibre.com>
Date: Mon, 19 Mar 2018 16:39:57 -0700
In-Reply-To: <1520853021-5412-1-git-send-email-narmstrong@baylibre.com> (Neil
        Armstrong's message of "Mon, 12 Mar 2018 12:10:21 +0100")
Message-ID: <7hbmfjskhe.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The Mali-450 IP can run up to 744MHz, bump the frequency using
> the GP0 PLL clock.
>
> Cc: Michal Lazo <michal.lazo@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.17/dt64,

Thanks,

Kevin
