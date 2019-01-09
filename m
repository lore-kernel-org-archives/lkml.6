Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B838C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D372206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VqHOda50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbfAIDcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 22:32:18 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38226 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbfAIDcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 22:32:18 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x093PEZg052672;
        Wed, 9 Jan 2019 03:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=I0jdDjClrVVqFaHhiTX5ghG8S6oV6E+6mjDARHGiN40=;
 b=VqHOda50JtvrhalZpDTov+jzNzOd/PjpFi13oJJ2rIPryNHsJ2G5CgcmSdsRm3Al4LRi
 Vq5tOKtvW4UWKgKtKTh7OqGl1XQormwp1tEVoY46lNDxl3mioCbjQ5xeY22GnD3AG+cH
 cenHJjHeC8b7SgMyD6Rk1JjFxy5l1i6CeaM2vpdylvrrS787R9FhPam6kTlJv1nF+mjG
 Oe80hvD6+KpSuxfObOkAP3LGFOYkjfnA5v5+dmHYUSO2/TrsniECxXddNggsrGf3FHRN
 HCxRIOAZHqQ+bvt5LbLiHPOEWCaucqVjVdvh1DIeMBn+xsxDmZ2M3IoxkofCBUXbT9PK iw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2ptm0u741m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jan 2019 03:32:11 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x093W9Gm018132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Jan 2019 03:32:10 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x093W8BU007580;
        Wed, 9 Jan 2019 03:32:09 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Jan 2019 19:32:08 -0800
To:     Colin King <colin.king@canonical.com>
Cc:     QLogic-Storage-Upstream@qlogic.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: bnx2i: fix indentation issue, remove a tab
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190104170224.8147-1-colin.king@canonical.com>
Date:   Tue, 08 Jan 2019 22:32:05 -0500
In-Reply-To: <20190104170224.8147-1-colin.king@canonical.com> (Colin King's
        message of "Fri, 4 Jan 2019 17:02:24 +0000")
Message-ID: <yq14lai4ibu.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9130 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=558
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901090026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> The return statement is indented incorrectly, fix this by removing a
> single tab.

Applied to 5.1/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
