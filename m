Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932509AbeDBUm0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 16:42:26 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.61]:14035 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756760AbeDBUmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 16:42:25 -0400
Subject: Re: [PATCH 3/3] media: i2c: tvp5150: Use parentheses for sizeof
To: Nasser Afshin <afshin.nasser@gmail.com>, mchehab@kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180402195907.14368-1-Afshin.Nasser@gmail.com>
 <20180402195907.14368-4-Afshin.Nasser@gmail.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <d5e8dbe4-b68b-ac4e-0076-a3ee995f8327@embeddedor.com>
Date: Mon, 2 Apr 2018 15:17:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180402195907.14368-4-Afshin.Nasser@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1f35ta-002rRS-W7
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.71]) [189.145.54.187]:33462
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/02/2018 02:59 PM, Nasser Afshin wrote:
> This patch resolves a checkpatch.pl warning

It would be nice if you explicitly mention the warning.

Thanks.
--
Gustavo

> Signed-off-by: Nasser Afshin <Afshin.Nasser@gmail.com>
> ---
>   drivers/media/i2c/tvp5150.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/i2c/tvp5150.c b/drivers/media/i2c/tvp5150.c
> index d561d87d219a..d528fddbea16 100644
> --- a/drivers/media/i2c/tvp5150.c
> +++ b/drivers/media/i2c/tvp5150.c
> @@ -625,7 +625,7 @@ static int tvp5150_g_sliced_vbi_cap(struct v4l2_subdev *sd,
>   	int line, i;
>   
>   	dev_dbg_lvl(sd->dev, 1, debug, "g_sliced_vbi_cap\n");
> -	memset(cap, 0, sizeof *cap);
> +	memset(cap, 0, sizeof(*cap));
>   
>   	for (i = 0; i < ARRAY_SIZE(vbi_ram_default); i++) {
>   		const struct i2c_vbi_ram_value *regs = &vbi_ram_default[i];
