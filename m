Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbeDJQyx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 12:54:53 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47298 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeDJQyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 12:54:52 -0400
Subject: Re: [PATCH v3 2/3] mm/shmem: update file sealing comments and file
 checking
To: Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180409230505.18953-1-mike.kravetz@oracle.com>
 <20180409230505.18953-3-mike.kravetz@oracle.com>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <e710688c-1086-f9e4-6589-e4b5641ae30c@oracle.com>
Date: Tue, 10 Apr 2018 10:54:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180409230505.18953-3-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8859 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804100161
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2018 05:05 PM, Mike Kravetz wrote:
> In preparation for memfd code restucture, update comments dealing
> with file sealing to indicate that tmpfs and hugetlbfs are the
> supported filesystems.  Also, change file pointer checks in
> memfd_file_seals_ptr to use defined routines instead of directly
> referencing file_operation structs.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   mm/shmem.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)
>

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
