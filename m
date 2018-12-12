Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC2BC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721A220839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721A220839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeLLPmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:42:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51762 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727752AbeLLPmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 10:42:31 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBCFYvoi028775
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 10:42:30 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pb2d814yn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 10:42:29 -0500
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <farman@linux.ibm.com>;
        Wed, 12 Dec 2018 15:42:28 -0000
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Dec 2018 15:42:26 -0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBCFgMZI25297068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Dec 2018 15:42:23 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDE03BE058;
        Wed, 12 Dec 2018 15:42:22 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D08F2BE054;
        Wed, 12 Dec 2018 15:42:21 +0000 (GMT)
Received: from [9.80.216.116] (unknown [9.80.216.116])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 12 Dec 2018 15:42:21 +0000 (GMT)
Subject: Re: [PATCH] MAINTAINERS/vfio-ccw: add Farhan and Eric, make Halil
 Reviewer
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>
References: <20181212145929.136522-1-borntraeger@de.ibm.com>
From:   Eric Farman <farman@linux.ibm.com>
Date:   Wed, 12 Dec 2018 10:42:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181212145929.136522-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18121215-0004-0000-0000-000014C12264
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010214; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01130741; UDB=6.00587588; IPR=6.00910875;
 MB=3.00024669; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-12 15:42:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121215-0005-0000-0000-000089D3C365
Message-Id: <17465894-0576-a178-42a4-539abfec1089@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=943 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812120135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/2018 09:59 AM, Christian Borntraeger wrote:
> Eric and Farhan will help with maintaining vfio-ccw.
> 
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Farhan Ali <alifm@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>   MAINTAINERS | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8119141a926f..879594b93385 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13026,7 +13026,9 @@ F:	drivers/pci/hotplug/s390_pci_hpc.c
>   
>   S390 VFIO-CCW DRIVER
>   M:	Cornelia Huck <cohuck@redhat.com>
> -M:	Halil Pasic <pasic@linux.ibm.com>
> +M:	Farhan Ali <alifm@linux.ibm.com>
> +M:	Eric Farman <farman@linux.ibm.com>
> +R:	Halil Pasic <pasic@linux.ibm.com>
>   L:	linux-s390@vger.kernel.org
>   L:	kvm@vger.kernel.org
>   S:	Supported
> 

Acked-by: Eric Farman <farman@linux.ibm.com>

