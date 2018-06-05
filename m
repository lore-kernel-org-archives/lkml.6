Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753054AbeFERQ0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:16:26 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.67]:27742 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751921AbeFERQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:16:23 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRWlGSWpSXmKPExsUSt3OpsW7qUbF
  og/u/uS2mPnzCZjF39iRGi/tfjzJaXN41h81i68t3TBYPV85hsTi65x6zRd85dwcOj4lndT12
  zrrL7rFpVSebx51re9g8ni1cz+LxeZNcAFsUa2ZeUn5FAmvGlAVHGQsuCVa0P1jH2sC4RbCLk
  YtDSGApo8TDk3uZuhg5OdgEDCXmvXnPCGKLCKhLzJq6hA2kiFlgMrPElB27wRLCAqESG5+sZY
  coCpO403oPqJkDyHaSeDlZGSTMIqAicWXzQbASXoEAiSkPfzJDLDvNKDFz5gNWkASngK3Ek+M
  LwBYzCshKfGlczQxiMwuIS9x6Mh8sLiEgILFkz3lmCFtU4uXjf6wQtoLEvl8r2SBse4nX996x
  QNj6Eo8eP2KEsA0lVk07ABU3l5ja85AR5E5mAU2J9bv0IVYpSkzpfgh1p6DEyZlPWCYwis9Cc
  sUshI5ZSDpmIelYwMiyitEiqSgzPaMkNzEzR9fQwEDX0NBI19DSUtfQ3FAvsUo3SS+1VLc8tb
  hEF8gtL9YrrsxNzknRy0st2cQIjHcGINjBeOJb8iFGSQ4mJVFenUVi0UJ8SfkplRmJxRnxRaU
  5qcWHGGU4OJQkeKOOAOUEi1LTUyvSMnOAiQcmLcHBoyTC++QwUJq3uCAxtzgzHSJ1ilGX48nl
  aT3MQix5+XmpUuK84SAzBECKMkrz4EbAkuAlRlkpYV5GoKOEeApSi3IzS1DlXzGKczAqCfMmg
  0zhycwrgdv0CugIJqAjnlUIgxxRkoiQkmpgNFr+TLXjxLW10ReU57/wfhzKM29N8uV/Kub5oh
  ffrg67csjd1Ggb783jxwVzT1ib9v8Ts1jwgOdAj+ZiFcUTM2bYtD8KuabMck32mYnnB8cT63h
  1JOtjfj8I+5O5cMNy76RXEttuPLm1L/bz+3s53OGhe2qLVFJ3CieGOTzJj2Br6D3xatGcSUos
  xRmJhlrMRcWJAPJWBeh9AwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-14.tower-288.messagelabs.com!1528218980!1689005!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Marek Vasut <marek.vasut@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v3 03/10] mfd: da9063: Rename PMIC_DA9063 to
 PMIC_CHIP_ID_DA9063
Thread-Topic: [PATCH v3 03/10] mfd: da9063: Rename PMIC_DA9063 to
 PMIC_CHIP_ID_DA9063
Thread-Index: AQHT+lowTneLOxdXIUmgCqzSDozouKRP+TEAgABl9ACAAY1hcA==
Date: Tue, 5 Jun 2018 17:16:19 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB701941AD654@SW-EX-MBX02.diasemi.com>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180602101155.26375-3-marek.vasut+renesas@gmail.com>
 <20180604122658.GC21163@dell>
 <3853ee6e-86a7-793e-c633-fc9c2910976f@gmail.com>
In-Reply-To: <3853ee6e-86a7-793e-c633-fc9c2910976f@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.27.121]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub02.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 05/06/2018 15:14:00
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w55HGU6m028698



On 04 June 2018 19:32, Marek Vasut wrote,

> Subject: Re: [PATCH v3 03/10] mfd: da9063: Rename PMIC_DA9063 to
> PMIC_CHIP_ID_DA9063
> 
> On 06/04/2018 02:26 PM, Lee Jones wrote:
> > On Sat, 02 Jun 2018, Marek Vasut wrote:
> >
> >> The PMIC_DA9063 is a complete misnomer, it denotes the value of the
> >> DA9063 chip ID register, so rename it as such. It is also the value
> >> of chip ID register of DA9063L though, so drop the enum as all the
> >> DA9063 "models" share the same chip ID and thus the distinction will
> >> have to be made using DT or otherwise.
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> >> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Cc: Lee Jones <lee.jones@linaro.org>
> >> Cc: Mark Brown <broonie@kernel.org>
> >> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
> >> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >> Cc: linux-renesas-soc@vger.kernel.org
> >> Acked-by: Mark Brown <broonie@kernel.org>
> >> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> ---
> >> V2: No change
> >> V3: No change
> >> ---
> >>  drivers/mfd/da9063-core.c            | 2 +-
> >>  drivers/mfd/da9063-i2c.c             | 2 +-
> >>  drivers/regulator/da9063-regulator.c | 2 +-
> >>  include/linux/mfd/da9063/core.h      | 4 +---
> >>  4 files changed, 4 insertions(+), 6 deletions(-)
> >
> > For my own reference:
> >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> Thanks.
> 
> Any other comments before I submit the next round in a few days?
> 

Hi Marek,

Thanks.
I'm reviewing it now.
Could you hold off until tomorrow please?

Regards,
Steve
