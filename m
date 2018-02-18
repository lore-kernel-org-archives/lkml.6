Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751944AbeBRXs2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 18:48:28 -0500
Received: from ms.lwn.net ([45.79.88.28]:52152 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751733AbeBRXs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 18:48:27 -0500
Date: Sun, 18 Feb 2018 16:48:05 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Markus Heiser <markus.heiser@darmarit.de>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: kernel_doc: fixup reporting of function
 identifiers
Message-ID: <20180218164805.2cf46459@lwn.net>
In-Reply-To: <17062CC8-55BF-423B-A4F5-726291417D21@darmarit.de>
References: <1518521506-6770-1-git-send-email-rppt@linux.vnet.ibm.com>
        <20180216075642.2e56eb51@lwn.net>
        <17062CC8-55BF-423B-A4F5-726291417D21@darmarit.de>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2018 17:36:07 +0100
Markus Heiser <markus.heiser@darmarit.de> wrote:

> > So let me channel akpm here and ask: what are the user-visible effects of
> > this problem?  I ask because applying it doesn't make any difference in
> > the "make htmldocs" output here.  So I don't understand why you're
> > wanting to make this change.  
> 
> Use kernel-doc -v and take a look on the info-messages.
> 
> In Documentation/doc-guide/kernel-doc we recommend to use
> 
> /**
>  * foo() - lorem ipsum
> 
> to tag functions, but if you do so, the info message is broken,
> the function name is missed at the end of the message:
> 
>  ../test123.c:2: info: Scanning doc for  

OK, so I guess that message is the only effect of this bug.  Oh well,
I'll go ahead and apply the patch, thanks.

jon
