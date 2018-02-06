Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752939AbeBFMyS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 07:54:18 -0500
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:51942 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752566AbeBFMyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 07:54:11 -0500
Subject: Re: [PATCH v5 01/16] media: videodev2.h, v4l2-ioctl: add rkisp1 meta
 buffer format
To: Shunqian Zheng <zhengsq@rock-chips.com>,
        linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, tfiga@chromium.org,
        laurent.pinchart@ideasonboard.com, zyc@rock-chips.com,
        eddie.cai.linux@gmail.com, jeffy.chen@rock-chips.com,
        allon.huang@rock-chips.com, devicetree@vger.kernel.org,
        heiko@sntech.de, robh+dt@kernel.org, Joao.Pinto@synopsys.com,
        Luis.Oliveira@synopsys.com, Jose.Abreu@synopsys.com,
        jacob2.chen@rock-chips.com
References: <1514533978-20408-1-git-send-email-zhengsq@rock-chips.com>
 <1514533978-20408-2-git-send-email-zhengsq@rock-chips.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <72af4cf9-64a5-7f3a-2179-23077d3812b3@xs4all.nl>
Date: Tue, 6 Feb 2018 13:54:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1514533978-20408-2-git-send-email-zhengsq@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKVuVfxF201/i7VL/mvbs1TbEPKFSdf118L4eQ29Ekl0QaPQ+raHwbdUE4Da1QgwAbhmsI82pMGBHM5lJfzItTjUlDx2AFYM3OeRk/w0SP1/VUBpLPlN
 uNtAy/t+iuwvMn0fXS3KnLyXJr29jgVzwv0dj1L0kxAxEvbhKiFZveN6umSjERHXfwe52kCqbVlmDO++QqSlys73xhTFfm3rQ5Y52opzA8pLVrvuIyZ7oiL/
 O+t77V/7iuewcpfIPxQsM46tf6srXWLSECiRiLjwRUxUb0XaS1Sn8IfVe5Ov7d4w12JmzntLFTu5+8lxYT0SnHqassSFE1Cxk0DWRoeNgRLYrSsBB9578k1u
 p2f9k5A4iRkAPq0BMOZib0jw1Gdq1P1FsJbCdaisWegdsrWvXzEiPq9kAMs834cT5HWnxl6nSJwIrGug9AVv/cTEoUNShZUrxvihEgkOMg56GFnhHl5zmWkI
 o8VVEZvyR7qS+6EKq/M8MVM032sMpsPzEUMzX5VDabg3mlOrijFwVeYhfSBMFR2LwKWDsBU7ExrFAwXJE1rMVgfeIGKZZeDwqp2pqYDHn9XaBvF67povVA13
 H50HwvwM4tz6AvKaFg13oAb4QyCk0O6WUfq7+cdrb7sV0hH2bZ9rK7Z/4CYYduBT2NA9pPDomHxIf8LppT1c+0+BuiCLnJcRmiaxV17y3kofRHrjo38PD1YK
 /qJMaaNmRc2w8cfTw8XNKNXOO4mz9FRIcGIEAHjDDGLEc2CD69AWnxP4MRlMg7QGj5I9Bs5vvrWsI1qp+2JNafrGGJ1QGvR5CP/wJ5xmJt5obXoWwuhsDRPL
 /0vxs/j6gANLLcrE41HNpqVMrbn7kdHestF56kIX5Q/gKUQMhtaGbcI0qMLzbxdqac23FqOB8oNxOAt9uflw+ATNKRHXjCn7aBhHM80A3SmH5ktK62zsktl/
 glrxVHw6x9OVzTfh5wIra8Pe1cA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/17 08:52, Shunqian Zheng wrote:
> Add the Rockchip ISP1 specific processing parameter format
> V4L2_META_FMT_RK_ISP1_PARAMS and metadata format
> V4L2_META_FMT_RK_ISP1_STAT_3A for 3A.
> 
> Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
> Signed-off-by: Jacob Chen <jacob2.chen@rock-chips.com>

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Thanks!

	Hans

> ---
>  drivers/media/v4l2-core/v4l2-ioctl.c | 2 ++
>  include/uapi/linux/videodev2.h       | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 7961499..035fd22 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1246,6 +1246,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  	case V4L2_TCH_FMT_TU08:		descr = "8-bit unsigned touch data"; break;
>  	case V4L2_META_FMT_VSP1_HGO:	descr = "R-Car VSP1 1-D Histogram"; break;
>  	case V4L2_META_FMT_VSP1_HGT:	descr = "R-Car VSP1 2-D Histogram"; break;
> +	case V4L2_META_FMT_RK_ISP1_PARAMS:	descr = "Rockchip ISP1 3A params"; break;
> +	case V4L2_META_FMT_RK_ISP1_STAT_3A:	descr = "Rockchip ISP1 3A statistics"; break;
>  
>  	default:
>  		/* Compressed formats */
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 1c095b5..c023c3a 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -689,6 +689,10 @@ struct v4l2_pix_format {
>  #define V4L2_META_FMT_VSP1_HGO    v4l2_fourcc('V', 'S', 'P', 'H') /* R-Car VSP1 1-D Histogram */
>  #define V4L2_META_FMT_VSP1_HGT    v4l2_fourcc('V', 'S', 'P', 'T') /* R-Car VSP1 2-D Histogram */
>  
> +/* Vendor specific - used for IPU3 camera sub-system */
> +#define V4L2_META_FMT_RK_ISP1_PARAMS	v4l2_fourcc('R', 'K', '1', 'P') /* Rockchip ISP1 params */
> +#define V4L2_META_FMT_RK_ISP1_STAT_3A	v4l2_fourcc('R', 'K', '1', 'S') /* Rockchip ISP1 3A statistics */
> +
>  /* priv field value to indicates that subsequent fields are valid. */
>  #define V4L2_PIX_FMT_PRIV_MAGIC		0xfeedcafe
>  
> 
