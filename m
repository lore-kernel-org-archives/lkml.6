Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751358AbeCLItL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:49:11 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45600 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbeCLItK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:49:10 -0400
X-Google-Smtp-Source: AG47ELtjCqVdewK7Wjd1syb02ssLlj4M2g4qY1zX3qNsowvsWpKFUnZacYDLicwnP9rUus9kkWi+WA==
Date: Mon, 12 Mar 2018 09:49:06 +0100
From: Ingo Molnar <mingo@kernel.org>
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, Kan Liang <kan.liang@intel.com>
Subject: Re: [PATCH 1/4] perf/x86/intel: Add Tremont CPU PMU support
Message-ID: <20180312084906.ny2nfi5rrcnxs2ji@gmail.com>
References: <1519923967-3433-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519923967-3433-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* kan.liang@linux.intel.com <kan.liang@linux.intel.com> wrote:

> +	/*TODO: test Adaptive PEBS, no extra implementation needed */
> +		/*TODO: test PDIR fixed counter */
> +		/* TODO: OFFCORE_RESPONSE mask updates for 10nm convered IDI */
> +		/*TODO: implement topdown metrics, base metrics interface same as SNC */

Do you ever _read_ the comments you are writing?

NAK for this kind of inconsistent mess, and it's a repeat pattern - you really 
need to submit cleaner patches!

Thanks,

	Ingo
