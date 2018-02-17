Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbeBQQT1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 11:19:27 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33264 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751071AbeBQQTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 11:19:25 -0500
X-Google-Smtp-Source: AH8x224sV/pN62rbkfRXBRk9ACe7mv0eDhLYkc0NhQuWCZajvwCBI1cOE5aKJa65KNvDvPv4t0vIzw==
Date: Sat, 17 Feb 2018 08:19:23 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com
Subject: Re: [v3,05/11] watchdog/hpwdt: Update Module info.
Message-ID: <20180217161923.GA27212@roeck-us.net>
References: <20180215234400.5022-6-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215234400.5022-6-jerry.hoemann@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 04:43:54PM -0700, Jerry Hoemann wrote:
> Update Module Author and description to reflect changes in driver.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>  drivers/watchdog/hpwdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index d5989acf3e37..71e49d0ab789 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -425,8 +425,8 @@ static struct pci_driver hpwdt_driver = {
>  	.remove		= hpwdt_exit,
>  };
>  
> -MODULE_AUTHOR("Tom Mingarelli");
> -MODULE_DESCRIPTION("hp watchdog driver");
> +MODULE_AUTHOR("Jerry Hoemann");
> +MODULE_DESCRIPTION("hpe watchdog driver");

It is quite unusual to replace an author name. The original author is
still the original author and should be retained. Adding another author
is fine, but I disagree with the removal.

Guenter

>  MODULE_LICENSE("GPL");
>  MODULE_VERSION(HPWDT_VERSION);
>  
