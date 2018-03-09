Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751247AbeCIPT4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 10:19:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751200AbeCIPTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 10:19:54 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAFB721771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 9 Mar 2018 12:19:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf report: Show zero counters as well in 'perf report
 --stat'
Message-ID: <20180309151951.GD8347@kernel.org>
References: <20180307152430.7e5h7e657b7bgd7q@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307152430.7e5h7e657b7bgd7q@gmail.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 07, 2018 at 04:24:30PM +0100, Ingo Molnar escreveu:
> 
> I had to check the output several times to ascertain that I'm not misreading the 
> output, that the field didn't change and that I didn't misremember the name. In 
> fact I had to look into the perf source to make sure that zero fields are indeed 
> not shown.

Thanks, applied.

- Arnaldo
