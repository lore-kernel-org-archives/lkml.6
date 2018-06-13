Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 37165C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FF9208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FF9208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936013AbeFMO6u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:58:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935697AbeFMO6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:58:42 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5DEsBmV060443
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 10:58:41 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jk3dx70r4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 10:58:41 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Wed, 13 Jun 2018 08:58:39 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Jun 2018 08:58:36 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5DEwZ4l15597992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Jun 2018 07:58:35 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8995F6E058;
        Wed, 13 Jun 2018 08:58:35 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C10F6E052;
        Wed, 13 Jun 2018 08:58:35 -0600 (MDT)
Received: from [9.41.102.69] (unknown [9.41.102.69])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jun 2018 08:58:35 -0600 (MDT)
Subject: Re: [RFC PATCH 2/5] fsi/scom: Whitespace fixes
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        openbmc@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20180612051911.20690-1-benh@kernel.crashing.org>
 <20180612051911.20690-3-benh@kernel.crashing.org>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Wed, 13 Jun 2018 09:58:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612051911.20690-3-benh@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18061314-0036-0000-0000-000009FC45DC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009183; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01046401; UDB=6.00535906; IPR=6.00825376;
 MB=3.00021625; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-13 14:58:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061314-0037-0000-0000-000047B9766B
Message-Id: <ea1b383b-8bd9-6d0e-8364-6084f54004d1@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806130160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2018 12:19 AM, Benjamin Herrenschmidt wrote:
> No functional changes
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Eddie James <eajames@linux.vnet.ibm.com>

> ---
>   drivers/fsi/fsi-scom.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
> index 3cba0eb645e1..8a608db0aa07 100644
> --- a/drivers/fsi/fsi-scom.c
> +++ b/drivers/fsi/fsi-scom.c
> @@ -49,7 +49,7 @@ static struct list_head scom_devices;
>   static DEFINE_IDA(scom_ida);
>
>   static int put_scom(struct scom_device *scom_dev, uint64_t value,
> -			uint32_t addr)
> +		    uint32_t addr)
>   {
>   	int rc;
>   	uint32_t data;
> @@ -77,7 +77,7 @@ static int put_scom(struct scom_device *scom_dev, uint64_t value,
>   }
>
>   static int get_scom(struct scom_device *scom_dev, uint64_t *value,
> -			uint32_t addr)
> +		    uint32_t addr)
>   {
>   	uint32_t result, data;
>   	int rc;
> @@ -110,7 +110,7 @@ static int get_scom(struct scom_device *scom_dev, uint64_t *value,
>   }
>
>   static ssize_t scom_read(struct file *filep, char __user *buf, size_t len,
> -			loff_t *offset)
> +			 loff_t *offset)
>   {
>   	int rc;
>   	struct miscdevice *mdev =
> @@ -136,7 +136,7 @@ static ssize_t scom_read(struct file *filep, char __user *buf, size_t len,
>   }
>
>   static ssize_t scom_write(struct file *filep, const char __user *buf,
> -			size_t len, loff_t *offset)
> +			  size_t len, loff_t *offset)
>   {
>   	int rc;
>   	struct miscdevice *mdev = filep->private_data;

