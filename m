Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeBZTUX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 14:20:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751554AbeBZTUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 14:20:22 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D3F21719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 26 Feb 2018 16:20:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: kan.liang@intel.com
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf top: Fix annoying fallback message on older kernel
Message-ID: <20180226192003.GD4098@kernel.org>
References: <1519669030-176549-1-git-send-email-kan.liang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519669030-176549-1-git-send-email-kan.liang@intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 26, 2018 at 10:17:10AM -0800, kan.liang@intel.com escreveu:
> The fallback message is not critical message for end users. Turning it
> to debug message which is printed when running with -vv.
 
> Fixes: ebebbf082357 ("perf top: Switch default mode to overwrite mode")
> Reported-by: Ingo Molnar <mingo@kernel.org>

Thanks, applied.

- Arnaldo
