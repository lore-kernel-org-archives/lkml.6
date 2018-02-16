Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034605AbeBPO4q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 09:56:46 -0500
Received: from ms.lwn.net ([45.79.88.28]:44110 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033485AbeBPO4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 09:56:45 -0500
Date: Fri, 16 Feb 2018 07:56:42 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: kernel_doc: fixup reporting of function
 identifiers
Message-ID: <20180216075642.2e56eb51@lwn.net>
In-Reply-To: <1518521506-6770-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1518521506-6770-1-git-send-email-rppt@linux.vnet.ibm.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2018 13:31:46 +0200
Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:

> When function description includes brackets after the function name as
> suggested by Documentation/doc-guide/kernel-doc, the kernel-doc script
> omits the function name from "Scanning doc for" report.
> Extending match for identifier name with optional brackets fixes this
> issue.

So let me channel akpm here and ask: what are the user-visible effects of
this problem?  I ask because applying it doesn't make any difference in
the "make htmldocs" output here.  So I don't understand why you're
wanting to make this change.

Thanks,

jon
