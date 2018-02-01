Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbeBAMYJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 07:24:09 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:24292 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbeBAMYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 07:24:07 -0500
Subject: Re: [PATCH v6 02/41] clk: davinci: New driver for davinci PLL clocks
From: Sekhar Nori <nsekhar@ti.com>
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-3-git-send-email-david@lechnology.com>
 <ff3a0549-2f76-9a8d-21bc-164649e8a6be@ti.com>
Message-ID: <2a833d5c-4cd7-5c55-4b4a-a02bd7fde6d9@ti.com>
Date: Thu, 1 Feb 2018 17:52:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <ff3a0549-2f76-9a8d-21bc-164649e8a6be@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 February 2018 01:31 PM, Sekhar Nori wrote:
> One thing missing is DIV4.5 clock. It will be nice to add that too,
> mostly just because it will make the binding complete.

Ah, ignore this comment please. I noticed that its part of cfgchip
clocks (which makes sense).

Thanks,
Sekhar
