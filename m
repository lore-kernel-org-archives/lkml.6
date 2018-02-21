Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754228AbeBUMZK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 07:25:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752618AbeBUMZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 07:25:08 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F1A2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 21 Feb 2018 09:25:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Sangwon Hong <qpakzk@gmail.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, Taeung Song <treeze.taeung@gmail.com>,
        kernel-team@lge.com
Subject: Re: [PATCH] perf kallsyms: Fix the usage on the man page
Message-ID: <20180221122505.GA24416@kernel.org>
References: <1518377864-20353-1-git-send-email-qpakzk@gmail.com>
 <20180212015021.GB31513@sejong>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212015021.GB31513@sejong>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 12, 2018 at 10:50:21AM +0900, Namhyung Kim escreveu:
> On Mon, Feb 12, 2018 at 04:37:44AM +0900, Sangwon Hong wrote:
> > First, all man pages highlight only perf and subcommands except perf
> > kallsyms, which includes the full usage. Fix it for commands to monopolize
> > underlines.
> > 
> > Second, options can skip when executing perf kallsyms, so add square
> > brackets between <option>.
> > 
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Taeung Song <treeze.taeung@gmail.com>
> > Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo
