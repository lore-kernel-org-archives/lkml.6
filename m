Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33114C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF66620846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZA7tCxYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF66620846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932469AbeFTQiJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:38:09 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49042 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932308AbeFTQiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:38:08 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5KGYdTk129543;
        Wed, 20 Jun 2018 16:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2017-10-26;
 bh=uWR/AeRbc7iXL00nlhFi2PjsDt+30FjhhHvElblTF7E=;
 b=ZA7tCxYjI7zlWCCxLLuzGv1DZQ2VhsNz9ACfJgEwhApMkwDIvXTNDCx+foaILA3jfqTv
 Hhe58MKCgg+BUI56dSxgtKxSiPanafWFqe9GZ37AixA2eagrxlFeKVzoJffppyd17r52
 qRhUn5y/hrtALbFXkxFeq9RVRPVgVKsOyakSsm9rJIM6bpy0Y01Xca6aF9UE8QUCely1
 4K7wpFS8zU/GKTvmCgXV7j4q1VdtJw8+Ey5C7Gd3QRZPCtL9z4CBugxBswJOMvshWrBm
 a3groi2cvqVdjBWR/ZV/vEjeiZEoV+Q54Dae8qKIU3n1YF+61kUn84hdPHQR4mBIrEGh vg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jmr2mnfjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 16:37:58 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5KGbu4N025228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 16:37:57 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5KGbtfD013688;
        Wed, 20 Jun 2018 16:37:55 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 09:37:55 -0700
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the scsi-mkp tree
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180619211533.1dddf9b0@canb.auug.org.au>
        <yq1y3fadxiz.fsf@oracle.com>
        <20180620145436.4deb9079@canb.auug.org.au>
Date:   Wed, 20 Jun 2018 12:37:53 -0400
In-Reply-To: <20180620145436.4deb9079@canb.auug.org.au> (Stephen Rothwell's
        message of "Wed, 20 Jun 2018 14:54:36 +1000")
Message-ID: <yq1h8lxe7mm.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8930 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=901
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Stephen,

>> Fixed, thanks!
>
> Unfortunately, James had already merged your tree :-(

James' script will drop the offending original commit when I amend
something in the SCSI tree. So the discrepancy will go away next time he
updates.

-- 
Martin K. Petersen	Oracle Linux Engineering
