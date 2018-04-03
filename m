Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbeDCTz0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 15:55:26 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38676 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752863AbeDCTzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 15:55:24 -0400
Subject: Re: [PATCH v3 0/4] Ktest: add email support
To: Tim Tianyang Chen <tianyang.chen@oracle.com>, rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org, tim.tianyang.chen@alumni.upenn.edu
References: <1522094884-22718-1-git-send-email-tianyang.chen@oracle.com>
From: Dhaval Giani <dhaval.giani@oracle.com>
Message-ID: <ba4461ff-57ea-0861-4aab-e704b549474f@oracle.com>
Date: Tue, 3 Apr 2018 15:06:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1522094884-22718-1-git-send-email-tianyang.chen@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8852 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=886
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804030193
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-26 04:08 PM, Tim Tianyang Chen wrote:
> This patch set will let users define a mailer, an email address and when to receive
> notifications during automated testings. Users need to setup the specified mailer
> prior to using this feature.
> 
> Tim Tianyang Chen (4):
>   Ktest: add email support
>   Ktest: add SigInt handling
>   Ktest: use dodie for critical falures
>   Ktest: add email options to sample.config
> 
>  ktest.pl    | 125 +++++++++++++++++++++++++++++++++++++++++++++---------------
>  sample.conf |  22 +++++++++++
>  2 files changed, 117 insertions(+), 30 deletions(-)
> 

Steve,

Any thoughts?

Thanks!
Dhaval
