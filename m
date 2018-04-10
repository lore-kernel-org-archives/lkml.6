Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbeDJHPQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 03:15:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36822 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751920AbeDJHPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 03:15:14 -0400
Date: Tue, 10 Apr 2018 10:14:32 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: akpm@linux-foundation.org, tglx@linutronix.de, keescook@chromium.org,
        pombredanne@nexb.com, bp@suse.de, abbotti@mev.co.uk,
        rdunlap@infradead.org, bhe@redhat.com, yamada.masahiro@socionext.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux/kernel.h: Fix minor type in comment
Message-ID: <20180410071432.GA5093@yuvallap>
References: <20180410065734.4883-1-yuval.shaia@oracle.com>
 <20180410070626.u27zsu2kgkojax5l@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410070626.u27zsu2kgkojax5l@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8858 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804100074
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 09:06:26AM +0200, Ingo Molnar wrote:
> 
> * Yuval Shaia <yuval.shaia@oracle.com> wrote:
> 
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > ---
> >  include/linux/kernel.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > index ce51455e2adf..a5b4ba3bdb61 100644
> > --- a/include/linux/kernel.h
> > +++ b/include/linux/kernel.h
> > @@ -651,7 +651,7 @@ do {									\
> >   * your code. (Extra memory is used for special buffers that are
> >   * allocated when trace_printk() is used.)
> >   *
> > - * A little optization trick is done here. If there's only one
> > + * A little optimization trick is done here. If there's only one
> >   * argument, there's no need to scan the string for printf formats.
> >   * The trace_puts() will suffice. But how can we take advantage of
> >   * using trace_puts() when trace_printk() has only one argument?
> 
> Please also fix the typo in the title ;-)

Sorry, fixed that but forgot to amend :)

Will post v2 in few seconds.

> 
> Thanks,
> 
> 	Ingo
