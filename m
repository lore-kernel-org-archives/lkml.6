Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965831AbeEIWRI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 18:17:08 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:39085 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965648AbeEIWRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 18:17:05 -0400
X-Google-Smtp-Source: AB8JxZp575vQ+9F83tPTanTrUygAwbqJ3eYRVseIEim/nqOLC/KkUHLpI26F6Jnw5rNI9g/cDpF8lw==
From: Kevin Hilman <khilman@baylibre.com>
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Carlo Caione <carlo@caione.org>, Jerome Brunet <jbrunet@baylibre.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] ARM64: dts: meson-axg: enable wifi driver
Organization: BayLibre
References: <20180504094533.15588-1-yixun.lan@amlogic.com>
Date: Wed, 09 May 2018 15:17:02 -0700
In-Reply-To: <20180504094533.15588-1-yixun.lan@amlogic.com> (Yixun Lan's
        message of "Fri, 4 May 2018 09:45:31 +0000")
Message-ID: <7hlgcszd7l.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yixun,

Yixun Lan <yixun.lan@amlogic.com> writes:

>  These patches try to enable the WIFI module AP6255 in Meson-AXG S400
> baord. First patch revert an error which was introduced in early commit.
>
> Hi Kevin
>  Please squash patch 1 into the commit[1] of your v4.18/dt64 branch,
> which was the error introduced there.

Thanks for the explanation, I've squashed patch 1, and applied patch 2
to v4.18/dt64.

Thanks,

Kevin
