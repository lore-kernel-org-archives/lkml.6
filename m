Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752918AbeDMOd2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:33:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752234AbeDMOd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:33:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5AC2177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 13 Apr 2018 11:33:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Some minor fixes for perf user tools
Message-ID: <20180413143323.GA26496@kernel.org>
References: <20180406203812.3087-1-andi@firstfloor.org>
 <20180413131309.GH28241@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413131309.GH28241@krava>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 13, 2018 at 03:13:09PM +0200, Jiri Olsa escreveu:
> On Fri, Apr 06, 2018 at 01:38:08PM -0700, Andi Kleen wrote:
> > This patchkit fixes some random minor issues in the perf user tools
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo
