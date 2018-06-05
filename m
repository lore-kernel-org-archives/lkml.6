Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbeFEHL0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 03:11:26 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41825 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbeFEHLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:11:24 -0400
X-Google-Smtp-Source: ADUXVKKBirztZSfNIZL809+vbDEISc11HHy12S/a+fn4m5fe7lngFB7BH02gMYDOlU/D+iXauL4XDw==
Date: Tue, 5 Jun 2018 08:11:20 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Fabien Parent <fparent@baylibre.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Guillaume Pain <gpain@baylibre.com>
Subject: Re: [PATCH 1/3] mfd: cros: add charger port count command definition
Message-ID: <20180605071120.GI21163@dell>
References: <20180530031704.18597-1-fparent@baylibre.com>
 <20180530031704.18597-2-fparent@baylibre.com>
 <20180604085900.GN25455@dell>
 <CAOwMV_xyqj027+iRAQtZ5Hv8NDUc6s9OfS0vAkumUyyc4LUjzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOwMV_xyqj027+iRAQtZ5Hv8NDUc6s9OfS0vAkumUyyc4LUjzw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Jun 2018, Fabien Parent wrote:

> On Mon, Jun 4, 2018 at 1:59 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Tue, 29 May 2018, Fabien Parent wrote:
> >
> >> A new more command has been added to the ChromeOS embedded controller
> >> that allows to get the number of charger port count. Unlike
> >> EC_CMD_USB_PD_PORTS, this new command also includes the dedicated
> >> port if present.
> >>
> >> This command will be used to expose the dedicated charger port
> >> in the ChromeOS charger driver.
> >>
> >> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> >> ---
> >>  include/linux/mfd/cros_ec_commands.h | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >
> > Does not want to apply.  I didn't investigate why.
> >
> > Please rebase and resend?
> 
> Sorry, I forgot to add you as "to:" to the patch series.
> This patch applies on top of https://lkml.org/lkml/2018/5/2/590
> ([PATCH v4 1/3] mfd: cros_ec: Add USBPD charger commands and struct
> definitions)

Okay.  Please re-submit after that set has landed then.

Please, also add my Ack to the patch:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
