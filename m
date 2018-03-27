Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbeC0MPT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:15:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36357 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752503AbeC0MPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:15:16 -0400
X-Google-Smtp-Source: AG47ELtE7iBa1VMLj8ECr0qJTuEJxIdCdPgssRRxax4Pt11pUAuoIR6ekPkJlNEy4zPDleTeGPYOhg==
Date: Tue, 27 Mar 2018 13:15:12 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: bd9571mwv: Document DDR Backup
 Mode properties
Message-ID: <20180327121512.ygwcrwexx2fmbwyz@dell>
References: <1521025722-24205-1-git-send-email-geert+renesas@glider.be>
 <1521025722-24205-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1521025722-24205-2-git-send-email-geert+renesas@glider.be>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2018, Geert Uytterhoeven wrote:

> Document the new optional properties related to DDR Backup Mode and
> toggle/momentary power switches.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Improve property description,
>   - Add properties for power switch type.
> ---
>  Documentation/devicetree/bindings/mfd/bd9571mwv.txt | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Once Rob's comment has been handled:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
