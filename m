Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbeEUXlh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 19:41:37 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:47010 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbeEUXle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 19:41:34 -0400
X-Google-Smtp-Source: AB8JxZoTSD9F8jtTQhyXRVlMJ8hJ9h35zBwHgJbBsmBMtAZAxGt8vBa4nID+XgFV+Abn4bbGl82Ktg==
Date: Mon, 21 May 2018 16:41:33 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH v3 2/4] rcu: Cleanup the variables used to request a new
 grace period
Message-ID: <20180521234133.GB40541@joelaf.mtv.corp.google.com>
References: <20180521044220.123933-1-joel@joelfernandes.org>
 <20180521044220.123933-3-joel@joelfernandes.org>
 <20180521233934.GL3803@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521233934.GL3803@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 04:39:34PM -0700, Paul E. McKenney wrote:
> On Sun, May 20, 2018 at 09:42:18PM -0700, Joel Fernandes wrote:
> > The 'c' variable was used previously to store the grace period that is
> > being requested. However it is not very meaningful since the gp_seq
> > conversions. This patch replaces it with gp_seq_req indicating that
> > this is the grace period that was requested. Also updating tracing with
> > the new name.
> > 
> > Previous patch discussion is at:
> > https://patchwork.kernel.org/patch/10396579/
> > 
> > Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
> 
> Very good, I have queued this for review and testing.  I reworked the
> commit log a bit, please see below for the version that I have queued.

Yes, commit log looks good, thanks for queuing it!

thanks,

 - Joel
 
