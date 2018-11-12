Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D641FC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B0E224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B0E224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbeKMACp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 19:02:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727103AbeKMACo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 19:02:44 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wACE8Ve2085378
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 09:09:17 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nqa31u63g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 09:08:38 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <haver@linux.vnet.ibm.com>;
        Mon, 12 Nov 2018 14:08:04 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 12 Nov 2018 14:08:02 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wACE81vl32833774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Nov 2018 14:08:01 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64AF4ED99F;
        Mon, 12 Nov 2018 13:19:29 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7861E12F4E6;
        Mon, 12 Nov 2018 11:27:22 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 12 Nov 2018 11:27:22 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Nov 2018 12:30:14 +0100
From:   haver <haver@linux.vnet.ibm.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     gregkh@linuxfoundation.org, gpiccoli@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: card_utils: remove duplicated include file
In-Reply-To: <1537419842-30220-1-git-send-email-zhongjiang@huawei.com>
References: <1537419842-30220-1-git-send-email-zhongjiang@huawei.com>
X-Sender: haver@linux.vnet.ibm.com
User-Agent: Roundcube Webmail/1.0.1
X-TM-AS-GCONF: 00
x-cbid: 18111214-0052-0000-0000-00000354890B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010033; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116379; UDB=6.00578953; IPR=6.00896487;
 MB=3.00024126; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-12 14:08:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111214-0053-0000-0000-00005EBD1BF8
Message-Id: <265b709cb2198e8495295322cf455303@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-12_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811120126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-20 07:04, zhong jiang wrote:
> delay.h and dma-mapping.h have duplicated include. hence just remove
> redundant file.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/misc/genwqe/card_utils.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/misc/genwqe/card_utils.c 
> b/drivers/misc/genwqe/card_utils.c
> index f0961ec..3fcb9a2 100644
> --- a/drivers/misc/genwqe/card_utils.c
> +++ b/drivers/misc/genwqe/card_utils.c
> @@ -23,14 +23,12 @@
>   */
> 
>  #include <linux/kernel.h>
> -#include <linux/dma-mapping.h>
>  #include <linux/sched.h>
>  #include <linux/vmalloc.h>
>  #include <linux/page-flags.h>
>  #include <linux/scatterlist.h>
>  #include <linux/hugetlb.h>
>  #include <linux/iommu.h>
> -#include <linux/delay.h>
>  #include <linux/pci.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/ctype.h>

Signed-off-by: Frank Haverkamp <haver@linux.vnet.ibm.com>

