Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4ABC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 02:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE3720866
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 02:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wb8gHwLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbeLTCyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 21:54:47 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48396 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeLTCyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 21:54:47 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBK2rYPa063308;
        Thu, 20 Dec 2018 02:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=n9IXlKdnOw9MZ1hLQl/vVLvkrl6Kaao6x+GEWaP52VA=;
 b=wb8gHwLCHONqTco6gHhKjbWWnH0nJcjhYmWDsi7wM6NyriVWw06lK4rBZuzksvpXZ+ju
 GzKppc5ah9s5q18GpxeGrkbVSkkja3f2yzfAJHUpEGUdgacrVzUeANIIZLj8zkEX278k
 IiXt9s0WQjjS2mzFRqd3g5ntDF0KBA2JZT5rCDsBUMq1kgVV54v28GRRJZtf44vkZXg9
 J3T5vsiqyH8KbFeM27zH+gZjPyzZGaIpMfjYOq3K1JCv7Uptiazv153+tzLo10WJnYqf
 UpgJRg9o5Ty+1HjeY9xtufUXeE3Uq4KYs8PiBET5FRw6fFm+BzPtpaT8HwMvWx/I9QdD Gg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2pf8gfejqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Dec 2018 02:54:42 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBK2sfNA005360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Dec 2018 02:54:41 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBK2sekM006578;
        Thu, 20 Dec 2018 02:54:40 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Dec 2018 18:54:40 -0800
To:     Colin King <colin.king@canonical.com>
Cc:     Adam Radford <aradford@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: 3w-xxx: fix indentation issue, add missing tab
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181215141708.30883-1-colin.king@canonical.com>
Date:   Wed, 19 Dec 2018 21:54:37 -0500
In-Reply-To: <20181215141708.30883-1-colin.king@canonical.com> (Colin King's
        message of "Sat, 15 Dec 2018 14:17:08 +0000")
Message-ID: <yq1zht0ewlu.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9112 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=636
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812200021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> There is a tab missing on a return statement, add the missing tab.

Applied to 4.21/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
