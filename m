Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeEWPnw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:43:52 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:11441 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbeEWPnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:43:49 -0400
Subject: Re: [RFC PATCH 0/6] net: ethernet: ti: cpsw: add MQPRIO and CBS Qdisc
 offload
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, <davem@davemloft.net>
CC: <corbet@lwn.net>, <akpm@linux-foundation.org>,
        <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <vinicius.gomes@intel.com>, <henrik@austad.us>,
        <jesus.sanchez-palencia@intel.com>, Sekhar Nori <nsekhar@ti.com>,
        Yogesh Siraswar <yogeshs@ti.com>, Schuyler Patton <spatton@ti.com>
References: <20180518211510.13341-1-ivan.khoronzhuk@linaro.org>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <176f9a29-0a89-ffa1-d7f7-708a2cdfdc7e@ti.com>
Date: Wed, 23 May 2018 10:43:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518211510.13341-1-ivan.khoronzhuk@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

On 05/18/2018 04:15 PM, Ivan Khoronzhuk wrote:
> This series adds MQPRIO and CBS Qdisc offload for TI cpsw driver.
> It potentially can be used in audio video bridging (AVB) and time
> sensitive networking (TSN).
> 
> Patchset was tested on AM572x EVM and BBB boards. Last patch from this
> series adds detailed description of configuration with examples. For
> consistency reasons, in role of talker and listener, tools from
> patchset "TSN: Add qdisc based config interface for CBS" were used and
> can be seen here: https://www.spinics.net/lists/netdev/msg460869.html
> 
> Based on net-next/master

Thanks a lot, it is great work.

In general I have no comments as of now, but I prefer to wait a bit (few 
weeks) for more comments and possible test reports.

If no comments, pls feel free to repost as final series.


> 
> Ivan Khoronzhuk (6):
>    net: ethernet: ti: cpsw: use cpdma channels in backward order for txq
>    net: ethernet: ti: cpdma: fit rated channels in backward order
>    net: ethernet: ti: cpsw: add MQPRIO Qdisc offload
>    net: ethernet: ti: cpsw: add CBS Qdisc offload
>    net: ethernet: ti: cpsw: restore shaper configuration while down/up
>    Documentation: networking: cpsw: add MQPRIO & CBS offload examples
> 
>   Documentation/networking/cpsw.txt       | 540 ++++++++++++++++++++++++
>   drivers/net/ethernet/ti/cpsw.c          | 364 +++++++++++++++-
>   drivers/net/ethernet/ti/davinci_cpdma.c |  31 +-
>   3 files changed, 913 insertions(+), 22 deletions(-)
>   create mode 100644 Documentation/networking/cpsw.txt
> 

-- 
regards,
-grygorii
