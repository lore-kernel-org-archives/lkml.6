Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50422C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A3F20989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q07kv9RG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfA2G37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:29:59 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:41758 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfA2G36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 01:29:58 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0T6SfpX085304;
        Tue, 29 Jan 2019 06:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=9pqRrKenbzTOFzByFlBjt98/0Ww2nFnRICMqfVp7hvg=;
 b=Q07kv9RGXMqo4OvU6ps2ifoArwZmmYpLas9p/JXgczRN2Va9ZHueq3vLGFQ+nlSnv9kz
 9MznyEXMXtKbX1T9QdEwtCr/Xfy0+8BF2mVO8JeSflrE0z34j9+cquxad3TlG1C/wAvW
 StAtU6hUg9WtCN3jS6aBCZEJ+I93amMgo8drdcoeMT3JyFuVsky+YPnPSz6Tmforqqv8
 AB6FWi1TEyFPZqvnSKxjPMHbfzUqtSbshqQgUUJX6ef+NUWxT2uHY/5+h+zLdO4Q4OPl
 +RpPSBHJ0OPfQOQyeUgdZoShpg031Ut4+2HNQUkuggpdA7MjcI9aaExJ/FGqIl54igFZ LA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2q8d2e2ja8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 06:29:46 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0T6Tj4t025084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 06:29:45 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0T6Tj5f009267;
        Tue, 29 Jan 2019 06:29:45 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Jan 2019 22:29:44 -0800
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: Remove unnecessary parentheses
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181210235540.7039-1-natechancellor@gmail.com>
        <20190126191203.GC25003@archlinux-ryzen>
Date:   Tue, 29 Jan 2019 01:29:42 -0500
In-Reply-To: <20190126191203.GC25003@archlinux-ryzen> (Nathan Chancellor's
        message of "Sat, 26 Jan 2019 12:12:03 -0700")
Message-ID: <yq1sgxcc6y1.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9150 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=898
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901290048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nathan,

>> drivers/scsi/pcmcia/nsp_cs.c:1137:27: warning: equality comparison with
>> extraneous parentheses [-Wparentheses-equality]
>>                 if ((tmpSC->SCp.Message == MSG_COMMAND_COMPLETE)) {
>>                      ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~

Applied to 5.1/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
