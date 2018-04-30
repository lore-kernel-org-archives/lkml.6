Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754690AbeD3P3S (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:29:18 -0400
Received: from one.firstfloor.org ([193.170.194.197]:47718 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754012AbeD3P3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:29:17 -0400
Date: Mon, 30 Apr 2018 08:29:14 -0700
From: Andi Kleen <andi@firstfloor.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Colin King <colin.king@canonical.com>, Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <andi@firstfloor.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] perf vendor events: fix spelling mistake: "alloacated"
 -> "allocated"
Message-ID: <20180430152914.q26ehqszf7la3n3p@two.firstfloor.org>
References: <20180427185206.16347-1-colin.king@canonical.com>
 <20180430135256.GA3557@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430135256.GA3557@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 10:52:56AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Apr 27, 2018 at 07:52:06PM +0100, Colin King escreveu:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Trivial fix to spelling mistakes in json text strings
> 
> These files are generated from other files, so any future update to them
> will bring back the spelling mistakes, so, as Andi pointed out
> previously, we better fix the spellings in the original files,
> maintained by Intel.

Thanks. I forwarded to the right people.
-Andi
