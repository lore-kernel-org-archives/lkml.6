Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754161AbeEHFmh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 01:42:37 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58666 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbeEHFmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 01:42:35 -0400
To: Ching Huang <ching2048@areca.com.tw>
Cc: martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, hch@infradead.org, colin.king@canonical.com
Subject: Re: [PATCH 0/3] scsi: arcmsr: Add driver parameter cmd_timeout for scsi command timeout setting
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1525675401.8876.9.camel@Centos6.3-64>
Date: Tue, 08 May 2018 01:41:59 -0400
In-Reply-To: <1525675401.8876.9.camel@Centos6.3-64> (Ching Huang's message of
        "Mon, 07 May 2018 14:43:21 +0800")
Message-ID: <yq1in7ywvo8.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8886 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=796
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805080055
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Ching,

> 1. Add driver parameter cmd_timeout, default value is ARCMSR_DEFAULT_TIMEOUT.
> 2. Add slave_configure callback function to set device command timeout value.
> 3. Update driver version to v1.40.00.06-20180504.

I am not so keen on arcmsr overriding the timeout set by the admin or
application.

Also, instead of introducing this module parameter, why not simply ask
the user to change rq_timeout?

-- 
Martin K. Petersen	Oracle Linux Engineering
