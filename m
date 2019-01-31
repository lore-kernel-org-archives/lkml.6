Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE421C282C7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4C42087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfAaLFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:05:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55108 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726434AbfAaLFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:05:01 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0VB09VJ046911
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 06:05:00 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qbxr9kb37-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 06:04:51 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 31 Jan 2019 11:04:35 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Jan 2019 11:04:32 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0VB4VUE7537112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 11:04:31 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EC2F11C05B;
        Thu, 31 Jan 2019 11:04:31 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD04111C054;
        Thu, 31 Jan 2019 11:04:30 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 31 Jan 2019 11:04:30 +0000 (GMT)
Date:   Thu, 31 Jan 2019 13:04:29 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] docs/core-api/mm: fix return value descriptions
References: <1547985697-24588-1-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547985697-24588-1-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19013111-0008-0000-0000-000002B94618
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013111-0009-0000-0000-000022254859
Message-Id: <20190131110428.GJ28876@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments on these?

On Sun, Jan 20, 2019 at 02:01:34PM +0200, Mike Rapoport wrote:
> Many kernel-doc comments referenced by Documentation/core-api/mm-api.rst
> have the return value descriptions misformatted or lack it completely. This
> makes kernel-doc script unhappy and produces more than 100 warnings when
> running 
> 
> 	make htmldocs V=1
> 
> These patches fix the formatting of present return value descriptions and
> add some new ones.
> 
> Side note:
> ----------
> I've noticed that kernel-doc produces
> 
> 	warning: contents before sections
> 
> when it is parsing description of a function that has no parameters, but
> does have a return value, i.e.
> 
> 	unsigned long nr_free_buffer_pages(void)
> 
> As far as I can tell, the generated html is ok no matter if the detailed
> description present before 'the sections', so probably this warning is not
> really needed?
> 
> Mike Rapoport (3):
>   docs/mm: vmalloc: re-indent kernel-doc comemnts
>   docs/core-api/mm: fix user memory accessors formatting
>   docs/core-api/mm: fix return value descriptions in mm/
> 
>  arch/x86/include/asm/uaccess.h |  24 +--
>  arch/x86/lib/usercopy_32.c     |   8 +-
>  mm/dmapool.c                   |  13 +-
>  mm/filemap.c                   |  73 ++++++--
>  mm/memory.c                    |  26 ++-
>  mm/mempool.c                   |   8 +
>  mm/page-writeback.c            |  24 ++-
>  mm/page_alloc.c                |  24 ++-
>  mm/readahead.c                 |   2 +
>  mm/slab.c                      |  14 ++
>  mm/slab_common.c               |   6 +
>  mm/truncate.c                  |   6 +-
>  mm/util.c                      |  37 ++--
>  mm/vmalloc.c                   | 394 ++++++++++++++++++++++-------------------
>  14 files changed, 409 insertions(+), 250 deletions(-)
> 
> -- 
> 2.7.4
> 

-- 
Sincerely yours,
Mike.

