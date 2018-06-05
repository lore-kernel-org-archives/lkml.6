Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751667AbeFEISK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 04:18:10 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35874 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbeFEISI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:18:08 -0400
X-Google-Smtp-Source: ADUXVKJLZJkfd4loDDL3K/Q10JmyYNRrD9+oux64JVQwthDoUwdZ65UkV2dvBds4X9/uHJFif201iQ==
Date: Tue, 5 Jun 2018 09:18:05 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 09/10] mfd: da9063: Handle less LDOs on DA9063L
Message-ID: <20180605081805.GO21163@dell>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180602101155.26375-9-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180602101155.26375-9-marek.vasut+renesas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Jun 2018, Marek Vasut wrote:

> Move the LDOs present only on DA9063 at the end of the list, so that
> the DA9063L can simply indicate less LDOs and still share the list of
> regulators with DA9063.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc@vger.kernel.org
> Acked-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> V2: No change
> V3: No change
> ---
>  drivers/regulator/da9063-regulator.c | 76 +++++++++++++++++++++---------------
>  1 file changed, 45 insertions(+), 31 deletions(-)

Nit: Please change the $SUBJECT line.

s/mfd/regulator/

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
