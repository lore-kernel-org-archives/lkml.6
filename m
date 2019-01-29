Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC3AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C210220989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r0jsziuy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfA2Fmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:42:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36448 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfA2Fmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 00:42:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0T5djqc105276;
        Tue, 29 Jan 2019 05:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=kAZTH3BtFzVWxWnuOigRp86z4DaWAPR7rdUE641fgyI=;
 b=r0jsziuyEsTCGH1PT7LfMEGKRDjJ+8PIlPOtxtepmYesaxdkg4qeabxtlhONn2FhP8kx
 Jq60ixdhyLG3EhQcKwMrnKM90UXBAVf7YjvlZvUx2vjnwyDrgxZV/86Rzot2ePHpONyr
 0bp0AfdSUaV2oehl09kOkBwwN8oIeKAUrrtUY3FxPIHEYzJVI+b7jaHXmu0Tw68T/kVx
 1MlSPZm9u+S9Wcdx02G3KQdZcwDHHpJUlCHxOfh0mq5M2RO0tajAz4Ao4EbFHIH8PUkq
 Ao7hEWQKzDCVn5L74ZOHTEsTalOEfkGBj3j6rzxb8kRyGaztNlONXSTXR9CLuDn+ESFf HA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2q8eyua6y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 05:42:39 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0T5gdf8003114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 05:42:39 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0T5gcUQ016814;
        Tue, 29 Jan 2019 05:42:38 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Jan 2019 21:42:37 -0800
To:     Colin King <colin.king@canonical.com>
Cc:     Don Brace <don.brace@microsemi.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: hpsa: clean up two indentation issues
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190122151830.7230-1-colin.king@canonical.com>
Date:   Tue, 29 Jan 2019 00:42:35 -0500
In-Reply-To: <20190122151830.7230-1-colin.king@canonical.com> (Colin King's
        message of "Tue, 22 Jan 2019 15:18:30 +0000")
Message-ID: <yq1va28dnp0.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9150 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=592
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901290042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> There are two statements that are indented incorrectly. Fix these.

Applied to 5.1/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
