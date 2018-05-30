Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932154AbeE3Sz4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 14:55:56 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:55231 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932112AbeE3Szv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 14:55:51 -0400
X-Google-Smtp-Source: ADUXVKKEfeGaH7iQI//Uue1YjByDvuzH2iUuuOYfO4du7+si3QHubcCMMcWB4INgJqSIumwlPwuKPg==
Subject: Re: [PATCH 00/13] convert block layer to bioset_init()/mempool_init()
To: Mike Snitzer <snitzer@redhat.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        hch@infradead.org, colyli@suse.de, darrick.wong@oracle.com, clm@fb.com,
        bacik@fb.com, linux-xfs@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-btrfs@vger.kernel.org, linux-raid@vger.kernel.org,
        neilb@suse.com
References: <20180521143132.GB19194@redhat.com>
 <2bbeeb1a-8b99-b06a-eb9b-eb8523c16460@kernel.dk>
 <20180521144703.GA19303@redhat.com>
 <4b343aef-e11c-73ba-1d88-7e73ca838cad@kernel.dk>
 <20180521150439.GA19379@redhat.com>
 <61e30dcf-a01c-f47d-087a-12930caf9aef@kernel.dk>
 <20180521151817.GA19454@redhat.com>
 <d01a150a-7752-f6ce-78f2-17a65c1e6fa5@kernel.dk>
 <20180521160907.GA19553@redhat.com>
 <f9e3714c-b7c9-d5f6-4018-2a87dd5babb2@kernel.dk>
 <20180530133629.GC5157@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f654ad69-aa90-9580-4731-a05d0604f353@kernel.dk>
Date: Wed, 30 May 2018 12:55:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180530133629.GC5157@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/18 7:36 AM, Mike Snitzer wrote:
> So revisiting this patchset: are you inclined to take these changes (I
> assume yes)?  If so, what would you need in order to get them staged for
> 4.18?  I'll start with offering my review in reply to the DM patch.  I'd
> much prefer to see this level of change go in sooner rather than later.

Yeah I'd like to take the changes, but we might have to wait for
4.19 at this point. It'd certainly help to have the dm bits reviewed,
as they are some of the larger ones. The grunt of the others are mostly
trivial and smaller in scope.

-- 
Jens Axboe
