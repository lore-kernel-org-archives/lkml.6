Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755246AbeCHB1a (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 20:27:30 -0500
Received: from mail-pl0-f49.google.com ([209.85.160.49]:36210 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755223AbeCHB1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 20:27:22 -0500
X-Google-Smtp-Source: AG47ELs6rToVl0ELCPZ1VDfZfVNtGS4zIzVs+pETdeIn0II/lnc/YyQ9JUCzVNlqDQ0+yUBaWTqofw==
From: Kevin Hilman <khilman@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM64: dts: meson-gxbb-wetek: add a wetek specific dtsi to cleanup hub and play2
Organization: BayLibre
References: <1520353173-9157-1-git-send-email-narmstrong@baylibre.com>
Date: Wed, 07 Mar 2018 17:27:20 -0800
In-Reply-To: <1520353173-9157-1-git-send-email-narmstrong@baylibre.com> (Neil
        Armstrong's message of "Tue, 6 Mar 2018 17:19:33 +0100")
Message-ID: <7htvtrfjbb.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This patch adds a specific wetek dtsi to handle the specific Hub and Play2
> boards by no more depending on the p20x dtsi.
> This simplifies the hub and play2 dts and will avoid breaking these
> boards when adding p200 and p201 specific changes.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.17/dt64,

Thanks,

Kevin
