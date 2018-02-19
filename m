Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753739AbeBSUTA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:19:00 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34814 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753562AbeBSUS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:18:58 -0500
X-Google-Smtp-Source: AH8x226VtGxF+tUs7yf7YItDGqDgQ5ONBzl40ij773zL2rLJ5/pbpHbQmOE825lDAasJLoX+p5DYNg==
Date: Mon, 19 Feb 2018 14:18:56 -0600
From: Rob Herring <robh@kernel.org>
To: David Daney <david.daney@cavium.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4] rtc: isl12026: Add driver.
Message-ID: <20180219201856.47v33fxvbz6sgxfm@rob-hp-laptop>
References: <20180216194415.6103-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216194415.6103-1-david.daney@cavium.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 11:44:15AM -0800, David Daney wrote:
> The ISL12026 is a combination RTC and EEPROM device with I2C
> interface.  The standard RTC driver interface is provided.  The EEPROM
> is accessed via the NVMEM interface via the "eeprom0" directory in the
> sysfs entry for the device.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
> Changes from v3:
> 
> o Add Reviewed-by
> 
> o s/dev_err/dev_warn/ in one place
> 
> o Remove redundant ','
> 
> Changes from v2:
> 
> o More code cleanups suggested by reviewers.
> 
> Changes from v1:
> 
> o Fixed device tree bindings document example.
> 
> o Use RTC_NVMEM facility for eeprom support.
> 
> o Small code cleanups suggested by reviewers.
> 
>  .../devicetree/bindings/rtc/isil,isl12026.txt      |  28 ++

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/rtc/Kconfig                                |   9 +
>  drivers/rtc/Makefile                               |   1 +
>  drivers/rtc/rtc-isl12026.c                         | 529 +++++++++++++++++++++
>  4 files changed, 567 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl12026.txt
>  create mode 100644 drivers/rtc/rtc-isl12026.c
