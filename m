Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D98x74or"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36AAF60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932724AbeFFQOc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 12:14:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51963 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753186AbeFFQO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:14:29 -0400
X-Google-Smtp-Source: ADUXVKLhuNvC513uwYjcc67rmf8dAUfdVndUi1psHLb6baljeZ4rzrTYQLxE47lW76ERyL98MDLMRA==
Subject: Re: [PATCH v5 04/14] mfd: da9063: Use REGMAP_IRQ_REG
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
 <20180606100003.17067-4-marek.vasut+renesas@gmail.com>
 <CAMuHMdXdoAaBbx+_G3+n=e+zki3z20t7ATXttDUnmYRu95HMVA@mail.gmail.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <3317638e-8688-35ef-ab61-7281312f2c3f@gmail.com>
Date: Wed, 6 Jun 2018 18:06:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXdoAaBbx+_G3+n=e+zki3z20t7ATXttDUnmYRu95HMVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2018 01:31 PM, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Wed, Jun 6, 2018 at 11:59 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> Convert the regmap_irq table to use REGMAP_IRQ_REG().
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Again:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Added.

And the obvious question is, what do you all use to collect these tags?
Doing it manually sucks.

-- 
Best regards,
Marek Vasut
