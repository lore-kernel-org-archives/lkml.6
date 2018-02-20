Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeBTSlL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 13:41:11 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48172 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbeBTSlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 13:41:09 -0500
Subject: Re: [PATCH] rds: send: mark expected switch fall-through in
 rds_rm_size
To: David Miller <davem@davemloft.net>
Cc: gustavo@embeddedor.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org, garsilva@embeddedor.com
References: <20180219181020.GA19154@embeddedgus>
 <9b385269-7f13-983c-caf1-72e050acc6d9@oracle.com>
 <20180220.130157.1101637718168743475.davem@davemloft.net>
From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <8a877289-f88d-a268-cd33-550ab870c1f0@oracle.com>
Date: Tue, 20 Feb 2018 10:40:46 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220.130157.1101637718168743475.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8810 signatures=668675
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=867
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802200223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/2018 10:01 AM, David Miller wrote:
> From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
> Date: Tue, 20 Feb 2018 09:54:09 -0800
> 
>> So coverity greps for commet as "fall through" for
>> -Wimplicit-fallthrough build ?
> 
>  From what I understand, 'gcc' does in the latest versions.  Coverity
> might as well, I don't know.
> 
Good to know about 'gcc' adding such option. Thanks !!
