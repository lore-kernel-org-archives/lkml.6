Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbeFETup convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:50:45 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.66]:23116 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751849AbeFETun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:50:43 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRWlGSWpSXmKPExsUSt3Opse7El2L
  RBk2/NCymPnzCZjF39iRGi/tfjzJaXN41h81i68t3TBYPV85hsTi65x6zRd85dwcOj4lndT12
  zrrL7rFpVSebx51re9g8ni1cz+LxeZNcAFsUa2ZeUn5FAmvG4XML2QqaOCtO3HvE3sD4kL2Lk
  YtDSGApo0RP40qmLkZODjYBQ4l5b94zgtgiAukS7y4sYAQpYha4zCSxbXMnK0hCWMBaom3Ben
  aIIhuJ3xt2M0HYRhIzDxwBs1kEVCR2H+wCq+EVCJCY+msVG4gtJFAlMePNE7AaTgFniTn998F
  mMgrISnxpXM0MYjMLiEvcejIfrEZCQEBiyZ7zzBC2qMTLx/9YIWwFiX2/VrJB2PYSr++9Y+li
  5ACy9SX6GoshwoYSq6YdYIGwzSWm9jxkhBivI7Fg9yc2CFtbYtnC18wQZwpKnJz5hGUCo/gsJ
  FfMQtIyC0nLLCQtCxhZVjFaJBVlpmeU5CZm5ugaGhjoGhoa6RpamusaWhjpJVbpJumlluqWpx
  aX6BrqJZYX6xVX5ibnpOjlpZZsYgRGPAMQ7GBceiH5EKMkB5OSKK/OIrFoIb6k/JTKjMTijPi
  i0pzU4kOMMhwcShK8fi+AcoJFqempFWmZOcDUA5OW4OBREuHdC5LmLS5IzC3OTIdInWJUlBLn
  DQVJCIAkMkrz4Npg6e4So6yUMC8j0CFCPAWpRbmZJajyrxjFORiVhHllQabwZOaVwE1/BbSYC
  WjxswphkMUliQgpqQbGLdWPGENq156PLXs0QaW5V/bKJU1ZxtTJ8zy2Nc70Kf1h97eh/Ptkq4
  jT64Qniay/m6Vo6dSpfnHt5ismuxryIl9IfZrB0tZeGpu5Sbv4zqq7b/5McWs5ZHdG5L37kic
  3haS+fHhjE5rDbrCv0qHbZ8Pvy9OlzsoJzz4is+Tsf/HvcQ9/nzz5SYmlOCPRUIu5qDgRAGZh
  /rFyAwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-2.tower-288.messagelabs.com!1528228241!1694682!1
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
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v3 05/10] mfd: da9063: Add DA9063L type
Thread-Topic: [PATCH v3 05/10] mfd: da9063: Add DA9063L type
Thread-Index: AQHT+loymMnBuw7neUi5Vw/AJsI0QaRR9lNg
Date: Tue, 5 Jun 2018 19:50:40 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB701941AD6DD@SW-EX-MBX02.diasemi.com>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180602101155.26375-5-marek.vasut+renesas@gmail.com>
In-Reply-To: <20180602101155.26375-5-marek.vasut+renesas@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.27.121]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 05/06/2018 15:14:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 June 2018 11:12, Marek Vasut wrote,

> Subject: [PATCH v3 05/10] mfd: da9063: Add DA9063L type
> 
> Add type for DA9063L, which is a reduced variant of the DA9063
> without RTC block and with less regulators.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc@vger.kernel.org
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> V2: No change
> V3: No change
> ---
>  include/linux/mfd/da9063/core.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
> index eb234582dcb2..c3e917dd1860 100644
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
