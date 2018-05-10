Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757220AbeEJL4W (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 07:56:22 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41252 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757141AbeEJL4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 07:56:21 -0400
X-Google-Smtp-Source: AB8JxZrgdknAvj6whQgA2DVEpifMKmQV2Fhyad47F6HwYA0hPdTiWXVXb5cH+2FP/Av5dpaEEAWPRKkHWwtm9aMsifg=
MIME-Version: 1.0
References: <20180509191713.23794-1-pasha.tatashin@oracle.com> <20180509210920.GZ32366@dhcp22.suse.cz>
In-Reply-To: <20180509210920.GZ32366@dhcp22.suse.cz>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 10 May 2018 11:55:42 +0000
X-Gmail-Original-Message-ID: <CAGM2reZEK3-sRwCF4Zuyzk789zp1ghA0D4GQYqcHV4npNPPJVA@mail.gmail.com>
Message-ID: <CAGM2reZEK3-sRwCF4Zuyzk789zp1ghA0D4GQYqcHV4npNPPJVA@mail.gmail.com>
Subject: Re: [PATCH] mm: allow deferred page init for vmemmap only
To: mhocko@kernel.org
Cc: Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        Linux Memory Management List <linux-mm@kvack.org>,
        mgorman@techsingularity.net, mingo@kernel.org, peterz@infradead.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Dennis Zhou <dennisszhou@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8888 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=778
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805100118
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This doesn't really explain why CONFIG_SPARSMEM or DISCONTIG has the
> problem.

Hi Michal,

Thank you for reviewing this patch. I sent out a version two of this patch,
with expanded explanation of the problem.

Thank you,
Pavel
