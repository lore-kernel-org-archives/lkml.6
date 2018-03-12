Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbeCLHEk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 03:04:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33392 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeCLHEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 03:04:36 -0400
Subject: Re: [PATCH][rds-next] rds: make functions rds_info_from_znotifier and
 rds_message_zcopy_from_user static
From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
To: Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180311170340.27696-1-colin.king@canonical.com>
 <b693b404-3c66-5c45-4610-e119956c8dff@oracle.com>
Organization: Oracle Corporation
Message-ID: <046b2275-ba1f-3827-3664-b7c9553ffec3@oracle.com>
Date: Mon, 12 Mar 2018 00:04:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b693b404-3c66-5c45-4610-e119956c8dff@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8829 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=631
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803120084
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/18 11:54 PM, santosh.shilimkar@oracle.com wrote:
> On 3/11/18 10:03 AM, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Functions rds_info_from_znotifier and rds_message_zcopy_from_user are
>> local to the source and do not need to be in global scope, so make them
>> static.
>>
>> Cleans up sparse warnins:
>> net/rds/message.c:70:27: warning: symbol 'rds_info_from_znotifier' was
>> not declared. Should it be static?
>> net/rds/message.c:358:5: warning: symbol 'rds_message_zcopy_from_user'
>> was not declared. Should it be static?
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>   net/rds/message.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>

This was fixed by kbuild robot and the fix is already in net-next.

Regards,
Santosh
