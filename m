Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817EAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E1C2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbfARL6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:58:00 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:56872 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726593AbfARL6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:58:00 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0IBqJvp012680;
        Fri, 18 Jan 2019 05:55:48 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0b-001ae601.pphosted.com with ESMTP id 2pydhrbxn3-1;
        Fri, 18 Jan 2019 05:55:37 -0600
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id 46CAC611C8BD;
        Fri, 18 Jan 2019 05:55:39 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Fri, 18 Jan 2019
 11:55:36 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id x0IBtaC3031808; Fri,
 18 Jan 2019 11:55:36 GMT
Date:   Fri, 18 Jan 2019 11:55:36 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Otto Sabart <ottosabart@seberm.com>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH 1/1] doc: pinctrl: fix bad reference to pinctrl.txt file
Message-ID: <20190118115536.GF3837@imbe.wolfsonmicro.main>
References: <10552cb9ce3067c4b4cf8c25ed6a20c498478549.1547060185.git.ottosabart@seberm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <10552cb9ce3067c4b4cf8c25ed6a20c498478549.1547060185.git.ottosabart@seberm.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=958 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901180089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 08:06:54PM +0100, Otto Sabart wrote:
> The pinctrl.txt file was converted into reStructuredText and moved into
> driver-api folder. This patch updates the broken reference.
> 
> Fixes: 5a9b73832e9e ("pinctrl.txt: move it to the driver-api book")
> Signed-off-by: Otto Sabart <ottosabart@seberm.com>
> ---

Just noticed you don't have any maintainers on this email. You
really need to add Lee Jones in the to field, he is the guy would
would apply the patch.

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

>  include/linux/mfd/madera/pdata.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mfd/madera/pdata.h b/include/linux/mfd/madera/pdata.h
> index 8dc852402dbb..dd00ab824e5b 100644
> --- a/include/linux/mfd/madera/pdata.h
> +++ b/include/linux/mfd/madera/pdata.h
> @@ -34,7 +34,8 @@ struct madera_codec_pdata;
>   * @micvdd:	    Substruct of pdata for the MICVDD regulator
>   * @irq_flags:	    Mode for primary IRQ (defaults to active low)
>   * @gpio_base:	    Base GPIO number
> - * @gpio_configs:   Array of GPIO configurations (See Documentation/pinctrl.txt)
> + * @gpio_configs:   Array of GPIO configurations (See
> + *		    Documentation/driver-api/pinctl.rst)
>   * @n_gpio_configs: Number of entries in gpio_configs
>   * @gpsw:	    General purpose switch mode setting. Depends on the external
>   *		    hardware connected to the switch. (See the SW1_MODE field
> -- 
> 2.17.2
> 


