Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755067AbeE2HkE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:40:04 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44833 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754902AbeE2HkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:40:01 -0400
X-Google-Smtp-Source: AB8JxZq/qNUSr9fRaeyMgBFNGVSK6c/iV2LQVu7jPRMSjYgdMqyPOJr/08I4FL8QfAHh3UBG25X2vQ==
Date: Tue, 29 May 2018 08:39:58 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        mazziesaccount@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v2 0/6] mfd/regulator/clk: bd71837: ROHM BD71837 PMIC
 driver
Message-ID: <20180529073958.GB4790@dell>
References: <20180528090003.GA8778@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180528090003.GA8778@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 May 2018, Matti Vaittinen wrote:

> Patch series adding support for ROHM BD71837 PMIC.
> 
> BD71837 is a programmable Power Management IC for powering single-core,
> dual-core, and quad-core SoC’s such as NXP-i.MX 8M. It is optimized for
> low BOM cost and compact solution footprint. It integrates 8 buck
> regulators and 7 LDO’s to provide all the power rails required by the
> SoC and the commonly used peripherals.
> 
> The driver aims to not limit the usage of PMIC. Thus the buck and LDO
> naming is generic and not tied to any specific purposes. However there
> is following limitations which make it mostly suitable for use cases
> where the processor where PMIC driver is running is powered by the PMIC:
> 
> - The PMIC is not re-initialized if it resets. PMIC may reset as a
>   result of voltage monitoring (over/under voltage) or due to reset
>   request. Driver is only initializing PMIC at probe. This is not
>   problem as long as processor controlling PMIC is powered by PMIC.
> 
> - The PMIC internal state machine is ignored by driver. Driver assumes
>   the PMIC is wired so that it is always in "run" state when controlled
>   by the driver.

FYI, this patch-set is going to be difficult to manage since it was
not sent 'threaded'.  As people start replying to different patches,
they are going to scatter-bomb throughout all of the recipient's
inboxes.

If/when you send a subsequent version, could you please ensure you
send the set threaded so the patches keep in relation to one another
as they are reviewed?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
