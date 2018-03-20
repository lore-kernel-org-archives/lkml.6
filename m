Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeCTQSd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:18:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbeCTQS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:18:29 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96EA121770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 20 Mar 2018 13:18:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Kim Phillips <kim.phillips@arm.com>
Cc: Martin Vuille <jpmv27@aim.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] perf unwind: Report error from dwfl_attach_state
Message-ID: <20180320161826.GA4229@kernel.org>
References: <20180318175053.4222-1-jpmv27@aim.com>
 <20180320080633.10e8414475a534ce9cf26c28@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320080633.10e8414475a534ce9cf26c28@arm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 20, 2018 at 08:06:33AM +0800, Kim Phillips escreveu:
> On Sun, 18 Mar 2018 13:50:53 -0400
> Martin Vuille <jpmv27@aim.com> wrote:
> 
> > In verbose level 2, errors returned by libdw are reported in most cases,
> > but not when calling dwfl_attach_state.
> > 
> > Since elfutils v 0.160 (2014), dwfl_attach_state sets the error code to
> > report failure cause. On failure, log the reported error.
> > 
> > Signed-off-by: Martin Vuille <jpmv27@aim.com>
> > ---
> 
> Reviewed-by: Kim Phillips <kim.phillips@arm.com>

Thanks, applied.

- Arnaldo
