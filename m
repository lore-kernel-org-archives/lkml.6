Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeBWEKl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 23:10:41 -0500
Received: from namei.org ([65.99.196.166]:50386 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751296AbeBWEKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 23:10:40 -0500
Date: Fri, 23 Feb 2018 15:10:15 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Randy Dunlap <rdunlap@infradead.org>
cc: LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] integrity/security: fix digsig.c build error with header
 file
In-Reply-To: <b3b7eebb-0e9f-f175-94a8-379c5ddcaa86@infradead.org>
Message-ID: <alpine.LRH.2.21.1802231509460.4713@namei.org>
References: <b3b7eebb-0e9f-f175-94a8-379c5ddcaa86@infradead.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2018, Randy Dunlap wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> security/integrity/digsig.c has build errors on some $ARCH due to a
> missing header file, so add it.
> 
>   security/integrity/digsig.c:146:2: error: implicit declaration of function 'vfree' [-Werror=implicit-function-declaration]
> 
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: linux-integrity@vger.kernel.org
> Link: http://kisskb.ellerman.id.au/kisskb/head/13396/
> ---
>  security/integrity/digsig.c |    1 +
>  1 file changed, 1 insertion(+)

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v4.16-rc3




-- 
James Morris
<jmorris@namei.org>
