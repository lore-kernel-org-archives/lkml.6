Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751762AbeEHEmF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 00:42:05 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34289 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbeEHEmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 00:42:03 -0400
X-Google-Smtp-Source: AB8JxZrBCY9e2GH1dYPglGShIKB3lM8Y5TGgwtFrnrteDA12rxzV/Gnj36GMlj80o4y1YIAQ/SxvJw==
Subject: Re: [PATCH 4/9] hwmon: fschmd: fix typo 'can by' to 'can be'
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, trivial@kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180506112404.24872-1-wsa+renesas@sang-engineering.com>
 <20180506112404.24872-5-wsa+renesas@sang-engineering.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <523422b7-46f5-30ca-3fb7-d30086e5f8fb@roeck-us.net>
Date: Mon, 7 May 2018 21:42:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180506112404.24872-5-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2018 04:23 AM, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>   drivers/hwmon/fschmd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
> index 5e78229ade049f..22d3a84f13ef58 100644
> --- a/drivers/hwmon/fschmd.c
> +++ b/drivers/hwmon/fschmd.c
> @@ -105,7 +105,7 @@ static const u8 FSCHMD_REG_VOLT[7][6] = {
>   static const int FSCHMD_NO_VOLT_SENSORS[7] = { 3, 3, 3, 3, 3, 3, 6 };
>   
>   /*
> - * minimum pwm at which the fan is driven (pwm can by increased depending on
> + * minimum pwm at which the fan is driven (pwm can be increased depending on
>    * the temp. Notice that for the scy some fans share there minimum speed.
>    * Also notice that with the scy the sensor order is different than with the
>    * other chips, this order was in the 2.4 driver and kept for consistency.
> 
