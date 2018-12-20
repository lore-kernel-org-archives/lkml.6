Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C841C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 02:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C30820989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 02:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zS5iOvJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbeLTCzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 21:55:35 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46008 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeLTCze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 21:55:34 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBK2rTfE067632;
        Thu, 20 Dec 2018 02:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=IjbdnKms4YTIPUPreVSrhPe4UNKK3B3uWwqXHA/3Uj4=;
 b=zS5iOvJ1Qgk9lCks/jEcFL7HSbK33VeDdQy1XavlfR1cxdvLXboSsDQGp1r9koXb3Zg+
 ia7YvyNE6nnKZWhv7yo63t21qUXMiLwgQ4iAqkzqnlRrzZddfiLYB3aeLSa5DOjNVH3+
 uqFfuS+ydK4jbktgErnbL+RNrvQLmWdaoNhj1it43iJG2vlsVULIyxs5wv3ovSckv9jj
 SB7RBLaww3BdO9iuae5kO2IrOYcZi/bkNkHQrQk2OOSrRZiKWm5iyIy9IMCC4r+6Aw01
 ONGbhRHFKKhQL37vUDQvySdGyQA3X+64o2O+ZIFAdUDzE1nnP5F/ORE/k5kEkVMu57nK Ew== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2pfn1yus96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Dec 2018 02:55:27 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBK2tMD5024959
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Dec 2018 02:55:22 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBK2tL43006873;
        Thu, 20 Dec 2018 02:55:22 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Dec 2018 18:55:21 -0800
To:     Colin King <colin.king@canonical.com>
Cc:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: bfa: clean up a couple of indentation issues
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181215142809.31115-1-colin.king@canonical.com>
Date:   Wed, 19 Dec 2018 21:55:19 -0500
In-Reply-To: <20181215142809.31115-1-colin.king@canonical.com> (Colin King's
        message of "Sat, 15 Dec 2018 14:28:09 +0000")
Message-ID: <yq1va3oewko.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9112 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=669
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812200021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> There is a break statement with an extra space that needs removed and
> a call to bfa_trc that is indented one level too much. Fix these.

Applied to 4.21/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
