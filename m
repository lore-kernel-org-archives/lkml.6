Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753242AbeCVJgK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 05:36:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751817AbeCVJgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 05:36:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA1D20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 22 Mar 2018 06:35:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Petr Machata <petrm@mellanox.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf: python: Reference Py_None before returning it
Message-ID: <20180322093559.GB4229@kernel.org>
References: <b1e565ecccf68064d8d54f37db5d028dda8fa522.1521675563.git.petrm@mellanox.com>
 <20180322091448.GA2972@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322091448.GA2972@krava>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 22, 2018 at 10:14:48AM +0100, Jiri Olsa escreveu:
> On Thu, Mar 22, 2018 at 12:57:32AM +0100, Petr Machata wrote:
> > Python None objects are handled just like all the other objects with
> > respect to their reference counting. Before returning Py_None, its
> > reference count thus needs to be bumped.
> > 
> > Signed-off-by: Petr Machata <petrm@mellanox.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo
