Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932081AbeAaAcn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 19:32:43 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36800 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752741AbeAaAcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 19:32:41 -0500
X-Google-Smtp-Source: AH8x227WfkPFXC+Fe5rFArnuyVU0haGkYvQ6a68+71izJfgziArTicFLF14wDT3BG44voVugj/neVQ==
From: Kevin Hilman <khilman@baylibre.com>
To: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
Cc: carlo@caione.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM64: dts: meson s905x: accept MAC addr from u-boot  environment
Organization: BayLibre
References: <1516186543-22056-1-git-send-email-jramirez@baylibre.com>
Date: Tue, 30 Jan 2018 16:32:37 -0800
In-Reply-To: <1516186543-22056-1-git-send-email-jramirez@baylibre.com> (Jorge
        Ramirez-Ortiz's message of "Wed, 17 Jan 2018 11:55:43 +0100")
Message-ID: <7hinbic1ga.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jorge Ramirez-Ortiz <jramirez@baylibre.com> writes:

> With the adequate configuration settings, u-boot will loop through the
> list of aliases looking for "ethernetX".
>
> By adding an ethernet alias, u-boot can fixup the local-mac-address
> property in the kernel's device tree using a value held in its
> environment variable ethaddr.
>
> Tested-by: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
> Signed-off-by: Jorge Ramirez-Ortiz <jramirez@baylibre.com>

Applied to v4.17/dt64,

Kevin
