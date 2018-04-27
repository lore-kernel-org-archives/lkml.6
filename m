Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758929AbeD0TXD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 15:23:03 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44967 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758848AbeD0TW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 15:22:59 -0400
X-Google-Smtp-Source: AB8JxZrTrT0BEnIav7/OgJ1a24cBWcn2BLSEej3qs94NRwpxb7x1s/8lx+0QGE51EuwBc9tDKiQX9Q==
From: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM64: dts: meson: add MMC resets
Organization: BayLibre
References: <20180426104119.13659-1-jbrunet@baylibre.com>
Date: Fri, 27 Apr 2018 12:22:56 -0700
In-Reply-To: <20180426104119.13659-1-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Thu, 26 Apr 2018 12:41:19 +0200")
Message-ID: <7hpo2kzc6n.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Add reset lines to the mmc controllers of the meson gx and axg SoCs
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Applied to v4.18/dt64,

Thanks,

Kevin
