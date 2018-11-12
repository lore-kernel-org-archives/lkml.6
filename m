Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0865BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C710B2243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C710B2243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbeKLXbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 18:31:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729204AbeKLXbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 18:31:18 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wACDaSp9119749
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 08:37:58 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nq810xu12-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 08:37:57 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <haver@linux.vnet.ibm.com>;
        Mon, 12 Nov 2018 13:37:57 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 12 Nov 2018 13:37:55 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wACDbsYo17498348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Nov 2018 13:37:54 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF0C4125A96;
        Mon, 12 Nov 2018 13:22:16 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D357012F3AE;
        Mon, 12 Nov 2018 11:26:10 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 12 Nov 2018 11:26:10 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Nov 2018 12:29:02 +0100
From:   haver <haver@linux.vnet.ibm.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     gregkh@linuxfoundation.org, gpiccoli@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: genwqe: remove duplicated include file
In-Reply-To: <1537420031-30405-1-git-send-email-zhongjiang@huawei.com>
References: <1537420031-30405-1-git-send-email-zhongjiang@huawei.com>
X-Sender: haver@linux.vnet.ibm.com
User-Agent: Roundcube Webmail/1.0.1
X-TM-AS-GCONF: 00
x-cbid: 18111213-2213-0000-0000-00000315FE87
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010033; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116369; UDB=6.00578947; IPR=6.00896477;
 MB=3.00024122; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-12 13:37:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111213-2214-0000-0000-00005C3A48B3
Message-Id: <2fccbaf463b4adabe06937840627d844@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811120123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-20 07:07, zhong jiang wrote:
> module.h has duplicated include. hence just remove
> redundant include file.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/misc/genwqe/card_base.c | 1 -
>  drivers/misc/genwqe/card_ddcb.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/misc/genwqe/card_base.c 
> b/drivers/misc/genwqe/card_base.c
> index c7cd367..d137d0fa 100644
> --- a/drivers/misc/genwqe/card_base.c
> +++ b/drivers/misc/genwqe/card_base.c
> @@ -24,7 +24,6 @@
>   * controlled from here.
>   */
> 
> -#include <linux/module.h>
>  #include <linux/types.h>
>  #include <linux/pci.h>
>  #include <linux/err.h>
> diff --git a/drivers/misc/genwqe/card_ddcb.c 
> b/drivers/misc/genwqe/card_ddcb.c
> index 656449c..9a65bd9 100644
> --- a/drivers/misc/genwqe/card_ddcb.c
> +++ b/drivers/misc/genwqe/card_ddcb.c
> @@ -27,7 +27,6 @@
>   */
> 
>  #include <linux/types.h>
> -#include <linux/module.h>
>  #include <linux/sched.h>
>  #include <linux/wait.h>
>  #include <linux/pci.h>

Signed-off-by: Frank Haverkamp <haver@linux.vnet.ibm.com>

