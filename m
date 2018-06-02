Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeFBB72 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 21:59:28 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35640 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbeFBB70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 21:59:26 -0400
X-Google-Smtp-Source: ADUXVKKrfaPHJTBESJDVOe8eUVrDY2CkbkE8q/TcpTeVVZZ2r3ik/PiRb1CSf049LylEa5cXVWIizA==
Date: Fri, 1 Jun 2018 21:59:22 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Shaohua Li <shli@fb.com>,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        dm-devel@redhat.com,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>
Subject: Re: [bisect BUG] dm-crypt percpu counter warnings and invalid kernel
 paging request at virtual address
Message-ID: <20180602015922.GA28891@kmo-pixel>
References: <CAJKOXPfSbsu0RGTUFfb+t_uOvQQxa0uDn-nsG+1uuKAq56nVXA@mail.gmail.com>
 <20180601223557.GA25942@kmo-pixel>
 <220a69e1-f1ed-a878-3ab7-de4cea1239fa@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <220a69e1-f1ed-a878-3ab7-de4cea1239fa@kernel.dk>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 06:50:13PM -0600, Jens Axboe wrote:
> Nevermind that for now, do you have a fix for the issue reported?

Yeah, but let me look over it again tomorrow when I'm sober before I send it out
