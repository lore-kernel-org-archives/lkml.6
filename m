Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B45C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 08:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FACF20818
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 08:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfBII7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 03:59:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726896AbfBII7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 03:59:51 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x198wt2v006605
        for <linux-kernel@vger.kernel.org>; Sat, 9 Feb 2019 03:59:49 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qhur786jh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 03:59:49 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sat, 9 Feb 2019 08:59:48 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 9 Feb 2019 08:59:44 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x198xi4T63242430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 9 Feb 2019 08:59:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0344CA4062;
        Sat,  9 Feb 2019 08:59:44 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 672EAA405F;
        Sat,  9 Feb 2019 08:59:43 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.132])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  9 Feb 2019 08:59:43 +0000 (GMT)
Date:   Sat, 9 Feb 2019 10:59:41 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: update comments and kernel-doc
References: <1549626347-25461-1-git-send-email-rppt@linux.ibm.com>
 <20190208144047.66254b6d08edfea462e6466a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208144047.66254b6d08edfea462e6466a@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19020908-0008-0000-0000-000002BE604F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020908-0009-0000-0000-0000222A70B2
Message-Id: <20190209085941.GA13657@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-09_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=903 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902090067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 02:40:47PM -0800, Andrew Morton wrote:
> On Fri,  8 Feb 2019 13:45:47 +0200 Mike Rapoport <rppt@linux.ibm.com> wrote:
> 
> > * Remove comments mentioning bootmem
> > * Extend "DOC: memblock overview"
> > * Add kernel-doc comments for several more functions
> > 
> > ...
> >
> > @@ -1400,6 +1413,19 @@ phys_addr_t __init memblock_phys_alloc_range(phys_addr_t size,
> >  	return memblock_alloc_range_nid(size, align, start, end, NUMA_NO_NODE);
> >  }
> >  
> > +/**
> > + * memblock_phys_alloc_range - allocate a memory block from specified MUMA node
> > + * @size: size of memory block to be allocated in bytes
> > + * @align: alignment of the region and block's size
> > + * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
> > + *
> > + * Allocates memory block from the specified NUMA node. If the node
> > + * has no available memory, attempts to allocated from any node in the
> > + * system.
> > + *
> > + * Return: physical address of the allocated memory block on success,
> > + * %0 on failure.
> > + */
> >  phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid)
> >  {
> >  	return memblock_alloc_range_nid(size, align, 0,
> 
> copy-n-paste!

Oops, thanks for the fix!
 
> --- a/mm/memblock.c~memblock-update-comments-and-kernel-doc-fix
> +++ a/mm/memblock.c
> @@ -1414,7 +1414,7 @@ phys_addr_t __init memblock_phys_alloc_r
>  }
>  
>  /**
> - * memblock_phys_alloc_range - allocate a memory block from specified MUMA node
> + * memblock_phys_alloc_try_nid - allocate a memory block from specified MUMA node
>   * @size: size of memory block to be allocated in bytes
>   * @align: alignment of the region and block's size
>   * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
> 

-- 
Sincerely yours,
Mike.

