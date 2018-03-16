Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753051AbeCPSQI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 14:16:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40074 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751607AbeCPSQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 14:16:06 -0400
Subject: Re: [RESEND PATCH v2] sched/fair: Remove check in idle_balance
 against migration_cost
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        steven.sistare@oracle.com, joelaf@google.com, jbacik@fb.com,
        juri.lelli@redhat.com, dhaval.giani@oracle.com, efault@gmx.de,
        riel@surriel.com
References: <1521052607-24622-1-git-send-email-rohit.k.jain@oracle.com>
 <20180316143550.GH4064@hirez.programming.kicks-ass.net>
 <48b63847-123c-6a28-d558-392b8122cd7e@oracle.com>
 <20180316174241.GB4043@hirez.programming.kicks-ass.net>
From: Rohit Jain <rohit.k.jain@oracle.com>
Message-ID: <00edde63-76fc-09c3-0a7f-24532426ed38@oracle.com>
Date: Fri, 16 Mar 2018 11:14:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316174241.GB4043@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8833 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803160153
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/16/2018 10:42 AM, Peter Zijlstra wrote:

<snip>
> You need to look at:
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/
>
> my queue.git is the sporadic push of my quilt tree on top of that.

Thanks found it! I will re-test and send v3 as needed.
