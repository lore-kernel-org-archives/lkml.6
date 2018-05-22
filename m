Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751753AbeEVPSb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751566AbeEVPS2 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:18:28 -0400
Date: Tue, 22 May 2018 12:18:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf annotate: Show group event string for stdio
Message-ID: <20180522151825.GC25467@kernel.org>
References: <1526989115-14435-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526989115-14435-1-git-send-email-yao.jin@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 22, 2018 at 07:38:35PM +0800, Jin Yao escreveu:
> When we enable the group, for tui/stdio2, the output first
> line includes the group event string. While for stdio,
> it will show only one event.

Thanks, applied.

- Arnaldo
