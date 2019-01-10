Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5663DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3135D21848
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfAJJdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:33:22 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:60748 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727807AbfAJJdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:33:21 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0A9Sx91003201;
        Thu, 10 Jan 2019 03:32:46 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2pu19vru1m-1;
        Thu, 10 Jan 2019 03:32:46 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 24262650F62A;
        Thu, 10 Jan 2019 03:36:56 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 10 Jan 2019
 09:32:45 +0000
Received: from [198.90.251.142] (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.142])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 x0A9WiKv000357;        Thu, 10 Jan 2019 09:32:44 GMT
Subject: Re: [PATCH 1/1] doc: pinctrl: fix bad reference to pinctrl.txt file
To:     Otto Sabart <ottosabart@seberm.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
CC:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
References: <10552cb9ce3067c4b4cf8c25ed6a20c498478549.1547060185.git.ottosabart@seberm.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <4338fca9-11ca-ec92-e6bf-a5734eb1c07c@opensource.cirrus.com>
Date:   Thu, 10 Jan 2019 09:32:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <10552cb9ce3067c4b4cf8c25ed6a20c498478549.1547060185.git.ottosabart@seberm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=809 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901100078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/19 19:06, Otto Sabart wrote:
> The pinctrl.txt file was converted into reStructuredText and moved into
> driver-api folder. This patch updates the broken reference.
> 
> Fixes: 5a9b73832e9e ("pinctrl.txt: move it to the driver-api book")
> Signed-off-by: Otto Sabart <ottosabart@seberm.com>
> ---
>   include/linux/mfd/madera/pdata.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mfd/madera/pdata.h b/include/linux/mfd/madera/pdata.h
> index 8dc852402dbb..dd00ab824e5b 100644
> --- a/include/linux/mfd/madera/pdata.h
> +++ b/include/linux/mfd/madera/pdata.h
> @@ -34,7 +34,8 @@ struct madera_codec_pdata;
>    * @micvdd:	    Substruct of pdata for the MICVDD regulator
>    * @irq_flags:	    Mode for primary IRQ (defaults to active low)
>    * @gpio_base:	    Base GPIO number
> - * @gpio_configs:   Array of GPIO configurations (See Documentation/pinctrl.txt)
> + * @gpio_configs:   Array of GPIO configurations (See
> + *		    Documentation/driver-api/pinctl.rst)
>    * @n_gpio_configs: Number of entries in gpio_configs
>    * @gpsw:	    General purpose switch mode setting. Depends on the external
>    *		    hardware connected to the switch. (See the SW1_MODE field
> 

Acked-by: Richard Fitzgerald <rf@opensource.cirrus.com>
