Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnBAY3IR"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E99DF60767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751987AbeFFLd7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:33:59 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35937 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751536AbeFFLd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:33:56 -0400
X-Google-Smtp-Source: ADUXVKKqOkmB+ook2U/EHHIlFMNN6y9h8nsoSkFNbQn4Z3CKFHFfcLQhvc2rah3LdUBGmUjT7ZEz7uRW8zONx6xmmjU=
MIME-Version: 1.0
In-Reply-To: <20180606100003.17067-3-marek.vasut+renesas@gmail.com>
References: <20180606100003.17067-1-marek.vasut+renesas@gmail.com> <20180606100003.17067-3-marek.vasut+renesas@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 Jun 2018 13:33:54 +0200
X-Google-Sender-Auth: Hf7JD8uV0yUPtdQEDGz3B2BbZMo
Message-ID: <CAMuHMdV4hkAptUjeVr0+dxeysCsCyATH_RzN_YBsBRMmB_hBBA@mail.gmail.com>
Subject: Re: [PATCH v5 03/14] mfd: da9063: Use regmap_reg_range
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-06 11:59 GMT+02:00 Marek Vasut <marek.vasut@gmail.com>:
> Convert the regmap_range tables to use regmap_reg_range() macro.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
