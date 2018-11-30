Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3FCC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8282206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8282206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbeLAHbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:31:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725749AbeLAHbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:31:44 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAUKEERI006944
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 15:21:16 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p3bcvj0yw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 15:21:16 -0500
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.vnet.ibm.com>;
        Fri, 30 Nov 2018 20:21:15 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 30 Nov 2018 20:21:11 -0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAUKLBb222282258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Nov 2018 20:21:11 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB86D7805E;
        Fri, 30 Nov 2018 20:21:10 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F55B7805F;
        Fri, 30 Nov 2018 20:21:09 +0000 (GMT)
Received: from [153.66.254.194] (unknown [9.85.139.109])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 30 Nov 2018 20:21:09 +0000 (GMT)
Subject: Re: [PATCH RFC 11/15] scsi: replace **** with a hug
From:   James Bottomley <jejb@linux.vnet.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>
Date:   Fri, 30 Nov 2018 12:21:07 -0800
In-Reply-To: <20181130192737.15053-12-jarkko.sakkinen@linux.intel.com>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
         <20181130192737.15053-12-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18113020-0016-0000-0000-0000095D9731
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010148; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01125083; UDB=6.00584191; IPR=6.00905211;
 MB=3.00024399; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-30 20:21:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18113020-0017-0000-0000-0000413F2D1C
Message-Id: <1543609267.3031.14.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-30_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811300172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-30 at 11:27 -0800, Jarkko Sakkinen wrote:
> In order to comply with the CoC, replace **** with a hug.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  drivers/scsi/qlogicpti.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/qlogicpti.h b/drivers/scsi/qlogicpti.h
> index 884ad72ade57..f1785154061c 100644
> --- a/drivers/scsi/qlogicpti.h
> +++ b/drivers/scsi/qlogicpti.h
> @@ -62,7 +62,7 @@
>  #define REQUEST_QUEUE_WAKEUP		0x8005
>  #define EXECUTION_TIMEOUT_RESET		0x8006
>  
> -/* Am I fucking pedantic or what? */
> +/* Am I hugging pedantic or what? */

I really don't think this is either necessary or a good idea.  The code
of conduct explicitly doesn't require this.  It says:

   Contributions submitted for the kernel should use appropriate
   language.
   Content that already exists predating the Code of Conduct will not
   be
   addressed now as a violation.

However, I assume you're thinking about the next sentence:

   Inappropriate language can be seen as a bug, though; such bugs will
   be fixed more quickly if any interested parties submit patches to
   that effect.

?

I would interpret the above comment as simply an expression of
frustration directed by the author at some of the endian problems
drivers like this bring.  Since it's not directed at anything other
than hardware I don't think it could be seen as threatening or abusive
or contributing to a negative environment even if submitted today.

For better or for worse, the word "fuck", which was once seen as so
beyond the pale that only loose tongued individuals like monty python
could get away with it (The great John Cleese use of the word fuck at a
funeral [Eric Chapman's] springing immediately to mind), has now moved
into the TV primetime mainstream and it's not our job to try and
reimpose language decency on the world.

James

