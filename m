Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeDLVVH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 17:21:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41270 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbeDLVVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 17:21:05 -0400
To: Jack Wang <jinpu.wang@profitbricks.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, elliott@hpe.com
Subject: Re: [PATCH v2] block: ratelimite pr_err on IO path
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1523524915-25170-1-git-send-email-jinpu.wangl@profitbricks.com>
Date: Thu, 12 Apr 2018 17:20:54 -0400
In-Reply-To: <1523524915-25170-1-git-send-email-jinpu.wangl@profitbricks.com>
        (Jack Wang's message of "Thu, 12 Apr 2018 11:21:55 +0200")
Message-ID: <yq1y3hsunnt.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8861 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=624
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804120202
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jack,

> +				pr_err_ratelimited("%s: ref tag error at location %llu (rcvd %u)\n",

I'm a bit concerned about dropping records of potential data loss.

Also, what are you doing that compels all these to be logged? This
should be a very rare occurrence.

-- 
Martin K. Petersen	Oracle Linux Engineering
