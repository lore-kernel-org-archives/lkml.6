Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935823AbeEXIA0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:00:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935508AbeEXIAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:00:21 -0400
Date: Thu, 24 May 2018 01:00:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Tejun Heo <tj@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        linux-block <linux-block@vger.kernel.org>, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] block: Create scsi_sense.h for SCSI and ATAPI
Message-ID: <20180524080015.GA2866@infradead.org>
References: <20180522191309.GA23615@infradead.org>
 <8d4af5c4-96fa-54ee-d5c1-b887b1de5a3c@kernel.dk>
 <CAGXu5j+mgGZkTDS6EDRspJKKbU=vMT4ehv9T-SekPba=ESoGDg@mail.gmail.com>
 <9A0BC289-4203-4C77-A012-AAB07F42061F@kernel.dk>
 <CAGXu5jJsGWDsZNDJvUUqncSaAcvond_B_J7=BbvVW0X3r6Sxww@mail.gmail.com>
 <aa150272-ffeb-fb8f-7303-0d9502cf9a71@kernel.dk>
 <20180523142545.GA16248@infradead.org>
 <24d36869-e037-042d-cb16-20a81b34eb76@kernel.dk>
 <CAGXu5jJn=1Rz=D8VUwv_VoaGoLtaD=+tcPZxQxntweZoZwFa5Q@mail.gmail.com>
 <f4eb4cd5-8976-3990-69b0-26cca054aa45@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4eb4cd5-8976-3990-69b0-26cca054aa45@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 03:14:19PM -0600, Jens Axboe wrote:
> Ugh, so that would necessitate a change there too. As I said before,
> I don't really care where it lives. I know the SCSI folks seem bothered
> by moving it, but in reality, it's not like this stuff will likely ever
> really change. Of the two choices (select entire SCSI stack, or just move
> this little bit), I know what I would consider the saner option...

Oh well.  How about something like this respin of Kees' series?

http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/sense-cleanup
