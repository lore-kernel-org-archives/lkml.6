Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbeDJIoS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 04:44:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752474AbeDJIoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 04:44:17 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180403132713.cffx5mpfrnwuokeh@wfg-t540p.sh.intel.com>
References: <20180403132713.cffx5mpfrnwuokeh@wfg-t540p.sh.intel.com> <201804021242.NgXgixG7%fengguang.wu@intel.com> <152261524532.30503.16094079179209557382.stgit@warthog.procyon.org.uk> <18231.1522761410@warthog.procyon.org.uk>
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: dhowells@redhat.com, kbuild test robot <lkp@intel.com>,
        kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/45] C++: Set compilation as C++ for .c files
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19627.1523349854.1@warthog.procyon.org.uk>
Date: Tue, 10 Apr 2018 09:44:14 +0100
Message-ID: <19628.1523349854@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fengguang,

There's another kbuild test that's probably worth adding if you don't do it
already: create a c++ source file that just #includes all the exported UAPI
headers and then try to build it.  This should catch words like "private"
cropping up in structs.

Thanks,
David
