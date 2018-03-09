Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932107AbeCIOID (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 09:08:03 -0500
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:38836 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751120AbeCIOIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 09:08:01 -0500
Subject: Re: [PATCH v6 08/17] media: rkisp1: add capture device driver
To: Jacob Chen <jacob-chen@iotwrt.com>, linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        sakari.ailus@linux.intel.com, hans.verkuil@cisco.com,
        tfiga@chromium.org, zhengsq@rock-chips.com,
        laurent.pinchart@ideasonboard.com, zyc@rock-chips.com,
        eddie.cai.linux@gmail.com, jeffy.chen@rock-chips.com,
        devicetree@vger.kernel.org, heiko@sntech.de,
        Jacob Chen <jacob2.chen@rock-chips.com>,
        Jacob Chen <cc@rock-chips.com>,
        Allon Huang <allon.huang@rock-chips.com>
References: <20180308094807.9443-1-jacob-chen@iotwrt.com>
 <20180308094807.9443-9-jacob-chen@iotwrt.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <d08cd724-8edf-b934-78c7-1abde41d3290@xs4all.nl>
Date: Fri, 9 Mar 2018 15:07:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180308094807.9443-9-jacob-chen@iotwrt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFs27tZrBzgM2/SXdyZlARxi20l/ds6fyon/1k0dEA/9ApSObquaCC2ZDFcfU6AfitORz5t/QDRtmA+wWo406HkiEjcpIavnxzReymsOAxive/SN+CwV
 YyZn+HoePF70JawdHuC6E3avHhr3PNdUUMTyD45sRU6i6bxSxbStcn8QVE3F8mN9mAPZlFV9xA2ulBGi4WIeCu3jMOZKS7nCeLmEwmxGJ9I8tkshzgdHy8ct
 6p0po4lTevpnM7I4OuvIgU9YvsuTXCQiMcSjz0N5F3LoR40C/BkhfbPXghFYReyS9XfEauMrSPlTGccKdFUyK3YtpoxFpfd5ti1WpZZDYrHIp78yWU3G7z+0
 tLIlTkGL2WQduPFfE8omgMrD32UwiJ1Gd2Cei0CzHpuH8DUMBr+slOxYX5NlAX3BmjYkeTPgQ/NzA5uMfrzjDXXawWXufajiFFnWoXbrI8qP46LXJHzcyYtx
 GWln+SZoCt2pfx9mXeyuE5zk/3YPsHrVktnwVKlxBFbSLv1kxo4sYwdQ7qfgaie3r3BK8+brrGJkIrWlR2RZwxzsi+to14XH8X0jaPbnNDv2b/MmHxdbLVi3
 c9fAjiRaiKVVrHTViRPW2A6XMVzZcSBxwCEyS5X+ahCAQm7rcq5vlMb/ASdIl5Xz7a4EeEgJdkaeUT9B6oMvq9p5a3DC5i017tkF1X7DLqHESkmi8lW5xMkF
 CJx+m556YTECLIqD9FRYmWVO8/tLzmZAjQE1FP5o67J/YJbRugAeu+3ANkmpGh5Yl3DccJn/3f4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/18 10:47, Jacob Chen wrote:
> From: Jacob Chen <jacob2.chen@rock-chips.com>
> 
> This is the capture device interface driver that provides the v4l2
> user interface. Frames can be received from ISP1.
> 
> Signed-off-by: Jacob Chen <jacob2.chen@rock-chips.com>
> Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
> Signed-off-by: Yichong Zhong <zyc@rock-chips.com>
> Signed-off-by: Jacob Chen <cc@rock-chips.com>
> Signed-off-by: Eddie Cai <eddie.cai.linux@gmail.com>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Allon Huang <allon.huang@rock-chips.com>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Regards,

	Hans
