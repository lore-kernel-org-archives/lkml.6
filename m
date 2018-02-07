Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754678AbeBGQbt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 11:31:49 -0500
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:53855 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754378AbeBGQbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 11:31:48 -0500
Subject: Re: [PATCH v5 03/16] media: rkisp1: Add user space ABI definitions
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
 <1514533978-20408-4-git-send-email-zhengsq@rock-chips.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <d98ac356-a482-f26f-fd6b-6142281d99c3@xs4all.nl>
Date: Wed, 7 Feb 2018 17:31:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1514533978-20408-4-git-send-email-zhengsq@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIGtZB4WQ9eHzaLOTWYD58ATGa1GnlacvajfbSLIg+uOjX37AOwpyJLM9P14ZcP5I9r47p8+Ewv8MrCYQdeMhL6pHtosjd+Q6w/PBp+41cPzb3/PlfgZ
 OJ/P/WLtw5HFyiTY2614gax1vuqXPVtJZrQLuun/+HmWh2mFW6i4RNtri9LL2XmPWzoX90upV3nkLxjBml2x5kLJ4pbodCqD676aozUdxCGQ5U8xtmJiuM6b
 bSefgsPIuQ8syup0ct9kvi7Wjg/pgeDldihdw5ts8XmmPBZ9sF4Qa950Y0ZOnmBTiETDGucGtI/UtfSLRUajm2SDfoZhCAdxS3NjY1LSPxAZwcLjVSXRNgsx
 vtuTJvmkCkcEDlt5/SbsD4q4ahF9eZSiffmhiGSvHLn99umqtCSJgzWrzlEnQrDioNvLvaBMhkrLTjvrvYSVR9OA6xXRtDBaeQtP8W+5B3Svxx9MKf2YkJ+0
 173rxzidjWiojeXs/N5ggcKLnzNUKrOqwFa1V+6HF3bGyQ+USxJnlFN0KtlHLNuq+cp+4g2q19XTAGe82zKqvKohyLi2SpX9BUUcMqhPMlpSj43uH07DAB4t
 6tNJw6E+Ggyr5BCp3ttEVEsLatyms4iSejxMefNmsKQk33BJHfQqFKLk/hWRxSi35nQrDSrS2anp7We5bVZo3GS9ETWJ3mITIiYoNoQn2Ck9l5vzDBUnstIZ
 TvR7Z1er/o9H3N1b/n6lAQCfNsnhBeyjtLzWiMv1PCpm+U1oExHPt+omJ3Wuzfsr8ItnUZggTcr0UNzljGvfd+mp/HOYasUicOgIC3AjlHgWU5lv3jAY5I5I
 ePIVvspOKutfEIbWK7QVn+uhzbHbJFLTGi9zyq9/
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/2017 08:52 AM, Shunqian Zheng wrote:
> From: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> Add the header for userspace
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Jacob Chen <jacob2.chen@rock-chips.com>
> ---
>  include/uapi/linux/rkisp1-config.h | 757 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 757 insertions(+)
>  create mode 100644 include/uapi/linux/rkisp1-config.h
> 
> diff --git a/include/uapi/linux/rkisp1-config.h b/include/uapi/linux/rkisp1-config.h
> new file mode 100644
> index 0000000..0f9f4226
> --- /dev/null
> +++ b/include/uapi/linux/rkisp1-config.h
> @@ -0,0 +1,757 @@

<snip>

> +/**
> + * enum cifisp_exp_ctrl_auotostop - stop modes

auotostop -> autostop

> + * @CIFISP_EXP_CTRL_AUTOSTOP_0: continous measurement

continous -> continuous

> + * @CIFISP_EXP_CTRL_AUTOSTOP_1: stop measuring after a complete frame
> + */
> +enum cifisp_exp_ctrl_auotostop {

auotostop -> autostop

> +	CIFISP_EXP_CTRL_AUTOSTOP_0 = 0,
> +	CIFISP_EXP_CTRL_AUTOSTOP_1 = 1,
> +};

Just noticed this :-)

Regards,

	Hans
