Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752363AbeBBPEu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:04:50 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:20615 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbeBBPEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:04:42 -0500
Subject: Re: [PATCH v6 28/41] ARM: davinci: remove CONFIG_DAVINCI_RESET_CLOCKS
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-29-git-send-email-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <a2ae4132-7098-b4f1-5d27-c3eed92ffc3f@ti.com>
Date: Fri, 2 Feb 2018 20:33:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1516468460-4908-29-git-send-email-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 January 2018 10:44 PM, David Lechner wrote:
> The common clock framework will take care of disabling unused clocks when
> we switch from the legacy davinci clocks and having this enabled will
> cause compile errors after we switch, so remove it now.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
