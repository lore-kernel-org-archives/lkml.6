Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934511AbeEILzm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:55:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934272AbeEILzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:55:40 -0400
Date: Wed, 9 May 2018 08:55:33 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 10/18] rcu: rcupdate.h: get rid of Sphinx warnings at
 rcu_pointer_handoff()
Message-ID: <20180509085533.54951174@vento.lan>
In-Reply-To: <20180507142322.GW26088@linux.vnet.ibm.com>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
        <a87d742e81124ddfeaa5b83daf10c91758c1b025.1525684985.git.mchehab+samsung@kernel.org>
        <20180507142322.GW26088@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 7 May 2018 07:23:22 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> escreveu:

> On Mon, May 07, 2018 at 06:35:46AM -0300, Mauro Carvalho Chehab wrote:
> > The code example at rcupdate.h currently produce lots of warnings:
> > 
> > 	./include/linux/rcupdate.h:572: WARNING: Unexpected indentation.
> > 	./include/linux/rcupdate.h:576: WARNING: Unexpected indentation.
> > 	./include/linux/rcupdate.h:580: WARNING: Block quote ends without a blank line; unexpected unindent.
> > 	./include/linux/rcupdate.h:582: WARNING: Block quote ends without a blank line; unexpected unindent.
> > 	./include/linux/rcupdate.h:582: WARNING: Inline literal start-string without end-string.
> > 
> > Change it to a code-block.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>  
> 
> Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> If you don't tell me otherwise, I will assume that you are pushing this.
> If you would rather that I take it, please let me know!

Hi Paul,

Feel free to merge it via your tree. It seems that Jon prefers to have
code changes merged via the usual maintainers.

Regards,
Mauro
