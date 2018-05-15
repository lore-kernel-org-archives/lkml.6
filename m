Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbeEOAl4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 20:41:56 -0400
Received: from mail-pl0-f41.google.com ([209.85.160.41]:34211 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbeEOAly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 20:41:54 -0400
X-Google-Smtp-Source: AB8JxZq1x5QtRBzhOpcLJKeBTgaX1r8XQHzyS61GRXGt7rWTGPIIa5XCfsPmYgaZoLnZ4LkTK8fs2g==
Date: Mon, 14 May 2018 17:41:52 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH RFC 4/8] rcu: Get rid of old c variable from places in
 tree RCU
Message-ID: <20180515004152.GB209519@joelaf.mtv.corp.google.com>
References: <20180514031541.67247-1-joel@joelfernandes.org>
 <20180514031541.67247-5-joel@joelfernandes.org>
 <20180514175739.GB26088@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514175739.GB26088@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:57:39AM -0700, Paul E. McKenney wrote:
> On Sun, May 13, 2018 at 08:15:37PM -0700, Joel Fernandes (Google) wrote:
> > The 'c' variable was used previously to store the grace period
> > that is being requested. However it is not very meaningful for
> > a code reader, this patch replaces it with gp_seq_start indicating that
> 
> Good catch, but how about "gp_seq_req" instead of gp_seq_start?

Yes, that works as well and is also 2 character less. Will change it.

thanks,

- Joel
 
