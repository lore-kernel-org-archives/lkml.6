Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbeBWPio (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:38:44 -0500
Received: from www.llwyncelyn.cymru ([82.70.14.225]:55552 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751405AbeBWPim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:38:42 -0500
Date: Fri, 23 Feb 2018 15:38:07 +0000
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Nikolay Borisov <nborisov@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        mathieu.desnoyers@efficios.com, Peter Zijlstra <peterz@infradead.org>,
        parri.andrea@gmail.com
Subject: Re: Reasoning about memory ordering
Message-ID: <20180223153807.64666cfe@alans-desktop>
In-Reply-To: <0db16ef6-c805-b1f6-527f-8fec149e3df5@suse.com>
References: <0db16ef6-c805-b1f6-527f-8fec149e3df5@suse.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Given this is the current state of the code (it's part of btrfs) I believe
> the following could/should be done: 

Is there benchmarking data to show that a custom lock is justified
(especiaally given it's going to mean btrfs and rtlinux don't play
together nicely since it won't be able to see the mutex lock and do
priority boosting ?)

Alan
