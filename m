Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeBHJvt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 04:51:49 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64116 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbeBHJvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 04:51:48 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] ACPI / video: Use true for boolean value
Date: Thu, 08 Feb 2018 10:50:04 +0100
Message-ID: <2060184.3QT14Lsmnf@aspire.rjw.lan>
In-Reply-To: <20180123155920.GA23399@embeddedgus>
References: <20180123155920.GA23399@embeddedgus>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 23, 2018 4:59:20 PM CET Gustavo A. R. Silva wrote:
> Assign true or false to boolean variables instead of an integer value.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/acpi/acpi_video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index f53ccc6..76fb969 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -53,7 +53,7 @@ MODULE_AUTHOR("Bruno Ducrot");
>  MODULE_DESCRIPTION("ACPI Video Driver");
>  MODULE_LICENSE("GPL");
>  
> -static bool brightness_switch_enabled = 1;
> +static bool brightness_switch_enabled = true;
>  module_param(brightness_switch_enabled, bool, 0644);
>  
>  /*
> 

Applied, thanks!
