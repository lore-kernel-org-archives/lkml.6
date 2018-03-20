Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934547AbeCTAGl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 20:06:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33294 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933323AbeCTAGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 20:06:37 -0400
Date: Tue, 20 Mar 2018 08:06:33 +0800
From: Kim Phillips <kim.phillips@arm.com>
To: Martin Vuille <jpmv27@aim.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] perf unwind: Report error from dwfl_attach_state
Message-Id: <20180320080633.10e8414475a534ce9cf26c28@arm.com>
In-Reply-To: <20180318175053.4222-1-jpmv27@aim.com>
References: <20180318175053.4222-1-jpmv27@aim.com>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Mar 2018 13:50:53 -0400
Martin Vuille <jpmv27@aim.com> wrote:

> In verbose level 2, errors returned by libdw are reported in most cases,
> but not when calling dwfl_attach_state.
> 
> Since elfutils v 0.160 (2014), dwfl_attach_state sets the error code to
> report failure cause. On failure, log the reported error.
> 
> Signed-off-by: Martin Vuille <jpmv27@aim.com>
> ---

Reviewed-by: Kim Phillips <kim.phillips@arm.com>

Kim
