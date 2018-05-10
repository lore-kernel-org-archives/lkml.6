Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757467AbeEJSdj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:33:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757305AbeEJSdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:33:38 -0400
Date: Thu, 10 May 2018 15:33:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf buildid-cache: Warn --purge-all failures
Message-ID: <20180510183334.GC4311@kernel.org>
References: <20180510102808.5fcc479ccda0dd0eb08b7383@kernel.org>
 <20180510043651.12189-1-ravi.bangoria@linux.ibm.com>
 <20180511003752.7790aac3b7967f454fdd0c7f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511003752.7790aac3b7967f454fdd0c7f@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 11, 2018 at 12:37:52AM +0900, Masami Hiramatsu escreveu:
> On Thu, 10 May 2018 10:06:51 +0530
> Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:
> 
> > Warn perf buildid-cache --purge-all failures in non verbose mode.
> > Ex,
> > 
> >   $ sudo chown root:root /home/ravi/.debug -R
> >   $ sudo chmod 700 /home/ravi/.debug/ -R
> >   $ ./perf buildid-cache -P
> >     Couldn't remove some caches. Error: Permission denied.
> > 
> > Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> 
> This looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Applied to perf/core,

Thanks,

- Arnaldo
