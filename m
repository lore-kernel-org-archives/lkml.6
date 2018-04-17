Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753128AbeDQXku (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 19:40:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51172 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeDQXks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 19:40:48 -0400
Subject: Re: [PATCH v4 2/3] mm/shmem: update file sealing comments and file
 checking
To: Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180415182119.4517-1-mike.kravetz@oracle.com>
 <20180415182119.4517-3-mike.kravetz@oracle.com>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <4863ad78-4b1e-33bf-c38a-b412e5330dd2@oracle.com>
Date: Tue, 17 Apr 2018 17:40:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180415182119.4517-3-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8866 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804170204
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/15/2018 12:21 PM, Mike Kravetz wrote:
> In preparation for memfd code restructure, update comments,
> definitions and function names dealing with file sealing to
> indicate that tmpfs and hugetlbfs are the supported filesystems.
> Also, change file pointer checks in memfd_file_seals_ptr
> to use defined interfaces instead of directly referencing
> file_operation structs.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   mm/shmem.c | 50 ++++++++++++++++++++++++++------------------------
>   1 file changed, 26 insertions(+), 24 deletions(-)

Looks good.

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
