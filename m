Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbeCTKnR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 06:43:17 -0400
Received: from m97138.mail.qiye.163.com ([220.181.97.138]:4903 "EHLO
        m97138.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbeCTKnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 06:43:15 -0400
Subject: Re: [PATCH] rbd: fix spelling mistake: "reregisteration" ->
 "re-registration"
To: Colin King <colin.king@canonical.com>,
        Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>,
        Alex Elder <elder@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        ceph-devel@vger.kernel.org, linux-block@vger.kernel.org
References: <20180319133310.4251-1-colin.king@canonical.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
Message-ID: <5AB0E3D5.6090301@easystack.cn>
Date: Tue, 20 Mar 2018 18:35:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20180319133310.4251-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: u+CowACHQ1rW47Baj2WKAg--.143S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRmFACUUUUU
X-Originating-IP: [103.10.86.235]
X-CM-SenderInfo: 5grqw2pkhqwhp1dqwq5hdv52pwdfyhdfq/1tbiDwgPelnfO+UwfQAAsn
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On 03/19/2018 09:33 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to spelling mistake in rdb_warn message text
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/block/rbd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 1e03b04819c8..7b97240ff15e 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3887,7 +3887,7 @@ static void rbd_reregister_watch(struct work_struct *work)
>   
>   	ret = rbd_dev_refresh(rbd_dev);
>   	if (ret)
> -		rbd_warn(rbd_dev, "reregisteration refresh failed: %d", ret);
> +		rbd_warn(rbd_dev, "re-registration refresh failed: %d", ret);

Hmmm, I am not sure is that a spelling mistake, because the function 
name is rbd_reregister_watch().

Thanx
Yang
>   }
>   
>   /*
