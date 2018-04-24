Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbeDXTel (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 15:34:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750791AbeDXTek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 15:34:40 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFC321774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 24 Apr 2018 16:34:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Documentation: Support for asciidoctor
Message-ID: <20180424193436.GF4427@kernel.org>
References: <20180424150456.17353-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424150456.17353-1-tiwai@suse.de>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 24, 2018 at 05:04:56PM +0200, Takashi Iwai escreveu:
> asciidoc seems behind the recent big wave of python3 conversion, and
> we were advised to switch to asciidoctor instead.  It's almost
> compatible but some extensions used for perf documentation don't work
> with it.  Here is the patch to cover them, and add the proper support
> for asciidoctor.
> 
> Pass USE_ASCIIDOCTOR=yes to make for using asciidoctor instead of
> asciidoc.  The man source and manual attributes are passed via command
> options.  The support for these attributes have been fixed in the
> latest asciidoctor code.
> 
> Since asciidoctor can covert to a man page and an HTML directly, we
> can omit the dependency on xmlto when USE_ASCIIDOCTOR is set.

Applied to perf/core,

- Arnaldo
