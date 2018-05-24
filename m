Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935699AbeEXNG1 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 09:06:27 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.129]:16102 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935598AbeEXNGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 09:06:23 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRWlGSWpSXmKPExsUSt3Opse65HWz
  RBucms1pMffiEzWLu7EmMFve/HmW0uLxrDpvF1pfvmCwerpzDYnF0zz1mi75z7g4cHhPP6nrs
  nHWX3WPTqk42jzvX9rB5PFu4nsXj8ya5ALYo1sy8pPyKBNaMn3taGAvec1XcWjOLpYHxAGcXI
  xeHkMAyRolPjYfYuhg5OdgEDCXmvXnPCGKLCKRLvLuwgBGkiFngLJPE5YWbmbsYOTiEBcwk3q
  8Sh6gxl2h/d4QNwjaSmPVjFhOIzSKgKjH77z12kHJegQCJB/PcQcJCAlUSV/7dByvhFHCWWPV
  hOjOIzSggK/GlcTWYzSwgLnHryXywGgkBAYkle84zQ9iiEi8f/2OFsBUk7r/phorbS7y+944F
  ZJWEgL5EX2MxRNhQYtW0AywQtrnEh7PtUON1JBbs/sQGYWtLLFv4GizOKyAocXLmE5YJjOKzk
  FwxC0nLLCQts5C0LGBkWcVokVSUmZ5RkpuYmaNraGCga2hopGsEoo1N9BKrdJP1Ukt1y1OLS3
  QN9RLLi/WKK3OTc1L08lJLNjECo50BCHYw3vuWfIhRkoNJSZTXiZktWogvKT+lMiOxOCO+qDQ
  ntfgQowwHh5IE783tQDnBotT01Iq0zBxg2oFJS3DwKInwNm0DSvMWFyTmFmemQ6ROMSpKifOq
  AJOVkABIIqM0D64NluouMcpKCfMyAh0ixFOQWpSbWYIq/4pRnINRSZj3AMh2nsy8Erjpr4AWM
  wEtvricGWRxSSJCSqqB0UiCb4JqfsXviNJeFecyzbVSCkyrnzO+K97w6HOj5RUNKcbPlk9+l5
  07utTeUlir6NqcnVtcP3ZN5Yiz0r0vtqKGq+xe+KE/2+OF6+b+1ok9zXTi5SrG3e8fGsj+sTu
  QfZj5VNW+HUVapo8y2mtYPn+W7xN+y/pK5L3c1B0WFUYZS9RWHv/aocRSnJFoqMVcVJwIAPbw
  p1hwAwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-21.tower-308.messagelabs.com!1527167181!368695!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Marek Vasut <marek.vasut@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 3/6] mfd: da9063: Add DA9063L type
Thread-Topic: [PATCH 3/6] mfd: da9063: Add DA9063L type
Thread-Index: AQHT8osxq8SHFTDIXUSRpx2SJvB8s6Q+2REA
Date: Thu, 24 May 2018 13:06:19 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB701941A48A3@SW-EX-MBX02.diasemi.com>
References: <20180523114230.10109-1-marek.vasut+renesas@gmail.com>
 <20180523114230.10109-3-marek.vasut+renesas@gmail.com>
In-Reply-To: <20180523114230.10109-3-marek.vasut+renesas@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.35.206]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 24/05/2018 11:32:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 May 2018 12:42 Marek Vasut wrote:
 
> To: linux-kernel@vger.kernel.org
> Cc: Marek Vasut <marek.vasut+renesas@gmail.com>; Geert Uytterhoeven <geert+renesas@glider.be>; Lee Jones <lee.jones@linaro.org>; Mark Brown <broonie@kernel.org>; Steve Twiss <stwiss.opensource@diasemi.com>; Wolfram Sang <wsa+renesas@sang-engineering.com>; linux-renesas-soc@vger.kernel.org
> Subject: [PATCH 3/6] mfd: da9063: Add DA9063L type
>
> Add type for DA9063L, which is a reduced variant of the DA9063 without RTC block and with less regulators.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  include/linux/mfd/da9063/core.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h index eb234582dcb2..c3e917dd1860 100644
> --- a/include/linux/mfd/da9063/core.h
> +++ b/include/linux/mfd/da9063/core.h
> @@ -33,6 +33,7 @@
>  
>  enum da9063_type {
>  	PMIC_TYPE_DA9063 = 0,
> +	PMIC_TYPE_DA9063L,
>  };
>  
>  enum da9063_variant_codes {
> --
> 2.16.2

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve
