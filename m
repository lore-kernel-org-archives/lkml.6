Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE4AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C331E20844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfBFT3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:29:46 -0500
Received: from smtprelay0026.hostedemail.com ([216.40.44.26]:42802 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726480AbfBFT3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:29:46 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 9190D180238B8;
        Wed,  6 Feb 2019 19:29:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: skirt98_3797ac201d462
X-Filterd-Recvd-Size: 1618
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 Feb 2019 19:29:41 +0000 (UTC)
Message-ID: <31c137d41ed955b09495241d918edaeae3462525.camel@perches.com>
Subject: Re: [PATCH tip/core/rcu 0/19] SPDX changes for v5.1
From:   Joe Perches <joe@perches.com>
To:     paulmck@linux.ibm.com, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Date:   Wed, 06 Feb 2019 11:29:40 -0800
In-Reply-To: <20190206131614.GA17320@linux.ibm.com>
References: <20190206131614.GA17320@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-02-06 at 05:16 -0800, Paul E. McKenney wrote:
> Hello!

Hi.

> This series makes SPDX and email-address changes to RCU source files.

.h files are supposed to use /* SPDX-License-Identifier: ... */

Documentation/process/license-rules.rst:      C source: // SPDX-License-Identifier: <SPDX License Expression>
Documentation/process/license-rules.rst:      C header: /* SPDX-License-Identifier: <SPDX License Expression> */
Documentation/process/license-rules.rst:      ASM:      /* SPDX-License-Identifier: <SPDX License Expression> */


