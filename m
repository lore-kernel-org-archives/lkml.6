Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB04FC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8320D218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CXK6r4iU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfADGBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 01:01:49 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42802 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfADGBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 01:01:49 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x045rcJN116340;
        Fri, 4 Jan 2019 06:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=nolOXNMAY3l934LznxtS7RtI0A0OPNy0UX2h2+5zBXM=;
 b=CXK6r4iUp/FtFnNsCgPKWnjaUalt2wr4S8e/5eHXTN4wER8+r0rotLOZuBxcAElsNE8s
 mPVHAno72kEJ/77ZIKVdGc5cwF6deVdgzgibrqvIqbOY8BdTEHowdajSM1lLjgjjkemd
 Ora+jyg67WPRI4Vcgva0vbFHiDFhdG5ZLKR4jGPSrMCe/mQCUqcro3ei3N19YXOERRYG
 dA+9z3YlSbuaPRxbkcJqfNTtr7SpMfCU51xgjSF7ckFVylcEFNMVgdj5VvUgXykd8dfD
 Oam0k5xVRbr3FSnyAB4X40nNr7nL+8TkUTgEzFxYvwV8WoOZNPzzOs0YDU+QAizntttH 6g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2pp1jraewq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jan 2019 06:01:36 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0461ZLY010133
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Jan 2019 06:01:35 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0461Ull018109;
        Fri, 4 Jan 2019 06:01:31 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Jan 2019 22:01:30 -0800
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Jack Wang <jinpu.wang@profitbricks.com>,
        kernel-janitors@vger.kernel.org, lindar_liu@usish.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] scsi: pm80xx: reduce indentation
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <1546185195-25676-7-git-send-email-Julia.Lawall@lip6.fr> (Julia
        Lawall's message of "Sun, 30 Dec 2018 16:53:13 +0100")
Organization: Oracle Corporation
References: <1546185195-25676-1-git-send-email-Julia.Lawall@lip6.fr>
        <1546185195-25676-7-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Fri, 04 Jan 2019 01:01:27 -0500
Message-ID: <yq1r2dt6jwo.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9125 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=450
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901040052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Julia,

> Delete tab aligning a statement with the right hand side of a
> preceding assignment rather than the left hand side.

Applied to 4.21/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
