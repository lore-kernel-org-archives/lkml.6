Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbeEDXZD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 19:25:03 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43581 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751733AbeEDXZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 19:25:01 -0400
X-Google-Smtp-Source: AB8JxZr4FzqU2EAVH0dODoTCyBJ/BF75cdFrnN21vbl2HJpIDsTVRpxqZ0j8YyAs/YpbDQg9N8uy7A==
Date: Fri, 4 May 2018 16:24:58 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Niklas Cassel <niklas.cassel@linaro.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update pattern for qcom_scm
Message-ID: <20180504232458.GU18510@minitux>
References: <20180427135541.11961-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427135541.11961-1-niklas.cassel@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 27 Apr 06:55 PDT 2018, Niklas Cassel wrote:

> Update pattern for qcom_scm, so that get_maintainer.pl will show the
> correct maintainers + lists, not only for qcom_scm.c, but also for
> the files: qcom_scm-32.c, qcom_scm-64.c, qcom_scm.h.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 834cd3b1d79d..da60870527e9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1817,7 +1817,7 @@ F:	drivers/spi/spi-qup.c
>  F:	drivers/tty/serial/msm_serial.c
>  F:	drivers/*/pm8???-*
>  F:	drivers/mfd/ssbi.c
> -F:	drivers/firmware/qcom_scm.c
> +F:	drivers/firmware/qcom_scm*
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git
>  
>  ARM/RADISYS ENP2611 MACHINE SUPPORT
> -- 
> 2.14.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
