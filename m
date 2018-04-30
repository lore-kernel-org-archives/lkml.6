Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754548AbeD3PCc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:02:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753691AbeD3PCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:02:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8786C22B37
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 30 Apr 2018 12:02:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: fix spelling mistake: "builid" -> "buildid"
Message-ID: <20180430150228.GB3557@kernel.org>
References: <20180427193158.17932-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427193158.17932-1-colin.king@canonical.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 27, 2018 at 08:31:58PM +0100, Colin King escreveu:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in error message text

Thanks, applied.

- Arnaldo
