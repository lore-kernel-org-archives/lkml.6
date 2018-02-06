Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753011AbeBFM4J (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 07:56:09 -0500
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:34085 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752566AbeBFM4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 07:56:01 -0500
Subject: Re: [PATCH v5 02/16] media: doc: add document for rkisp1 meta buffer
 format
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
        jacob2.chen@rock-chips.com, Jacob Chen <jacob-chen@rock-chips.com>
References: <1514533978-20408-1-git-send-email-zhengsq@rock-chips.com>
 <1514533978-20408-3-git-send-email-zhengsq@rock-chips.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <5286472f-81c9-0093-ded1-0031c5ce8e43@xs4all.nl>
Date: Tue, 6 Feb 2018 13:55:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1514533978-20408-3-git-send-email-zhengsq@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBLgcGDVfoQjBC+uEeuncsT8ADB/gB/UvxH1+8OU+/cB6ykjUvp8ZobHDzU+koqo3QmVvruLpHtx9aiIozc9d/KZh3i+mQLXXHRldPOIwJaM/tZqt9gh
 RhcEm+zTiz4YnYu3i4TTg9lYFf2AQZ1V3WLeNgo+cS9hiJNoqrxNVazS/zIjkhv3qW9IXN4flk5ln4DejVRFddpVinvWavalXojkafmEvlDjZ1hnuyAzOSFz
 4oxWweEA3gAAABEYwAoZGjjXN6A5OZxPDNlO3Tkwx3RXq4AFn7bScqdfumRBhutUULiVRmbLgfD7vqYSOFXYjORDa6Khm/VBYjcQ4H+ndr90EbiH0RTU3RqL
 2mau9sTe4nYfyOEtJY/QGUjl3OtrcGC38zgH6HC9BV7l6cWDZk1xSOMz+rLI7KEeRX90KnPeyR0+cunjZicNOdVjS1RcdM2pqx9kl28OPs0JkHPaZoO6Qi7z
 8eqiIfDwiN1h02NKhi1P560GQFt7sgYmxaDWO1IcshGsK1ClQaLK4lhz5ymQ12m/2Sj6Q71J7fcj9mWImZAZsGkowTcsrNUDtWIkELBY9tHtytn1RiIaEAi0
 xc8QQqwyR47i1TitSM8Tutxc3K8PIGi6exEAK3K/MK3foP7AqBkDa6Rh/4HYnM2X7ZR+IwXdV4ZuXALgQ7eUigXzBCrXntk30op4IKT62XOJOil9gn9ZJwtZ
 K+jKONYhgx3iHCCCgFpTcxnPO194STvs4b/fuHnkG/zNf+HEsSZjRyN6WO/HrI85qi684mZE9XZIYn4VulBqXTmpIP3Hynj+8m5y11f91L0c6g9hgPLMqFPR
 OSJSkQ0/Ogo0uYGovEk0M/XKistqIe9j7n+dOE6+6O3ve2OC+j42Y6nTWBcMpFwVR3mxystZhUFl2OFptQecE652Oflxk34aEoHVL21T6I0XhMHEnFES15nX
 XlYQ03cIcdIB68Sum8vTeuwEgX2h+0zDke3nF8jSCOiV3oee29XWd8X3Hm70McUR9SJWxA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/17 08:52, Shunqian Zheng wrote:
> From: Jacob Chen <jacob2.chen@rock-chips.com>
> 
> This commit add docuemnt for rkisp1 meta buffer format
> 
> Signed-off-by: Jacob Chen <jacob-chen@rock-chips.com>
> ---
>  Documentation/media/uapi/v4l/meta-formats.rst          |  2 ++
>  .../media/uapi/v4l/pixfmt-meta-rkisp1-params.rst       | 17 +++++++++++++++++
>  .../media/uapi/v4l/pixfmt-meta-rkisp1-stat.rst         | 18 ++++++++++++++++++
>  3 files changed, 37 insertions(+)
>  create mode 100644 Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-params.rst
>  create mode 100644 Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-stat.rst
> 
> diff --git a/Documentation/media/uapi/v4l/meta-formats.rst b/Documentation/media/uapi/v4l/meta-formats.rst
> index 01e24e3..1b82814 100644
> --- a/Documentation/media/uapi/v4l/meta-formats.rst
> +++ b/Documentation/media/uapi/v4l/meta-formats.rst
> @@ -14,3 +14,5 @@ These formats are used for the :ref:`metadata` interface only.
>  
>      pixfmt-meta-vsp1-hgo
>      pixfmt-meta-vsp1-hgt
> +    pixfmt-meta-rkisp1-params
> +    pixfmt-meta-rkisp1-stat
> diff --git a/Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-params.rst b/Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-params.rst
> new file mode 100644
> index 0000000..ed344d4
> --- /dev/null
> +++ b/Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-params.rst
> @@ -0,0 +1,17 @@
> +.. -*- coding: utf-8; mode: rst -*-
> +
> +.. _v4l2-meta-fmt-rkisp1-params:
> +
> +*******************************
> +V4L2_META_FMT_RK_ISP1_PARAMS
> +*******************************
> +
> +Rockchip ISP1 Parameters Data
> +
> +Description
> +===========
> +
> +This format describes input parameters for the Rockchip ISP1.
> +
> +The data use c-struct :c:type:`rkisp1_isp_params_cfg`, which is defined in

The data use -> It uses

> +the ``linux/rkisp1-config.h`` header file, See it for details.

See -> see

> diff --git a/Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-stat.rst b/Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-stat.rst
> new file mode 100644
> index 0000000..5ecc403
> --- /dev/null
> +++ b/Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-stat.rst
> @@ -0,0 +1,18 @@
> +.. -*- coding: utf-8; mode: rst -*-
> +
> +.. _v4l2-meta-fmt-rkisp1-stat:
> +
> +*******************************
> +V4L2_META_FMT_RK_ISP1_STAT_3A
> +*******************************
> +
> +Rockchip ISP1 Statistics Data
> +
> +Description
> +===========
> +
> +This format describes image color statistics information generated by the Rockchip
> +ISP1.
> +
> +The data use c-struct :c:type:`rkisp1_stat_buffer`, which is defined in

The data use -> It uses

> +the ``linux/cifisp_stat.h`` header file, See it for details.
> 

See -> see

After those trivial changes you can add my:

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Thanks!

	Hans
