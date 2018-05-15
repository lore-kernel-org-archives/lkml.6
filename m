Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeEOVdj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:33:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33652 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeEOVdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:33:38 -0400
X-Google-Smtp-Source: AB8JxZpdBUeU5+Xw58uFUjmtNo/tVHGsLDQvYE2MOmJW5+IY8KGESCwVBvzOtYw6gUMBR08h9Wkqd9yP8BRPCKiac+k=
MIME-Version: 1.0
References: <20180515175124.1770-1-pasha.tatashin@oracle.com> <20180515141240.c7587ed53a0ff32ff984e3d2@linux-foundation.org>
In-Reply-To: <20180515141240.c7587ed53a0ff32ff984e3d2@linux-foundation.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 15 May 2018 17:33:00 -0400
X-Gmail-Original-Message-ID: <CAGM2reaoLmTa6v5rsOHFwcBYuxYq0AEoOy8BJktWN-WibWoEVA@mail.gmail.com>
Message-ID: <CAGM2reaoLmTa6v5rsOHFwcBYuxYq0AEoOy8BJktWN-WibWoEVA@mail.gmail.com>
Subject: Re: [PATCH v5] mm: don't allow deferred pages with NEED_PER_CPU_KM
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        mgorman@techsingularity.net, mingo@kernel.org, peterz@infradead.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Dennis Zhou <dennisszhou@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8894 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=427
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805150210
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > My recent fix exposed this problem,

> "my recent fix" isn't very useful.  I changed this to identify
> c9e97a1997 ("mm: initialize pages on demand during boot"), yes?

Yes, thank you.

Pavel
