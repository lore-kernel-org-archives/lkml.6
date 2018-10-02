Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07B7C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922212089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922212089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbeJBVlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:41:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51554 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726906AbeJBVlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:41:01 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w92EtlxH003885
        for <linux-kernel@vger.kernel.org>; Tue, 2 Oct 2018 10:57:13 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mv9amvewh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 10:57:12 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ukrishn@linux.ibm.com>;
        Tue, 2 Oct 2018 10:57:11 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Oct 2018 10:57:08 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w92Ev7mw27918360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Oct 2018 14:57:07 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 668E0B2064;
        Tue,  2 Oct 2018 10:55:19 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8AE5B2066;
        Tue,  2 Oct 2018 10:55:17 -0400 (EDT)
Received: from [9.24.5.10] (unknown [9.24.5.10])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTPS;
        Tue,  2 Oct 2018 10:55:17 -0400 (EDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] MAINTAINERS: Fix typo in cxlflash stanza
From:   Uma Krishnan <ukrishn@linux.ibm.com>
In-Reply-To: <1538411170-1977-1-git-send-email-mrochs@linux.ibm.com>
Date:   Tue, 2 Oct 2018 09:54:51 -0500
Cc:     linux-kernel@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>
Content-Transfer-Encoding: 7bit
References: <1538411170-1977-1-git-send-email-mrochs@linux.ibm.com>
To:     "Matthew R. Ochs" <mrochs@linux.ibm.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-TM-AS-GCONF: 00
x-cbid: 18100214-0064-0000-0000-00000358C54F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009809; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01096828; UDB=6.00567182; IPR=6.00876871;
 MB=3.00023590; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-02 14:57:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100214-0065-0000-0000-00003AD8462D
Message-Id: <695AFDFD-5782-4F8C-9048-A1FB4428C9BE@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-02_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=767 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810020145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 1, 2018, at 11:26 AM, Matthew R. Ochs <mrochs@linux.ibm.com> wrote:
> 
> The uapi header file listed in the cxlflash stanza has a typo.
> 
> Removed the trailing 's' from the filename.
> 
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.ibm.com>
> ---

Thanks for taking care of this.

Acked-by: Uma Krishnan <ukrishn@linux.ibm.com>

