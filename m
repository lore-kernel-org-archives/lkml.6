Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751859AbeBIK55 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 05:57:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751253AbeBIK5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 05:57:53 -0500
Date: Fri, 9 Feb 2018 12:57:37 +0200
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/zpool: zpool_evictable: fix mismatch in parameter
 name and kernel-doc
References: <1518116984-21141-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1a8a3fb7-3061-d9e7-a42c-53ae96c8ca29@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a8a3fb7-3061-d9e7-a42c-53ae96c8ca29@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18020910-0008-0000-0000-000004CB1FAC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020910-0009-0000-0000-00001E5ED6C8
Message-Id: <20180209105736.GA2044@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802090140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 11:17:33AM -0800, Randy Dunlap wrote:
> On 02/08/2018 11:09 AM, Mike Rapoport wrote:
> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > ---
> >  mm/zpool.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/zpool.c b/mm/zpool.c
> > index f8cb83e7699b..9d53a1ef8f1e 100644
> > --- a/mm/zpool.c
> > +++ b/mm/zpool.c
> > @@ -360,7 +360,7 @@ u64 zpool_get_total_size(struct zpool *zpool)
> >  
> >  /**
> >   * zpool_evictable() - Test if zpool is potentially evictable
> > - * @pool	The zpool to test
> > + * @zpool	The zpool to test
> 
>   + * @zpool:	The zpool to test
 
Thanks!

> >   *
> >   * Zpool is only potentially evictable when it's created with struct
> >   * zpool_ops.evict and its driver implements struct zpool_driver.shrink.
> > 
> 
> 
> -- 
> ~Randy
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
> 

-- 
Sincerely yours,
Mike.
