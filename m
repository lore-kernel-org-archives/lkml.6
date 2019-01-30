Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD78C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5D22086C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387601AbfA3T0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:26:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727114AbfA3T0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:26:42 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0UJEEb9014877
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 14:26:41 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qbgr9kq18-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 14:26:41 -0500
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <seroyer@linux.ibm.com>;
        Wed, 30 Jan 2019 19:26:40 -0000
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 30 Jan 2019 19:26:38 -0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0UJQa9811796632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Jan 2019 19:26:36 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AE0A6E053;
        Wed, 30 Jan 2019 19:26:36 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AB1F6E052;
        Wed, 30 Jan 2019 19:26:36 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 30 Jan 2019 19:26:36 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 30 Jan 2019 13:32:48 -0600
From:   Steven Royer <seroyer@linux.ibm.com>
To:     Brad Warrum <bwarrum@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add myself as maintainer of ibmvmc driver
In-Reply-To: <1548459386-4596-1-git-send-email-bwarrum@linux.ibm.com>
References: <1548459386-4596-1-git-send-email-bwarrum@linux.ibm.com>
X-Sender: seroyer@linux.ibm.com
User-Agent: Roundcube Webmail/1.0.1
X-TM-AS-GCONF: 00
x-cbid: 19013019-0020-0000-0000-00000EB4250B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010505; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01154047; UDB=6.00601719; IPR=6.00934424;
 MB=3.00025357; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-30 19:26:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013019-0021-0000-0000-0000649E4790
Message-Id: <8f9022a1c2f928b6db0249a4e6e43af0@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=990 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901300145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking over Brad!

On 2019-01-25 17:36, Brad Warrum wrote:
> Steve Royer has moved on to another project and has
> requested that I maintain the IBM Power Virtual Management
> Channel driver in his stead.
> 
> Cc: Steve Royer <seroyer@linux.ibm.com>
> Signed-off-by: Brad Warrum <bwarrum@linux.ibm.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 51029a4..9a20eae 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7244,7 +7244,7 @@ S:	Supported
>  F:	drivers/scsi/ibmvscsi/ibmvfc*
> 
>  IBM Power Virtual Management Channel Driver
> -M:	Steven Royer <seroyer@linux.ibm.com>
> +M:	Brad Warrum <bwarrum@linux.ibm.com>
>  S:	Supported
>  F:	drivers/misc/ibmvmc.*

