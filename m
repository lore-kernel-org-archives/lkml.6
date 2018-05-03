Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeECQWZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 12:22:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36137 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbeECQWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 12:22:22 -0400
X-Google-Smtp-Source: AB8JxZookTxHVj7ioEW+6lMsDS/JBbVfk84uH5VSGHKMQ5X7g4Uuqs4zPe6B0LlqcyUwSt/v7yEYeg==
Date: Thu, 3 May 2018 18:22:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] ARM: EXYNOS: no need to select ARCH_HAS_BANDGAP any
 longer
Message-ID: <20180503162218.47umsrz3hiphxw4y@kozik-lap>
References: <CGME20180502143026eucas1p144f0f581196615d9c0fba89a562e6e12@eucas1p1.samsung.com>
 <9721484.FBO9LEPOs5@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9721484.FBO9LEPOs5@amdc3058>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 04:30:26PM +0200, Bartlomiej Zolnierkiewicz wrote:
> This is not needed since commit fcbb1e02ee54 ("drivers: thermal:
> Remove ARCH_HAS_BANDGAP dependency for samsung") from 2014.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig |    1 -
>  1 file changed, 1 deletion(-)
> 

Thanks, applied.

Best regards,
Krzysztof
