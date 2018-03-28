Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeC1LEb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 07:04:31 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:52609 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751903AbeC1LEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 07:04:30 -0400
X-Google-Smtp-Source: AIpwx4+bOTp8Wdjsmf8jl9elocmP098lNmG2W2FvOZfVcv7mt35owyUggelvGc0+bjgDfvueW6GeLQ==
Date: Wed, 28 Mar 2018 12:04:27 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] mfd: sprd: Add one syscon cell to access PMIC
 global registers
Message-ID: <20180328110427.dvk3suk66ahtcf6v@dell>
References: <0793c674fed009b9616fbc01a0212d78fb01234e.1521696653.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0793c674fed009b9616fbc01a0212d78fb01234e.1521696653.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2018, Baolin Wang wrote:

> There are some global registers in Spreadtrum sc27xx PMICs, which will
> be accessed by other drivers. So this patch adds one syscon cell to
> help to access the PMIC's global registers.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/mfd/sprd-sc27xx-spi.c |    3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
