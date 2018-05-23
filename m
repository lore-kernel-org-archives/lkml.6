Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933749AbeEWRGF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 13:06:05 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46648 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933495AbeEWRGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 13:06:03 -0400
X-Google-Smtp-Source: AB8JxZouIDyNPshnjmFFbAuov0MqTLuwWqsQa0liG3LuzaCB5coYSxMH2oIN2yb/9/ySKIOxtN+YAg==
From: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] ARM64: dts: meson-axg: i2c updates
Organization: BayLibre
References: <20180517093100.22225-1-jbrunet@baylibre.com>
Date: Wed, 23 May 2018 10:06:00 -0700
In-Reply-To: <20180517093100.22225-1-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Thu, 17 May 2018 11:30:56 +0200")
Message-ID: <7hd0xms3nr.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset fixes a few problems found in the i2c nodes of
> amlogic's meson-axg platform. It also adds the missing pins for
> AO controller so we can use it on the S400
>
> This series has been tested on the S400 board.
>
> Jerome Brunet (4):
>   ARM64: dts: meson-axg: clean-up i2c nodes
>   ARM64: dts: meson-axg: correct i2c AO clock
>   ARM64: dts: meson-axg: add i2c AO pins
>   ARM64: dts: meson-axg: enable i2c AO on the S400 board

Applied to v4.18/dt64,

Kevin
