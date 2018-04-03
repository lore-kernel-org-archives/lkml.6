Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932247AbeDCNQ6 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 09:16:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932183AbeDCNQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 09:16:57 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <201804021242.NgXgixG7%fengguang.wu@intel.com>
References: <201804021242.NgXgixG7%fengguang.wu@intel.com> <152261524532.30503.16094079179209557382.stgit@warthog.procyon.org.uk>
To: kbuild test robot <lkp@intel.com>
Cc: dhowells@redhat.com, kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/45] C++: Set compilation as C++ for .c files
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18230.1522761410.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date: Tue, 03 Apr 2018 14:16:50 +0100
Message-ID: <18231.1522761410@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild test robot <lkp@intel.com> wrote:

>    scripts/Makefile.kasan:17: Cannot use CONFIG_KASAN: -fsanitize=kernel-address is not supported by compiler
>    cc1: warning: command line option '-fno-rtti' is valid for C++/ObjC++ but not for C
>    cc1: warning: command line option '-fpermissive' is valid for C++/ObjC++ but not for C

It would need to use g++-8 to compile it ;-)

David
