Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753901AbeC1P37 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:29:59 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44683 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753511AbeC1P36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:29:58 -0400
X-Google-Smtp-Source: AIpwx4+53CJ0X5QI1Qy4GiapQ0zwl6wlESHyf9rFcsYZ6nPVaglUN4/zi0OIESs8wPx3J3PdEnGcfA==
Date: Wed, 28 Mar 2018 16:29:55 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH V1] mfd: da9062: use core helper regmap_reg_range macros
Message-ID: <20180328152955.qrbga5fgo3ls6eje@dell>
References: <20180328110612.1FCAD3FACC@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180328110612.1FCAD3FACC@swsrvapps-01.diasemi.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2018, Steve Twiss wrote:

> From: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> Replace multi-line entries in the regmap_range arrays with single
> line macros: regmap_reg_range(). This will leave the static structure
> array entries for regmap_range unaltered. It will significantly reduce
> the line count in the DA9062/61 core file.
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> ---
> This patch applies against linux-next and v4.16-rc7
> 
> Hi,
> 
> This is a cosmetic tidy up operation. It reduces the line-count in the
> file by over 200.
> 
> It will replace regmap_range[] array entries, such as this: 
> {
>   .range_min = DA9062AA_DEVICE_ID,
>   .range_max = DA9062AA_CONFIG_ID,
> },
> 
> with a single line,
>  regmap_reg_range(DA9062AA_DEVICE_ID, DA9062AA_CONFIG_ID),
> 
> Regards,
> Steve Twiss, Dialog Semiconductor
> 
> 
>  drivers/mfd/da9062-core.c | 462 ++++++++++++----------------------------------
>  1 file changed, 114 insertions(+), 348 deletions(-)

Nice!

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
