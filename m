Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43235C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E7B218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbfABPRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:17:20 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:42866 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728998AbfABPRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:17:20 -0500
X-Greylist: delayed 5021 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jan 2019 10:17:19 EST
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x02DpUoP003488;
        Wed, 2 Jan 2019 13:53:31 GMT
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 2pruk8110g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jan 2019 13:53:31 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 351E45A;
        Wed,  2 Jan 2019 13:53:30 +0000 (UTC)
Received: from hpe.com (teo-eag.americas.hpqcorp.net [10.33.152.10])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id C7EC647;
        Wed,  2 Jan 2019 13:53:29 +0000 (UTC)
Date:   Wed, 2 Jan 2019 07:53:29 -0600
From:   Dimitri Sivanich <sivanich@hpe.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Dimitri Sivanich <sivanich@hpe.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gru: clean up indentation issue, remove spaces
Message-ID: <20190102135329.GB9199@hpe.com>
References: <20181221224419.15284-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221224419.15284-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-02_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901020126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Dimitri Sivanich <sivanich@hpe.com>

On Fri, Dec 21, 2018 at 10:44:19PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are a couple of statements that have extra spaces in the identation,
> fix this by removing them.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/misc/sgi-gru/grufault.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
> index 93be82fc338a..2ec5808ba464 100644
> --- a/drivers/misc/sgi-gru/grufault.c
> +++ b/drivers/misc/sgi-gru/grufault.c
> @@ -616,8 +616,8 @@ irqreturn_t gru_intr_mblade(int irq, void *dev_id)
>  	for_each_possible_blade(blade) {
>  		if (uv_blade_nr_possible_cpus(blade))
>  			continue;
> -		 gru_intr(0, blade);
> -		 gru_intr(1, blade);
> +		gru_intr(0, blade);
> +		gru_intr(1, blade);
>  	}
>  	return IRQ_HANDLED;
>  }
> -- 
> 2.19.1
> 
