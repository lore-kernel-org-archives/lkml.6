Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeERRg3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 13:36:29 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:40005 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeERRg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 13:36:26 -0400
X-Google-Smtp-Source: AB8JxZpYWDSseNxxpnlT8QS6rQ65gvHUCrypDaMgnj4i4p216kSNCXIADtcBGGpvs+cTtyDHCEadHw==
Date: Fri, 18 May 2018 13:36:21 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 02/10] block: Convert bio_set to mempool_init()
Message-ID: <20180518173621.GA31737@kmo-pixel>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
 <20180509013358.16399-3-kent.overstreet@gmail.com>
 <20180518162028.GA25227@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518162028.GA25227@infradead.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 09:20:28AM -0700, Christoph Hellwig wrote:
> On Tue, May 08, 2018 at 09:33:50PM -0400, Kent Overstreet wrote:
> > Minor performance improvement by getting rid of pointer indirections
> > from allocation/freeing fastpaths.
> 
> Can you please also send a long conversion for the remaining
> few bioset_create users?  It would be rather silly to keep two
> almost the same interfaces around for just about two hand full
> of users.

Yeah, I can do that
