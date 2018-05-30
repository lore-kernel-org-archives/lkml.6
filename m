Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932226AbeE3Ti4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 15:38:56 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36036 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932094AbeE3Tiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 15:38:52 -0400
X-Google-Smtp-Source: ADUXVKK2Rgn+3wONEHqKYYnSaXBMCF7zx1VpHMIecRhzsh+qMaY9+NOYwKOaTq5MyNyz+E7RmszzOg==
Subject: Re: [PATCH 00/13] convert block layer to bioset_init()/mempool_init()
To: Mike Snitzer <snitzer@redhat.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        hch@infradead.org, colyli@suse.de, darrick.wong@oracle.com, clm@fb.com,
        bacik@fb.com, linux-xfs@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-btrfs@vger.kernel.org, linux-raid@vger.kernel.org,
        neilb@suse.com
References: <20180521144703.GA19303@redhat.com>
 <4b343aef-e11c-73ba-1d88-7e73ca838cad@kernel.dk>
 <20180521150439.GA19379@redhat.com>
 <61e30dcf-a01c-f47d-087a-12930caf9aef@kernel.dk>
 <20180521151817.GA19454@redhat.com>
 <d01a150a-7752-f6ce-78f2-17a65c1e6fa5@kernel.dk>
 <20180521160907.GA19553@redhat.com>
 <f9e3714c-b7c9-d5f6-4018-2a87dd5babb2@kernel.dk>
 <20180530133629.GC5157@redhat.com>
 <f654ad69-aa90-9580-4731-a05d0604f353@kernel.dk>
 <20180530193707.GB6568@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5f32b2e7-859b-42f9-c726-115ba5ff22a9@kernel.dk>
Date: Wed, 30 May 2018 13:38:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180530193707.GB6568@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/18 1:37 PM, Mike Snitzer wrote:
> On Wed, May 30 2018 at  2:55pm -0400,
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> On 5/30/18 7:36 AM, Mike Snitzer wrote:
>>> So revisiting this patchset: are you inclined to take these changes (I
>>> assume yes)?  If so, what would you need in order to get them staged for
>>> 4.18?  I'll start with offering my review in reply to the DM patch.  I'd
>>> much prefer to see this level of change go in sooner rather than later.
>>
>> Yeah I'd like to take the changes, but we might have to wait for
>> 4.19 at this point. It'd certainly help to have the dm bits reviewed,
>> as they are some of the larger ones. The grunt of the others are mostly
>> trivial and smaller in scope.
> 
> I _really_ would like to see this land for 4.18.  It'll avoid downstream
> backport problems (due to all the churn in this patchset).
> 
> As I'm sure you've seen I reviewed and Acked-by the DM patch.
> 
> I mentioned I've been chatting with Kent, he is available if anything
> needs a v2 for whatever reason.
> 
> Would you be OK adding a single sentence description to each driver's
> patch header (rather than leaving empty like how Kent submitted)?  Or
> should Kent resubmit the entire set with that boilerplate header for
> each patch?

See previous email for both questions :)

-- 
Jens Axboe
