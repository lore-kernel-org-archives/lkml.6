Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934934AbeCSXo5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 19:44:57 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33783 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934466AbeCSXox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 19:44:53 -0400
X-Google-Smtp-Source: AG47ELtlQaLMqh6QQY+lbUeDFapGadxqBC+ULsVgyqFZpmV/TsKYsrYv1C0AjqJHhcAiNFWttMvdqw==
From: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM64: dts: meson-gx: make efuse read-only
Organization: BayLibre
References: <20180316145021.8517-1-jbrunet@baylibre.com>
Date: Mon, 19 Mar 2018 16:44:50 -0700
In-Reply-To: <20180316145021.8517-1-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Fri, 16 Mar 2018 15:50:21 +0100")
Message-ID: <7h370vsk99.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> efuse is one time programmable, so it is safer to deny write request
> to this memory, unless the user is savvy enough to remove the read-only
> flag from DTB
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Applied to v4.17/dt64,

Thanks,

Kevin
