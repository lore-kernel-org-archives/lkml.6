Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbeDDH3S (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 03:29:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50474 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbeDDH3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 03:29:17 -0400
Subject: Re: [PATCH 2/2] kfree_rcu() should use kfree_bulk() interface
To: Christopher Lameter <cl@linux.com>
Cc: linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        joe@perches.com, willy@infradead.org, brouer@redhat.com,
        linux-mm@kvack.org
References: <1522647064-27167-1-git-send-email-rao.shoaib@oracle.com>
 <1522647064-27167-3-git-send-email-rao.shoaib@oracle.com>
 <alpine.DEB.2.20.1804021217070.24404@nuc-kabylake>
From: Rao Shoaib <rao.shoaib@oracle.com>
Message-ID: <d6a58a0d-be8b-44e9-29c7-ef2588afefbf@oracle.com>
Date: Wed, 4 Apr 2018 00:28:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1804021217070.24404@nuc-kabylake>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8852 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=808
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804040075
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/02/2018 10:20 AM, Christopher Lameter wrote:
> On Sun, 1 Apr 2018, rao.shoaib@oracle.com wrote:
>
>> kfree_rcu() should use the new kfree_bulk() interface for freeing
>> rcu structures as it is more efficient.
> It would be even better if this approach could also use
>
> 	kmem_cache_free_bulk()
>
> or
>
> 	kfree_bulk()
Sorry I do not understand your comment. The patch is using kfree_bulk() 
which is an inline function.

Shoaib
