Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFpH1tAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 702D06037B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932196AbeFFGZf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 02:25:35 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36559 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932097AbeFFGZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 02:25:34 -0400
X-Google-Smtp-Source: ADUXVKLFXlRNvfHvoktIAs8Keq9/2S+v2Ahy/szSj31Nav8XBSGsW6B3lYq8b1zsYdpvczMsV98Rzl1me1kaPnvRSQQ=
MIME-Version: 1.0
In-Reply-To: <20180605231013.1803-3-marek.vasut+renesas@gmail.com>
References: <20180605231013.1803-1-marek.vasut+renesas@gmail.com> <20180605231013.1803-3-marek.vasut+renesas@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 Jun 2018 08:25:32 +0200
X-Google-Sender-Auth: aCHSyrPBFz8Wets8hcPdY1IJhTU
Message-ID: <CAMuHMdUeqEuMrxVH6KkVRY=4u3Y-q1kvsNBnMQvSyBP2qj1pnA@mail.gmail.com>
Subject: Re: [PATCH v4 03/12] mfd: da9063: Use PLATFORM_DEVID_NONE
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

On Wed, Jun 6, 2018 at 1:10 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Use PLATFORM_DEVID_NONE instead of -1 in mfd_add_devices.
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
