Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752552AbeEOAnx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 20:43:53 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45192 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752380AbeEOAnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 20:43:52 -0400
X-Google-Smtp-Source: AB8JxZquHzsmbdjOMW4R66O1nNZkQ6kTGnwDQGCFrk/nuDzhagczmWyubTF32Z2OSasyniVl6B1czw==
Date: Mon, 14 May 2018 17:43:51 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH RFC 3/8] rcu: Add back the cpuend tracepoint
Message-ID: <20180515004351.GD209519@joelaf.mtv.corp.google.com>
References: <20180514031541.67247-1-joel@joelfernandes.org>
 <20180514031541.67247-4-joel@joelfernandes.org>
 <20180514181227.GE26088@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514181227.GE26088@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 11:12:27AM -0700, Paul E. McKenney wrote:
> On Sun, May 13, 2018 at 08:15:36PM -0700, Joel Fernandes (Google) wrote:
> > Commit be4b8beed87d ("rcu: Move RCU's grace-period-change code to ->gp_seq")
> > removed the cpuend grace period trace point. This patch adds it back.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Good catch!!!  I queued this to be squashed into the offending commit,
> with attribution.

Cool, thanks!

- Joel
