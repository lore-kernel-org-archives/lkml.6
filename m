Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbeBFO2O (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:28:14 -0500
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:52142 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752370AbeBFO1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:27:16 -0500
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
Message-ID: <917c22c0-773e-5fe5-5625-86678f7c8521@xs4all.nl>
Date: Tue, 6 Feb 2018 15:27:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1514533978-20408-3-git-send-email-zhengsq@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfELbpHiv4P6JQfZ+JTprt7PbcB4YV6N5nsWvCL9Vk7yyX8aMGQtl1W134oOzlzvNxjEo0CkalpcYAgtbKvx95r3+1oqtSTcVO3mtcc4G582RLFZqaVgc
 FRCZoOGzIvbqniMK7dPMskg7YXxE4kSPgZPTUTnLFc1bNjhuWZgBVGw5hZWUNBnbX0kIk/o0PhXKAb+EyUmb1nsP7mlUrjbwEOiY4DywItkAj6Eyy3RjeOT0
 2QqzqACMk6D25zVexya9z/eXuK6BulEebWnsXNGpiXQc9zf7LFEap+YdqBp/jS6ka5n+si99sXOj4xx9BNbbgnbBoutzNM87hcQvSZu1KzO+MGhcCsD345lO
 31S2BboNXMioQqyDtwAWi2MtS1eQBE653tKYizp5ATFfr9XFqGcpXaIaRI584ekZzxrl6HBxU1ruWM5zW/9qPvsaEGJLstm8cdLh0RTCWmimiDJW48KPRyiA
 ECY/TTnqeXfEzV0cnkoMhFd9OzIAfgA64nOjiT6LmlDuCRruhfcbZfZFg5hxmdbLHcp4/KdoEGvymBt2aPlPeDxT+xpV+auKmLGcA5FyuaXGqz4f87xuMGHA
 3cznaHqSlGhBM/zuL0T/1bkJjKrgI/LtADrtBHKwjtfUIQK27QiM9gsp+XFfLfsYCOh8UImI6MQa4rJLtF827yfwSd6NgQGhw1xM2oPDANk3WLD+7toCvotj
 xW+5i+8waYhF00ZghWJ0qMQBKEEVeweDz6SbXEjvku1kB1LrVjV6/c/DLJ8a/c0VEL2e3TXQkelpMH+nVxUfoJa7bbmxhSHPE11BSULpPoH5pKjdFU6NSus4
 WEj+qrjvab0/G/ZDMjAaJobNZ5sZ9xUv3l5xZJs3Nh4NpekOaAnseCU8r3OjK/Kpg9/CWCNi6mb13yxT5Lprsfc5RGmH6hotA29lD5Kkgg92+7MRyLcG0ECS
 F/F8nhDNPj0eg3cpewzCnpN1hEZAqB2n4i0Hip62z2Go3NNnY49Am6Wq+UBEGXXFPUJDEQ==
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
> +the ``linux/rkisp1-config.h`` header file, See it for details.

One more question: does the ISP produce a reasonable picture if it doesn't
receive these params? If not (i.e. you always need to provide params), then
I think you should provide a default rkisp1_isp_params_cfg struct that
can be used as a template for application writers.

Perhaps it can be part of the driver as the initial params config.

I think even if the ISP does work without params it is still worthwhile
doing this. The params are complex and having an example on how to initialize
it would be helpful.

Regards,

	Hans

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
> +the ``linux/cifisp_stat.h`` header file, See it for details.
> 
