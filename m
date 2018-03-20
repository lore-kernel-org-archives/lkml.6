Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966225AbeCTAxr convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 20:53:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933455AbeCTAxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 20:53:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F0821737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: David Lechner <david@lechnology.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1521168778-27236-1-git-send-email-david@lechnology.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org,
        David Lechner <david@lechnology.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
Message-ID: <152150722338.254778.4743967512266809482@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: =?utf-8?q?Re=3A_=5BPATCH_v8_00/42=5D_ARM=3A_davinci=3A_convert_to_common_?=
 =?utf-8?q?clock_framework=E2=80=8B?=
Date: Mon, 19 Mar 2018 17:53:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Lechner (2018-03-15 19:52:16)
> This series converts mach-davinci to use the common clock framework.
> 
> The series works like this, the first 19 patches create new clock drivers
> using the common clock framework. There are basically 3 groups of clocks -
> PLL, PSC and CFGCHIP (syscon). There are six different SoCs that each have
> unique init data, which is the reason for so many patches.

Should I apply the first 19 patches to clk tree? Looking over them
nothing stands out except for your self comment about the bad
reviewed-by tag which I can remove.
