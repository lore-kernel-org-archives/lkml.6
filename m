Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032810AbeBON3C (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 08:29:02 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54414 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032301AbeBON3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 08:29:00 -0500
X-Google-Smtp-Source: AH8x227ZPdDfjk4IXudKxtDsF7DlD9Lc39PMnWqzjTXBjokrudpYs8ctTVZysuUYfMG5ty3YQb4vzsbI7C6oawVZVyg=
MIME-Version: 1.0
In-Reply-To: <20180215105510.5md37yoqij2f663k@suse.de>
References: <20180214163343.21234-1-pasha.tatashin@oracle.com>
 <20180214163343.21234-2-pasha.tatashin@oracle.com> <20180215105510.5md37yoqij2f663k@suse.de>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 15 Feb 2018 08:20:18 -0500
X-Gmail-Original-Message-ID: <CAOAebxs3Lch0ZQ6h8jSVqHMpLxfUHv-y4rkJztPziFgm2VfH0g@mail.gmail.com>
Message-ID: <CAOAebxs3Lch0ZQ6h8jSVqHMpLxfUHv-y4rkJztPziFgm2VfH0g@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] mm: initialize pages on demand during boot
To: Mel Gorman <mgorman@suse.de>
Cc: Steve Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>, m.mizuma@jp.fujitsu.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        baiyaowei@cmss.chinamobile.com, Wei Yang <richard.weiyang@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Miles Chen <miles.chen@mediatek.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8805 signatures=668671
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=8 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=898
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802150168
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Mel!

Pavel

On Thu, Feb 15, 2018 at 5:55 AM, Mel Gorman <mgorman@suse.de> wrote:
> On Wed, Feb 14, 2018 at 11:33:43AM -0500, Pavel Tatashin wrote:
>> Deferred page initialization allows the boot cpu to initialize a small
>> subset of the system's pages early in boot, with other cpus doing the rest
>> later on.
>>
>
> Bit late to the game but
>
> Acked-by: Mel Gorman <mgorman@suse.de>
>
> --
> Mel Gorman
> SUSE Labs
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
