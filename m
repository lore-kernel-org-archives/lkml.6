Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeCMBfu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 21:35:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751390AbeCMBft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 21:35:49 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9332173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 12 Mar 2018 22:35:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 11/13] perf bpf: Add helper header files
Message-ID: <20180313013529.GD10004@kernel.org>
References: <20180312094313.18738-1-jolsa@kernel.org>
 <20180312094313.18738-12-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312094313.18738-12-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 12, 2018 at 10:43:11AM +0100, Jiri Olsa escreveu:
> +#elif defined(__s390x__)
> +	#define bpf_target_s930x

    bpf_target_s390x

> +#elif defined(__aarch64__)
> +	#define bpf_target_arm64
> +#elif defined(__mips__)
> +	#define bpf_target_mips
> +#elif defined(__powerpc__)
> +	#define bpf_target_powerpc
> +#elif defined(__sparc__)
> +	#define bpf_target_sparc
> +#endif
> +#endif
