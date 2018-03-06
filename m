Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753281AbeCFHwb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 02:52:31 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35082 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750801AbeCFHw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 02:52:29 -0500
X-Google-Smtp-Source: AG47ELtwoqUV29Fp63CmP7xETm/OAaxMHfCXt9anwnhNYvOvqCz0whpApYOJc7RMOggovQ1u15oFPw==
Date: Tue, 6 Mar 2018 15:36:58 +0800
From: Wang YanQing <udknight@gmail.com>
To: acme@kernel.org
Cc: jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf report: Provide libtraceevent with a kernel symbol
 resolver
Message-ID: <20180306073658.GA7964@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>, acme@kernel.org,
        jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org
References: <20180115044732.GB20373@udknight>
 <20180208122031.GA30130@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208122031.GA30130@krava>
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 01:20:31PM +0100, Jiri Olsa wrote:
> On Mon, Jan 15, 2018 at 12:47:32PM +0800, Wang YanQing wrote:
> > So that beautifiers wanting to resolve kernel function addresses to
> > names can do its work, and when we use "perf report" for output of
> > "perf kmem record", we will get kernel symbol output.
> > 
> > Signed-off-by: Wang YanQing <udknight@gmail.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Hi! Arnaldo Carvalho de Melo

What is the status of this patch now?
Does the patch sanked to the bottom of your mailbox?

Thanks!
