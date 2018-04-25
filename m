Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753505AbeDYLhg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:37:36 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33629 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752589AbeDYLh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:37:29 -0400
X-Google-Smtp-Source: AIpwx4/FSNTMfsITij8iTT3bDcKlqBNjBXPRH7cFwDI5nLZcl5QN04pFvVVy+RFa+mlKywDM9wolUA==
Message-ID: <1524656245.4026.61.camel@baylibre.com>
Subject: Re: [PATCH v2 1/2] clk: meson: gxbb: expose VDEC_1 and VDEC_HEVC
 clocks
From: Jerome Brunet <jbrunet@baylibre.com>
To: Maxime Jourdan <maxi.jourdan@wanadoo.fr>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Mike Turquette <mturquette@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Wed, 25 Apr 2018 13:37:25 +0200
In-Reply-To: <20180424184838.3406-2-maxi.jourdan@wanadoo.fr>
References: <20180424184838.3406-1-maxi.jourdan@wanadoo.fr>
         <20180424184838.3406-2-maxi.jourdan@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-24 at 20:48 +0200, Maxime Jourdan wrote:
> Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>

Even if the change is trivial, please add commit description.
I'll do it for you this time.

Applied to next/headers
Thx

> ---
>  include/dt-bindings/clock/gxbb-clkc.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
> index 8ba99a5e3fd3..7a892be90549 100644
> --- a/include/dt-bindings/clock/gxbb-clkc.h
> +++ b/include/dt-bindings/clock/gxbb-clkc.h
> @@ -125,5 +125,7 @@
>  #define CLKID_VAPB_1		138
>  #define CLKID_VAPB_SEL		139
>  #define CLKID_VAPB		140
> +#define CLKID_VDEC_1		153
> +#define CLKID_VDEC_HEVC		156
>  
>  #endif /* __GXBB_CLKC_H */
