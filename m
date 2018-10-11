Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FDFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B6720644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H6mFSvUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B6720644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeJKJ1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 05:27:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60690 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeJKJ1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 05:27:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9B1wqRS034777;
        Thu, 11 Oct 2018 02:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=5m9vRgEINJ3+Kp1FIh/Yr3ew9zMVGenoeC6Yp/ZYmcY=;
 b=H6mFSvUkd4qhJoglGOqmVJZV7z9mK+AiV6nWDaiSB2RMhvYJXVwOagJPD1JmEFzK1/iW
 VeKO8lYIdPjPXpqb1nDobU+FvzKD6X4dU2WRSRiafjA6o2Ko0d/LTDjMvAaZXdv6eivl
 LxPQXR5wmx3DsxmRbSdvcX7oXPhxhG+hxh++qoyAA5aToyarDkLj44w/OAwvi5C3xImZ
 npdER54v8pui1+wDUXhsy+z4//Z8N7Lxvv18veokjWfD/G7ubFQSSfzCtGJPYq4Iplwo
 Cma5iBA8iCQFToHdga+WOot9Ad5OnEg3VYnEoZUB1QqxQWi4XhBuo0fJwMHdGI9N1pv6 dw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2mxn0q7hw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 02:01:13 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9B216U9005623
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 02:01:06 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9B216OZ001644;
        Thu, 11 Oct 2018 02:01:06 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Oct 2018 02:01:06 +0000
To:     "Matthew R. Ochs" <mrochs@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>
Subject: Re: [PATCH] MAINTAINERS: Fix typo in cxlflash stanza
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1538411170-1977-1-git-send-email-mrochs@linux.ibm.com>
Date:   Wed, 10 Oct 2018 22:01:03 -0400
In-Reply-To: <1538411170-1977-1-git-send-email-mrochs@linux.ibm.com> (Matthew
        R. Ochs's message of "Mon, 1 Oct 2018 11:26:10 -0500")
Message-ID: <yq14ldt44yo.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9042 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=627
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810110018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Matthew,

> The uapi header file listed in the cxlflash stanza has a typo.
>
> Removed the trailing 's' from the filename.

Applied to 4.20/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
