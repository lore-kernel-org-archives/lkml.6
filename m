Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeDPVpA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 17:45:00 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:36201 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751892AbeDPVo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 17:44:58 -0400
X-Google-Smtp-Source: AIpwx4/q/g2ys4hptoffpg8zqA8dWsjmbmeV6sdPhT23rmiRlrjaOX1mJSghQH8SSPxf3MPL1YjTMQ==
Date: Mon, 16 Apr 2018 16:44:56 -0500
From: Rob Herring <robh@kernel.org>
To: Mark Jonas <mark.jonas@de.bosch.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, hs@denx.de,
        Zhu Yi <yi.zhu5@cn.bosch.com>
Subject: Re: [PATCH v2] Input: add bu21029 touch driver
Message-ID: <20180416214456.je4nfuk6riw4xdjd@rob-hp-laptop>
References: <1521651874-15379-1-git-send-email-mark.jonas@de.bosch.com>
 <1523897378-23207-1-git-send-email-mark.jonas@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523897378-23207-1-git-send-email-mark.jonas@de.bosch.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 06:49:38PM +0200, Mark Jonas wrote:
> From: Zhu Yi <yi.zhu5@cn.bosch.com>
> 
> Add Rohm BU21029 resistive touch panel controller support with I2C
> interface.
> 
> Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
> Reviewed-by: Heiko Schocher <hs@denx.de>
> ---
> Changes in v2:
>  - make ABS_PRESSURE proportionally rising with finger pressure
>  - fix race between interrupt and timer during shutdown
>  - use infrastructure from include/linux/input/touchscreen.h
>  - add SPDX tag for the driver
>  - improve binding documentation
>  - fix multi-line comments
> ---
>  .../bindings/input/touchscreen/bu21029.txt         |  34 ++

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/input/touchscreen/Kconfig                  |  12 +
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/bu21029_ts.c             | 485 +++++++++++++++++++++
>  4 files changed, 532 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/bu21029.txt
>  create mode 100644 drivers/input/touchscreen/bu21029_ts.c
