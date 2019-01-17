Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAC8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346E620855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfAQM7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:59:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725928AbfAQM7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:59:12 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0HCwegc076596
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 07:59:10 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q2qqeptwe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 07:59:10 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 17 Jan 2019 12:59:09 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Jan 2019 12:59:06 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0HCx5rW6881434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Jan 2019 12:59:05 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18F08B2066;
        Thu, 17 Jan 2019 12:59:05 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBC20B2065;
        Thu, 17 Jan 2019 12:59:04 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.192.5])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 17 Jan 2019 12:59:04 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9313F16C618A; Thu, 17 Jan 2019 04:59:04 -0800 (PST)
Date:   Thu, 17 Jan 2019 04:59:04 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [patch 2/3] perf/hw_breakpoints: Convert to SPDX license
 identifier
Reply-To: paulmck@linux.ibm.com
References: <20190116111058.444514201@linutronix.de>
 <20190116111308.105855650@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116111308.105855650@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19011712-0064-0000-0000-000003982E79
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010423; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000275; SDB=6.01147771; UDB=6.00597908; IPR=6.00928069;
 MB=3.00025172; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-17 12:59:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011712-0065-0000-0000-00003C11D4F0
Message-Id: <20190117125904.GA5853@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 12:11:00PM +0100, Thomas Gleixner wrote:
> Replace the license boiler plate with a SPDX license identifier.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>

For both of the ones I am CCed on:

Acked-by: Paul McKenney <paulmck@linux.ibm.com>

> ---
>  kernel/events/hw_breakpoint.c |   15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -1,18 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> - *
>   * Copyright (C) 2007 Alan Stern
>   * Copyright (C) IBM Corporation, 2009
>   * Copyright (C) 2009, Frederic Weisbecker <fweisbec@gmail.com>
> 
> 

