Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D126C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2E3205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZJWIqKZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2E3205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754149AbeFTCEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 22:04:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44412 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbeFTCEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 22:04:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5K20Glx011308;
        Wed, 20 Jun 2018 02:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2017-10-26;
 bh=iCFnp01Owc1XKZgD9i6ZRaJrR9cItCRYvaS8pddkFMg=;
 b=ZJWIqKZFxL+2enFmjXzoWFC2OCJAcIh5cl0loiOX6KfKo80ZxpoUnOKKPw21sPky6c+F
 M4qEeXxEomvbUZ9BqgXsrRntDRg95MnumpA0QWM8ZXRhCvtP+Y+GumdRhXkJAwoRILAL
 LtQsAFJY+g914OXLU8fBK35AxlfV1P2c5+U+ZA2VNql1XLEDfu83p1H45T9Z3EMVlCdy
 Nn0zNpKvbgnXDnDdED2dOFmdIQxmLkGgw2xiB7npWUQpiH6PC2Ecohn9EzA4LQIyPGcN
 hHB73DheegmZRbPiij/SeRLGzSqSaBdPuY6BKUmoVLktQg/9LpD6aHNLQIUPQuSlYhCG dg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2jmu6xtevq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 02:03:58 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5K23vT9024606
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 02:03:57 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5K23v8t030490;
        Wed, 20 Jun 2018 02:03:57 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jun 2018 19:03:57 -0700
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
Date:   Tue, 19 Jun 2018 22:03:48 -0400
In-Reply-To: <20180619211533.1dddf9b0@canb.auug.org.au> (Stephen Rothwell's
        message of "Tue, 19 Jun 2018 21:15:33 +1000")
Message-ID: <yq1y3fadxiz.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8929 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=788
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Stephen,

> Commit
>
>   508fbc44bbb7 ("scsi: be2iscsi: Include null char in SET_HOST_DATA")
>
> is missing a Signed-off-by from its author.

Fixed, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
