Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753313AbeDCTx1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 15:53:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52626 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752547AbeDCTxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 15:53:25 -0400
Subject: Re: [PATCH v3 0/4] Ktest: add email support
To: rostedt@goodmis.org
Cc: Dhaval Giani <dhaval.giani@oracle.com>, linux-kernel@vger.kernel.org,
        tim.tianyang.chen@alumni.upenn.edu
References: <1522094884-22718-1-git-send-email-tianyang.chen@oracle.com>
 <ba4461ff-57ea-0861-4aab-e704b549474f@oracle.com>
From: Tim Tianyang Chen <tianyang.chen@oracle.com>
Organization: Oracle Corporation
Message-ID: <26923e02-7eef-dc80-c9fc-7ecfa9842229@oracle.com>
Date: Tue, 3 Apr 2018 12:52:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ba4461ff-57ea-0861-4aab-e704b549474f@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8852 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=796
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804030193
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve, did you get a chance to take a look? cc'ing myself and a 
personal email. When I sent the patchset I forgot to include.

Tianyang

On 2018-03-26 04:08 PM, Tim Tianyang Chen wrote:

> This patch set will let users define a mailer, an email address and when to receive
> notifications during automated testings. Users need to setup the specified mailer
> prior to using this feature.
>
> Tim Tianyang Chen (4):
>    Ktest: add email support
>    Ktest: add SigInt handling
>    Ktest: use dodie for critical falures
>    Ktest: add email options to sample.config
>
>   ktest.pl    | 125 +++++++++++++++++++++++++++++++++++++++++++++---------------
>   sample.conf |  22 +++++++++++
>   2 files changed, 117 insertions(+), 30 deletions(-)
>
