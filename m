Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBDCC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C35B206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NnJG+9hz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfALD3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 22:29:01 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49342 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfALD3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 22:29:01 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0C3Peis123326;
        Sat, 12 Jan 2019 03:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=lrEN2mot3G9SBzpREZFWYUd3FKZS+nMqbGIpQRlhlVg=;
 b=NnJG+9hzGBgAX0Kqnvzy5dx6f93KIhmaUYk0AENWr1wQFkShlCUgTkhJLZcjdYfGlGgZ
 vz3aPmB+VglIe2TxptjjZ5B+WeLfmWkLW/giPHN3DirDCeAeb0dN37bz5eXu8XWrERV5
 aBtRAjAy1l2d8LC+kdwJqI8qKOu0tTfyR2gU3J7XToE8PFHbRxwvSlmRolc4dqoUsrmy
 qpzGPNLRzU5aRiPQLy7A/vyqaYUkwGHsHZtBZEPwPTRR+F0TF1XcwnY/QMlEqp+ttk7x
 +XYE5Oe0wJGsCG6orAiA6xs83kKeM/0i8DFoYyli+3IxWc5XaDqegsU01Vfnv+nwbXRC qQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2py5rdr6n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Jan 2019 03:28:52 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0C3SkCe031623
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Jan 2019 03:28:46 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0C3Sj74023060;
        Sat, 12 Jan 2019 03:28:45 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Jan 2019 19:28:45 -0800
To:     Otto Sabart <ottosabart@seberm.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/1] doc: scsi: remove reference to tmscsim.txt file
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <ca9292ddbe567ae841b6c7e2d27e011ce078442d.1547059763.git.ottosabart@seberm.com>
Date:   Fri, 11 Jan 2019 22:28:42 -0500
In-Reply-To: <ca9292ddbe567ae841b6c7e2d27e011ce078442d.1547059763.git.ottosabart@seberm.com>
        (Otto Sabart's message of "Wed, 9 Jan 2019 20:08:56 +0100")
Message-ID: <yq1zhs6v9jp.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9133 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=685
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901120026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Otto,

> The tmscsim.txt doc file was removed in c121107d0f84.

Applied to 5.1/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
