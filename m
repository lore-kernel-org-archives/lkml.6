Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbeDRXbS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 19:31:18 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40856 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753038AbeDRXbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 19:31:17 -0400
To: Long Li <longli@microsoft.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: linux-next: build warning after merge of the scsi tree
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180417122540.1c0a3fee@canb.auug.org.au>
        <MWHPR2101MB072925FF18BBA2F84B2EE470CEB60@MWHPR2101MB0729.namprd21.prod.outlook.com>
Date: Wed, 18 Apr 2018 19:30:59 -0400
In-Reply-To: <MWHPR2101MB072925FF18BBA2F84B2EE470CEB60@MWHPR2101MB0729.namprd21.prod.outlook.com>
        (Long Li's message of "Wed, 18 Apr 2018 21:52:32 +0000")
Message-ID: <yq1r2ncm6rw.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8867 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=560
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804180210
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Long,

> I will fix this by moving those data structure to kmalloc pre-allocated
> when channel is first created.

Sounds good. I'll drop patch 3 for now and wait for you to resubmit.

-- 
Martin K. Petersen	Oracle Linux Engineering
