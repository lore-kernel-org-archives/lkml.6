Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034480AbeE1Pcp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:32:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:35812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033072AbeE1PcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:32:17 -0400
Date: Mon, 28 May 2018 06:12:09 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org,
        tgraf@suug.ch, manfred@colorfullife.com,
        guillaume.knispel@supersonicimagine.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/6] lib/rhashtable: convert param sanitations to WARN_ON
Message-ID: <20180528131209.mt4ythkapvfvykc7@linux-n805>
References: <20180524211135.27760-1-dave@stgolabs.net>
 <20180524211135.27760-2-dave@stgolabs.net>
 <20180528094048.etqeu2ubc227qrxf@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180528094048.etqeu2ubc227qrxf@gondor.apana.org.au>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 May 2018, Herbert Xu wrote:
>I don't really see why we need these WARN_ONs.  The problem should
>be quite obvious when you're writing your code.
>
>If you really want them perhaps add them to the ipc code instead?

Well, I don't really _want_ them; nor does the ipc code which already
does a WARN_ON() (but that goes away in future patches). What I want
is to get rid of the return path. So I don't really care if we convert
them to WARN or remove them altogether. Would you be happy with the
later?

Thanks,
Davidlohr
