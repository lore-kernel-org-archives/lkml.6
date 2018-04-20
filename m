Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754082AbeDTHtV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:49:21 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:37128 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753982AbeDTHtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:49:18 -0400
X-Google-Smtp-Source: AIpwx4+q43Ui+dDSk4Z1QdEXFxq2vNtOomP5w/UhWDfqeKOAtARCTH6yGo/m5gSUF1o+RgWVPEMSgw==
Date: Fri, 20 Apr 2018 08:49:14 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] regulator: bd9571mwv: Add support for DDR backup
 mode
Message-ID: <20180420074914.vl4rer5zdeldfzb3@dell>
References: <1524057484-25350-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1524057484-25350-1-git-send-email-geert+renesas@glider.be>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018, Geert Uytterhoeven wrote:

> 	Hi all,
> 
> The ROHM BD9571MWV PMIC on the Renesas Salvator-X(S) and ULCB
> development boards supports DDR Backup Power, which means that the DDR
> power rails can be kept powered while the main SoC is powered down.

Should this set be applied together, or can the MFD patches be applied
on their own, without the Regulator patch?

If the former, then we're going to need an Ack from Mark.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
