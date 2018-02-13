Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933792AbeBMIci (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 03:32:38 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:55047 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933631AbeBMIcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 03:32:36 -0500
X-Google-Smtp-Source: AH8x224XJl7eMdM/kopx4KoBdPFtZVCreI/Elfr7qB0KqcW1gO1rJkGfJ7cyzHj2y49OwhBxqu8lQQ==
Date: Tue, 13 Feb 2018 09:32:31 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v2] tools/memory-model: Make compat with herd7 7.47 ("-"
 -> "_")
Message-ID: <20180213083231.armedi33dpymnrld@gmail.com>
References: <20180209141832.GA17505@linux.vnet.ibm.com>
 <df87e89b-7fbe-37a7-42cb-62df74591df4@gmail.com>
 <a788e08d-eccb-0aec-6aa5-944e5321e5c6@gmail.com>
 <20180210010703.GE3617@linux.vnet.ibm.com>
 <20180211115148.iylaqk3f53f2vgf4@gmail.com>
 <20180213013803.GI3617@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213013803.GI3617@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> Cat-language code has used "-" as a word
> separator in names, and the model had previously had an odd mixture of
> "-" and "_".  Hence, the switch to the cat-language convention.
> 
> Of course, if underscore is strongly preferred, underscore does work,
> and it should be possible to move in that direction.

I'm fine with either of these variants, as long as it's consistent: the 
idiosynchratic seeming mixture of both '-' and '_' convention looked odd to me.

If '_' is also more compatible with installed versions of the language, then I'd 
go for that - but it's your call.

Thanks,

	Ingo
